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
{$INCLUDE Filter}
class function TMapParallel<T>.Every(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
{$INCLUDE Every}
class function TMapParallel<T>.Some(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
{$INCLUDE Some}

end.
