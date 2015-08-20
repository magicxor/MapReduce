unit MapParallel;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TIndexedRecord<T> = record
  private
    FIndex: Integer;
    FValue: T;
  public
    constructor Create(AIndex: Integer; AValue: T);
  end;

  TMapParallel<T> = class

  strict private
  type
    TForEachRef    = reference to procedure(var X: T; const I: Integer; var Done: Boolean);
    TMapRef        = reference to function(const X: T; const I: Integer): T;
    TFilterRef     = reference to function(const X: T; const I: Integer): Boolean;
    TPredicateRef  = reference to function(const X: T): Boolean;
    TReduceRef     = reference to function(const Accumulator: T; const X: T; const I: Integer): T;
    TIndexedRecord = TIndexedRecord<T>;
  class procedure AddToThreadList(AItem: TIndexedRecord;
    AThreadList: TThreadList<TIndexedRecord>); static;

  public
    class function Map(const Source: TArray<T>; const Lambda: TMapRef): TArray<T>; overload; static;
    // class function Map(const Source: array of T; const Lambda: TMapRef): TArray<T>; overload; static;

    class function Filter(const Source: TArray<T>; const Lambda: TFilterRef): TArray<T>;
      overload; static;
    // class function Filter(const Source: array of T; const Lambda: TFilterRef): TArray<T>; overload; static;

    class function Every(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
      overload; static;
    // class function Every(const Source: array of T; const Lambda: TPredicateRef): Boolean; overload; static;

    class function Some(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
      overload; static;
    // class function Some(const Source: array of T; const Lambda: TPredicateRef): Boolean; overload; static;
  end;

implementation

uses System.Threading, System.SyncObjs, System.Classes, System.Generics.Defaults;

{ TIndexedRecord<T>}

constructor TIndexedRecord<T>.Create(AIndex: Integer; AValue: T);
begin
  FIndex := AIndex;
  FValue := AValue;
end;

{ TMapParallel<T> }

class procedure TMapParallel<T>.AddToThreadList(AItem: TIndexedRecord;
  AThreadList: TThreadList<TIndexedRecord>);
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
// class function TMapParallel<T>.Map(const Source: array of T; const Lambda: TMapRef): TArray<T>;
// {$Include Map}

class function TMapParallel<T>.Filter(const Source: TArray<T>; const Lambda: TFilterRef): TArray<T>;
{$INCLUDE Filter}
// class function TMapParallel<T>.Filter(const Source: array of T; const Lambda: TFilterRef): TArray<T>;
// {$Include Filter}

class function TMapParallel<T>.Every(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
{$INCLUDE Every}
// class function TMapParallel<T>.Every(const Source: array of T; const Lambda: TPredicateRef): Boolean;
// {$Include Every}

class function TMapParallel<T>.Some(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
{$INCLUDE Some}
// class function TMapParallel<T>.Some(const Source: array of T; const Lambda: TPredicateRef): Boolean;
// {$Include Some}

end.
