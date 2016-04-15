unit MapReduce;

interface

uses
  SysUtils, System.Generics.Collections;

type
  TMapReduce<T> = class
  strict private
  type
    TForEachChangeRef  = reference to procedure(var X: T; const I: Integer; var Done: Boolean);
    TForEachChangeLRef = reference to procedure(var X: T);

    TForEachRef     = reference to procedure(const X: T; const I: Integer; var Done: Boolean);
    TForEachLRef    = reference to procedure(const X: T);

    TMapRef         = reference to function(const X: T; const I: Integer): T;
    TMapLRef        = reference to function(const X: T): T;

    TFilterRef      = reference to function(const X: T; const I: Integer): Boolean;
    TFilterLRef     = reference to function(const X: T): Boolean;

    TPredicateRef   = reference to function(const X: T): Boolean;

    TReduceRef      = reference to function(const Accumulator: T; const X: T; const I: Integer): T;
    TReduceLRef     = reference to function(const Accumulator: T; const X: T): T;

    ArrayOfT        = array of T;
  public
    class procedure ForEachArrChange(var Source: TArray<T>; const Lambda: TForEachChangeRef); overload; static;
    class procedure ForEachArrChange(var Source: array of T; const Lambda: TForEachChangeRef); overload; static;
    class procedure ForEachArrChange(var Source: TArray<T>; const Lambda: TForEachChangeLRef); overload; static;
    class procedure ForEachArrChange(var Source: array of T; const Lambda: TForEachChangeLRef); overload; static;

    class procedure ForEach(const Source: IEnumerable<T>; const Lambda: TForEachRef); overload; static;
    class procedure ForEach(const Source: TEnumerable<T>; const Lambda: TForEachRef); overload; static;
    class procedure ForEach(const Source: TArray<T>; const Lambda: TForEachRef); overload; static;
    class procedure ForEach(const Source: array of T; const Lambda: TForEachRef); overload; static;

    class procedure ForEach(const Source: IEnumerable<T>; const Lambda: TForEachLRef); overload; static;
    class procedure ForEach(const Source: TEnumerable<T>; const Lambda: TForEachLRef); overload; static;
    class procedure ForEach(const Source: TArray<T>; const Lambda: TForEachLRef); overload; static;
    class procedure ForEach(const Source: array of T; const Lambda: TForEachLRef); overload; static;

    class function MapToArr(const Source: IEnumerable<T>; const Lambda: TMapRef): TArray<T>; overload; static;
    class function MapToArr(const Source: TEnumerable<T>; const Lambda: TMapRef): TArray<T>; overload; static;
    class function Map(const Source: TArray<T>; const Lambda: TMapRef): TArray<T>; overload; static;
    class function Map(const Source: array of T; const Lambda: TMapRef): ArrayOfT; overload; static;

    class function MapToArr(const Source: IEnumerable<T>; const Lambda: TMapLRef): TArray<T>; overload; static;
    class function MapToArr(const Source: TEnumerable<T>; const Lambda: TMapLRef): TArray<T>; overload; static;
    class function Map(const Source: TArray<T>; const Lambda: TMapLRef): TArray<T>; overload; static;
    class function Map(const Source: array of T; const Lambda: TMapLRef): ArrayOfT; overload; static;

    class function FilterToArr(const Source: IEnumerable<T>; const Lambda: TFilterRef): TArray<T>; overload; static;
    class function FilterToArr(const Source: TEnumerable<T>; const Lambda: TFilterRef): TArray<T>; overload; static;
    class function Filter(const Source: TArray<T>; const Lambda: TFilterRef): TArray<T>; overload; static;
    class function Filter(const Source: array of T; const Lambda: TFilterRef): ArrayOfT; overload; static;

    class function FilterToArr(const Source: IEnumerable<T>; const Lambda: TFilterLRef): TArray<T>; overload; static;
    class function FilterToArr(const Source: TEnumerable<T>; const Lambda: TFilterLRef): TArray<T>; overload; static;
    class function Filter(const Source: TArray<T>; const Lambda: TFilterLRef): TArray<T>; overload; static;
    class function Filter(const Source: array of T; const Lambda: TFilterLRef): ArrayOfT; overload; static;

    class function Every(const Source: IEnumerable<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Every(const Source: TEnumerable<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Every(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Every(const Source: array of T; const Lambda: TPredicateRef): Boolean; overload; static;

    class function Some(const Source: IEnumerable<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Some(const Source: TEnumerable<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Some(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Some(const Source: array of T; const Lambda: TPredicateRef): Boolean; overload; static;

    class function Reduce(const Source: IEnumerable<T>; const Init: T; const Lambda: TReduceRef): T; overload; static;
    class function Reduce(const Source: TEnumerable<T>; const Init: T; const Lambda: TReduceRef): T; overload; static;
    class function Reduce(const Source: TArray<T>; const Init: T; const Lambda: TReduceRef): T; overload; static;
    class function Reduce(const Source: array of T; const Init: T; const Lambda: TReduceRef): T; overload; static;

    class function Reduce(const Source: IEnumerable<T>; const Init: T; const Lambda: TReduceLRef): T; overload; static;
    class function Reduce(const Source: TEnumerable<T>; const Init: T; const Lambda: TReduceLRef): T; overload; static;
    class function Reduce(const Source: TArray<T>; const Init: T; const Lambda: TReduceLRef): T; overload; static;
    class function Reduce(const Source: array of T; const Init: T; const Lambda: TReduceLRef): T; overload; static;

    class function Reduce(const Source: IEnumerable<T>; const Lambda: TReduceRef): T; overload; static;
    class function Reduce(const Source: TEnumerable<T>; const Lambda: TReduceRef): T; overload; static;
    class function Reduce(const Source: TArray<T>; const Lambda: TReduceRef): T; overload; static;
    class function Reduce(const Source: array of T; const Lambda: TReduceRef): T; overload; static;

    class function Reduce(const Source: IEnumerable<T>; const Lambda: TReduceLRef): T; overload; static;
    class function Reduce(const Source: TEnumerable<T>; const Lambda: TReduceLRef): T; overload; static;
    class function Reduce(const Source: TArray<T>; const Lambda: TReduceLRef): T; overload; static;
    class function Reduce(const Source: array of T; const Lambda: TReduceLRef): T; overload; static;
  end;

  TMapReduce<T, R> = class (TMapReduce<T>)
  strict private
  type
    TMapToRef     = reference to function(const X: T; const I: Integer): R;
    TMapToLRef    = reference to function(const X: T): R;

    TReduceToRef  = reference to function(const Accumulator: R; const X: T; const I: Integer): R;
    TReduceToLRef = reference to function(const Accumulator: R; const X: T): R;

    ArrayOfR        = array of R;
  public
    class function MapToArr(const Source: IEnumerable<T>; const Lambda: TMapToRef): TArray<R>; overload; static;
    class function MapToArr(const Source: TEnumerable<T>; const Lambda: TMapToRef): TArray<R>; overload; static;
    class function Map(const Source: TArray<T>; const Lambda: TMapToRef): TArray<R>; overload; static;
    class function Map(const Source: array of T; const Lambda: TMapToRef): ArrayOfR; overload; static;

    class function MapToArr(const Source: IEnumerable<T>; const Lambda: TMapToLRef): TArray<R>; overload; static;
    class function MapToArr(const Source: TEnumerable<T>; const Lambda: TMapToLRef): TArray<R>; overload; static;
    class function Map(const Source: TArray<T>; const Lambda: TMapToLRef): TArray<R>; overload; static;
    class function Map(const Source: array of T; const Lambda: TMapToLRef): ArrayOfR; overload; static;

    class function Reduce(const Source: IEnumerable<T>; const Init: R; const Lambda: TReduceToRef): R; overload; static;
    class function Reduce(const Source: TEnumerable<T>; const Init: R; const Lambda: TReduceToRef): R; overload; static;
    class function Reduce(const Source: TArray<T>; const Init: R; const Lambda: TReduceToRef): R; overload; static;
    class function Reduce(const Source: array of T; const Init: R; const Lambda: TReduceToRef): R; overload; static;

    class function Reduce(const Source: IEnumerable<T>; const Init: R; const Lambda: TReduceToLRef): R; overload; static;
    class function Reduce(const Source: TEnumerable<T>; const Init: R; const Lambda: TReduceToLRef): R; overload; static;
    class function Reduce(const Source: TArray<T>; const Init: R; const Lambda: TReduceToLRef): R; overload; static;
    class function Reduce(const Source: array of T; const Init: R; const Lambda: TReduceToLRef): R; overload; static;
  end;

implementation

//====================================================================================================
// Mutable ForEach
//====================================================================================================
class procedure TMapReduce<T>.ForEachArrChange(var Source: TArray<T>; const Lambda: TForEachChangeRef);
{$Include ForEachChange}
class procedure TMapReduce<T>.ForEachArrChange(var Source: array of T; const Lambda: TForEachChangeRef);
{$Include ForEachChange}

class procedure TMapReduce<T>.ForEachArrChange(var Source: TArray<T>; const Lambda: TForEachChangeLRef);
{$Include ForEachChangeL}
class procedure TMapReduce<T>.ForEachArrChange(var Source: array of T; const Lambda: TForEachChangeLRef);
{$Include ForEachChangeL}
//====================================================================================================


//====================================================================================================
// Immutable ForEach
//====================================================================================================
class procedure TMapReduce<T>.ForEach(const Source: IEnumerable<T>; const Lambda: TForEachRef);
{$Include ForEach}
class procedure TMapReduce<T>.ForEach(const Source: TEnumerable<T>; const Lambda: TForEachRef);
{$Include ForEach}
class procedure TMapReduce<T>.ForEach(const Source: TArray<T>; const Lambda: TForEachRef);
{$Include ForEach}
class procedure TMapReduce<T>.ForEach(const Source: array of T; const Lambda: TForEachRef);
{$Include ForEach}

class procedure TMapReduce<T>.ForEach(const Source: IEnumerable<T>; const Lambda: TForEachLRef);
{$Include ForEachL}
class procedure TMapReduce<T>.ForEach(const Source: TEnumerable<T>; const Lambda: TForEachLRef);
{$Include ForEachL}
class procedure TMapReduce<T>.ForEach(const Source: TArray<T>; const Lambda: TForEachLRef);
{$Include ForEachL}
class procedure TMapReduce<T>.ForEach(const Source: array of T; const Lambda: TForEachLRef);
{$Include ForEachL}
//====================================================================================================


//====================================================================================================
// Map
//====================================================================================================
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~ returns the same type
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class function TMapReduce<T>.MapToArr(const Source: IEnumerable<T>; const Lambda: TMapRef): TArray<T>;
{$Include Map}
class function TMapReduce<T>.MapToArr(const Source: TEnumerable<T>; const Lambda: TMapRef): TArray<T>;
{$Include Map}
class function TMapReduce<T>.Map(const Source: TArray<T>; const Lambda: TMapRef): TArray<T>;
{$Include Map}
class function TMapReduce<T>.Map(const Source: array of T; const Lambda: TMapRef): ArrayOfT;
{$Include Map}

class function TMapReduce<T>.MapToArr(const Source: IEnumerable<T>; const Lambda: TMapLRef): TArray<T>;
{$Include MapL}
class function TMapReduce<T>.MapToArr(const Source: TEnumerable<T>; const Lambda: TMapLRef): TArray<T>;
{$Include MapL}
class function TMapReduce<T>.Map(const Source: TArray<T>; const Lambda: TMapLRef): TArray<T>;
{$Include MapL}
class function TMapReduce<T>.Map(const Source: array of T; const Lambda: TMapLRef): ArrayOfT;
{$Include MapL}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~ returns another type
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class function TMapReduce<T, R>.MapToArr(const Source: IEnumerable<T>; const Lambda: TMapToRef): TArray<R>;
{$Include Map}
class function TMapReduce<T, R>.MapToArr(const Source: TEnumerable<T>; const Lambda: TMapToRef): TArray<R>;
{$Include Map}
class function TMapReduce<T, R>.Map(const Source: TArray<T>; const Lambda: TMapToRef): TArray<R>;
{$Include Map}
class function TMapReduce<T, R>.Map(const Source: array of T; const Lambda: TMapToRef): ArrayOfR;
{$Include Map}

class function TMapReduce<T, R>.MapToArr(const Source: IEnumerable<T>; const Lambda: TMapToLRef): TArray<R>;
{$Include MapL}
class function TMapReduce<T, R>.MapToArr(const Source: TEnumerable<T>; const Lambda: TMapToLRef): TArray<R>;
{$Include MapL}
class function TMapReduce<T, R>.Map(const Source: TArray<T>; const Lambda: TMapToLRef): TArray<R>;
{$Include MapL}
class function TMapReduce<T, R>.Map(const Source: array of T; const Lambda: TMapToLRef): ArrayOfR;
{$Include MapL}
//====================================================================================================


//====================================================================================================
// Filter
//====================================================================================================
class function TMapReduce<T>.FilterToArr(const Source: IEnumerable<T>; const Lambda: TFilterRef): TArray<T>;
{$Include Filter}
class function TMapReduce<T>.FilterToArr(const Source: TEnumerable<T>; const Lambda: TFilterRef): TArray<T>;
{$Include Filter}
class function TMapReduce<T>.Filter(const Source: TArray<T>; const Lambda: TFilterRef): TArray<T>;
{$Include Filter}
class function TMapReduce<T>.Filter(const Source: array of T; const Lambda: TFilterRef): ArrayOfT;
{$Include Filter}

class function TMapReduce<T>.FilterToArr(const Source: IEnumerable<T>; const Lambda: TFilterLRef): TArray<T>;
{$Include FilterL}
class function TMapReduce<T>.FilterToArr(const Source: TEnumerable<T>; const Lambda: TFilterLRef): TArray<T>;
{$Include FilterL}
class function TMapReduce<T>.Filter(const Source: TArray<T>; const Lambda: TFilterLRef): TArray<T>;
{$Include FilterL}
class function TMapReduce<T>.Filter(const Source: array of T; const Lambda: TFilterLRef): ArrayOfT;
{$Include FilterL}
//====================================================================================================


//====================================================================================================
// Every
//====================================================================================================
class function TMapReduce<T>.Every(const Source: IEnumerable<T>; const Lambda: TPredicateRef): Boolean;
{$Include Every}
class function TMapReduce<T>.Every(const Source: TEnumerable<T>; const Lambda: TPredicateRef): Boolean;
{$Include Every}
class function TMapReduce<T>.Every(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
{$Include Every}
class function TMapReduce<T>.Every(const Source: array of T; const Lambda: TPredicateRef): Boolean;
{$Include Every}
//====================================================================================================


//====================================================================================================
// Some
//====================================================================================================
class function TMapReduce<T>.Some(const Source: IEnumerable<T>; const Lambda: TPredicateRef): Boolean;
{$Include Some}
class function TMapReduce<T>.Some(const Source: TEnumerable<T>; const Lambda: TPredicateRef): Boolean;
{$Include Some}
class function TMapReduce<T>.Some(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
{$Include Some}
class function TMapReduce<T>.Some(const Source: array of T; const Lambda: TPredicateRef): Boolean;
{$Include Some}
//====================================================================================================

//====================================================================================================
// Reduce
//====================================================================================================
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~ returns the same type
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//---- With Init
class function TMapReduce<T>.Reduce(const Source: IEnumerable<T>; const Init: T; const Lambda: TReduceRef): T;
{$Include Reduce}
class function TMapReduce<T>.Reduce(const Source: TEnumerable<T>; const Init: T; const Lambda: TReduceRef): T;
{$Include Reduce}
class function TMapReduce<T>.Reduce(const Source: TArray<T>; const Init: T; const Lambda: TReduceRef): T;
{$Include Reduce}
class function TMapReduce<T>.Reduce(const Source: array of T; const Init: T; const Lambda: TReduceRef): T;
{$Include Reduce}

class function TMapReduce<T>.Reduce(const Source: IEnumerable<T>; const Init: T; const Lambda: TReduceLRef): T;
{$Include ReduceL}
class function TMapReduce<T>.Reduce(const Source: TEnumerable<T>; const Init: T; const Lambda: TReduceLRef): T;
{$Include ReduceL}
class function TMapReduce<T>.Reduce(const Source: TArray<T>; const Init: T; const Lambda: TReduceLRef): T;
{$Include ReduceL}
class function TMapReduce<T>.Reduce(const Source: array of T; const Init: T; const Lambda: TReduceLRef): T;
{$Include ReduceL}

//---- Without Init
class function TMapReduce<T>.Reduce(const Source: IEnumerable<T>; const Lambda: TReduceRef): T;
var
  Values: IEnumerator<T>;
  I: Integer;
begin
  Values := Source.GetEnumerator;
  if (Values <> nil) and Values.MoveNext then
  begin
    Result := Values.Current;
    I := 0;
    while Values.MoveNext do
    begin
      Result := Lambda(Result, Values.Current, I);
      Inc(I);
    end;
  end
  else
    raise Exception.Create('IEnumerable<T> is empty');
end;
class function TMapReduce<T>.Reduce(const Source: TEnumerable<T>; const Lambda: TReduceRef): T;
var
  Values: TEnumerator<T>;
  I: Integer;
begin
  Values := Source.GetEnumerator;
  if (Values <> nil) and Values.MoveNext then
  begin
    Result := Values.Current;
    I := 0;
    while Values.MoveNext do
    begin
      Result := Lambda(Result, Values.Current, I);
      Inc(I);
    end;
  end
  else
    raise Exception.Create('IEnumerable<T> is empty');
end;
class function TMapReduce<T>.Reduce(const Source: TArray<T>; const Lambda: TReduceRef): T;
{$Include ReduceAlt}
class function TMapReduce<T>.Reduce(const Source: array of T; const Lambda: TReduceRef): T;
{$Include ReduceAlt}

class function TMapReduce<T>.Reduce(const Source: IEnumerable<T>; const Lambda: TReduceLRef): T;
var
  Values: IEnumerator<T>;
begin
  Values := Source.GetEnumerator;
  if (Values <> nil) and Values.MoveNext then
  begin
    Result := Values.Current;
    while Values.MoveNext do
      Result := Lambda(Result, Values.Current);
  end
  else
    raise Exception.Create('IEnumerable<T> is empty');
end;
class function TMapReduce<T>.Reduce(const Source: TEnumerable<T>; const Lambda: TReduceLRef): T;
var
  Values: TEnumerator<T>;
begin
  Values := Source.GetEnumerator;
  if (Values <> nil) and Values.MoveNext then
  begin
    Result := Values.Current;
    while Values.MoveNext do
      Result := Lambda(Result, Values.Current);
  end
  else
    raise Exception.Create('IEnumerable<T> is empty');
end;
class function TMapReduce<T>.Reduce(const Source: TArray<T>; const Lambda: TReduceLRef): T;
{$Include ReduceAltL}
class function TMapReduce<T>.Reduce(const Source: array of T; const Lambda: TReduceLRef): T;
{$Include ReduceAltL}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~ returns another type:
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class function TMapReduce<T, R>.Reduce(const Source: IEnumerable<T>; const Init: R; const Lambda: TReduceToRef): R;
{$Include Reduce}
class function TMapReduce<T, R>.Reduce(const Source: TEnumerable<T>; const Init: R; const Lambda: TReduceToRef): R;
{$Include Reduce}
class function TMapReduce<T, R>.Reduce(const Source: TArray<T>; const Init: R; const Lambda: TReduceToRef): R;
{$Include Reduce}
class function TMapReduce<T, R>.Reduce(const Source: array of T; const Init: R; const Lambda: TReduceToRef): R;
{$Include Reduce}

class function TMapReduce<T, R>.Reduce(const Source: IEnumerable<T>; const Init: R; const Lambda: TReduceToLRef): R;
{$Include ReduceL}
class function TMapReduce<T, R>.Reduce(const Source: TEnumerable<T>; const Init: R; const Lambda: TReduceToLRef): R;
{$Include ReduceL}
class function TMapReduce<T, R>.Reduce(const Source: TArray<T>; const Init: R; const Lambda: TReduceToLRef): R;
{$Include ReduceL}
class function TMapReduce<T, R>.Reduce(const Source: array of T; const Init: R; const Lambda: TReduceToLRef): R;
{$Include ReduceL}

end.
