unit MapParallel;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TIndexed<T> = record
  private
    FIndex: Integer;
    FValue: T;
  public
    constructor Create(AIndex: Integer; AValue: T);
  end;

  TListWriter<T> = class
  public
    class procedure AddToThreadList(AItem: T; AThreadList: TThreadList<T>); static;
  end;

  TMapParallel<T> = class
  strict private
  type
    TForEachRef    = reference to procedure(var X: T; const I: Integer; var Done: Boolean);
    TMapRef        = reference to function(const X: T; const I: Integer): T;
    TFilterRef     = reference to function(const X: T; const I: Integer): Boolean;
    TPredicateRef  = reference to function(const X: T): Boolean;
    TReduceRef     = reference to function(const Accumulator: T; const X: T; const I: Integer): T;
    TIndexed       = TIndexed<T>;
    TListWriter    = TListWriter<TIndexed>;
  public
    class function Map(const Source: TArray<T>; const Lambda: TMapRef): TArray<T>; static;
    class function Filter(const Source: TArray<T>; const Lambda: TFilterRef): TArray<T>; static;
    class function Every(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean; static;
    class function Some(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean; static;
  end;

  TMapParallel<T, R> = class(TMapParallel<T>)
  strict private
  type
    TMapToRef      = reference to function(const X: T; const I: Integer): R;
    TIndexed       = TIndexed<R>;
    TListWriter    = TListWriter<TIndexed>;
  public
    class function Map(const Source: TArray<T>; const Lambda: TMapToRef): TArray<R>; static;
  end;

implementation

uses System.Threading, System.SyncObjs, System.Classes, System.Generics.Defaults;

constructor TIndexed<T>.Create(AIndex: Integer; AValue: T);
begin
  FIndex := AIndex;
  FValue := AValue;
end;

class procedure TListWriter<T>.AddToThreadList(AItem: T; AThreadList: TThreadList<T>);
begin
  AThreadList.LockList;
  try
    AThreadList.Add(AItem);
  finally
    AThreadList.UnlockList;
  end;
end;

class function TMapParallel<T>.Map(const Source: TArray<T>; const Lambda: TMapRef): TArray<T>;
{$INCLUDE Map}
class function TMapParallel<T, R>.Map(const Source: TArray<T>; const Lambda: TMapToRef): TArray<R>;
{$INCLUDE Map}

class function TMapParallel<T>.Filter(const Source: TArray<T>; const Lambda: TFilterRef): TArray<T>;
var
  ThreadList: TThreadList<TIndexed>;
  FinalList: TList<TIndexed>;
  Comparison: TComparison<TIndexed>;
  TmpIndexedRecord: TIndexed;
begin
  Result := [];
  // Thread-safe unordered storage
  ThreadList := TThreadList<TIndexed>.Create;
  try
    ThreadList.Duplicates := dupAccept;

    // do the job
    TParallel.For(low(Source), high(Source),
      procedure(AIndex: Integer; ALoopState: TParallel.TLoopState)
      begin
        // add item to the ThreadList
        if Lambda(Source[AIndex], AIndex) then
          TListWriter.AddToThreadList(TIndexed.Create(AIndex, Source[AIndex]), ThreadList);
      end);

    // not-thread-safe ordered storage
    FinalList := ThreadList.LockList;
    try
      // specify the comparer
      Comparison := function(const Left: TIndexed; const Right: TIndexed): Integer
        begin
          Result := TComparer<Integer>.Default.Compare(Left.FIndex, Right.FIndex);
        end;
      // sort list by the comparer
      FinalList.Sort(TComparer<TIndexed>.Construct(Comparison));
      // put list items to the result array
      for TmpIndexedRecord in FinalList do
        Result := Result + [TmpIndexedRecord.FValue];
    finally
      ThreadList.UnlockList;
    end;

  finally
    FreeAndNil(ThreadList);
  end;
end;

class function TMapParallel<T>.Every(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
var
  ResultValue: Integer;
begin
  ResultValue := 1;
  TParallel.For(low(Source), high(Source),
    procedure(AIndex: Integer; ALoopState: TParallel.TLoopState)
    begin
      if not Lambda(Source[AIndex]) then
      begin
        TInterlocked.Exchange(ResultValue, 0);
        ALoopState.Break; // .Stop ???
      end;
    end);
  Result := ResultValue.ToBoolean;
end;

class function TMapParallel<T>.Some(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
var
  ResultValue: Integer;
begin
  ResultValue := 0;
  TParallel.For(low(Source), high(Source),
    procedure(AIndex: Integer; ALoopState: TParallel.TLoopState)
    begin
      if Lambda(Source[AIndex]) then
      begin
        TInterlocked.Exchange(ResultValue, 1);
        ALoopState.Break; // .Stop ???
      end;
    end);
  Result := ResultValue.ToBoolean;
end;

end.
