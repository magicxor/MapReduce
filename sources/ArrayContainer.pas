unit ArrayContainer;

interface

uses
  System.Generics.Collections, System.Generics.Defaults;

type
  TArrayContainer<T> = record
  private
    type
      TForEachIndRef<S> = reference to function(const X: S; const I: Integer): Boolean;
      TForEachRef<S> = reference to function(const X: S): Boolean;
      TForEachAltRef<S> = reference to procedure(const X: S);
      TMapIndRef<S> = reference to function(const X: S; const I: Integer): S;
      TMapRef<S> = reference to function(const X: S): S;
      TMapIndToRef<S, R> = reference to function(const X: S; const I: Integer): R;
      TMapToRef<S, R> = reference to function(const X: S): R;
      TFlatMapIndToRef<S, R> = reference to function(const X: S; const I: Integer): TArray<R>;
      TFlatMapToRef<S, R> = reference to function(const X: S): TArray<R>;
      TFilterIndRef<S> = reference to function(const X: S; const I: Integer): Boolean;
      TFilterRef<S> = reference to function(const X: S): Boolean;
      TPredicateRef<S> = reference to function(const X: S): Boolean;
      TReduceIndRef<S> = reference to function(const Accumulator: S; const X: S; const I: Integer): S;
      TReduceRef<S> = reference to function(const Accumulator: S; const X: S): S;
      TReduceIndToRef<S, R> = reference to function(const Accumulator: R; const X: S; const I: Integer): R;
      TReduceToRef<S, R> = reference to function(const Accumulator: R; const X: S): R;
    var
      Data: TArray<T>;
  public
    class function Create(const Source: TArray<T>): TArrayContainer<T>; static;
    function ToArray(): TArray<T>;

    function Every(const Lambda: TPredicateRef<T>): Boolean; overload;
    function Filter(const Lambda: TFilterRef<T>): TArrayContainer<T>; overload;
    function Filter(const Lambda: TFilterIndRef<T>): TArrayContainer<T>; overload;
    function FlatMap<R>(const Lambda: TFlatMapToRef<T, R>): TArrayContainer<R>; overload;
    function FlatMap<R>(const Lambda: TFlatMapIndToRef<T, R>): TArrayContainer<R>; overload;
    procedure ForEach(const Lambda: TForEachAltRef<T>); overload;
    procedure ForEach(const Lambda: TForEachIndRef<T>); overload;
    procedure ForEach(const Lambda: TForEachRef<T>); overload;
    function Map<R>(const Lambda: TMapToRef<T, R>): TArrayContainer<R>; overload;
    function Map<R>(const Lambda: TMapIndToRef<T, R>): TArrayContainer<R>; overload;
    function Map(const Lambda: TMapRef<T>): TArrayContainer<T>; overload;
    function Map(const Lambda: TMapIndRef<T>): TArrayContainer<T>; overload;
    function Reduce<R>(const Init: R; const Lambda: TReduceToRef<T, R>): R; overload;
    function Reduce<R>(const Init: R; const Lambda: TReduceIndToRef<T, R>): R; overload;
    function Reduce(const Lambda: TReduceIndRef<T>): T; overload;
    function Reduce(const Lambda: TReduceRef<T>): T; overload;
    function Reduce(const Init: T; const Lambda: TReduceIndRef<T>): T; overload;
    function Reduce(const Init: T; const Lambda: TReduceRef<T>): T; overload;
    function Some(const Lambda: TPredicateRef<T>): Boolean; overload;
    function Order(): TArrayContainer<T>; overload;
    function Order(const Comparer: IComparer<T>): TArrayContainer<T>; overload;
    function FirstOrDefault(): T; overload;
    function FirstOrDefault(const Lambda: TPredicateRef<T>): T; overload;
  end;

implementation

class function TArrayContainer<T>.Create(const Source: TArray<T>): TArrayContainer<T>;
begin
  Result.Data := Source;
end;

function TArrayContainer<T>.ToArray: TArray<T>;
begin
  Exit(Self.Data);
end;

function TArrayContainer<T>.Every(const Lambda: TPredicateRef<T>): Boolean;
var
  X: T;
begin
  for X in Self.Data do
    if not Lambda(X) then
      Exit(False);
  Exit(True);
end;

function TArrayContainer<T>.Filter(const Lambda: TFilterRef<T>): TArrayContainer<T>;
var
  X: T;
  ResultArray: TArray<T>;
begin
  ResultArray := [];
  for X in Self.Data do
    if Lambda(X) then
      ResultArray := ResultArray + [X];
  Exit(TArrayContainer<T>.Create(ResultArray));
end;

function TArrayContainer<T>.Filter(const Lambda: TFilterIndRef<T>): TArrayContainer<T>;
var
  I: Integer;
  X: T;
  ResultArray: TArray<T>;
begin
  ResultArray := [];
  I := 0;
  for X in Self.Data do
  begin
    if Lambda(X, I) then
      ResultArray := ResultArray + [X];
    Inc(I);
  end;
  Exit(TArrayContainer<T>.Create(ResultArray));
end;

function TArrayContainer<T>.FlatMap<R>(const Lambda: TFlatMapIndToRef<T, R>): TArrayContainer<R>;
var
  I: Integer;
  X: T;
  ResultArray: TArray<R>;
begin
  ResultArray := [];
  I := 0;
  for X in Self.Data do
  begin
    ResultArray := ResultArray + Lambda(X, I);
    Inc(I);
  end;
  Exit(TArrayContainer<R>.Create(ResultArray));
end;

function TArrayContainer<T>.FlatMap<R>(const Lambda: TFlatMapToRef<T, R>): TArrayContainer<R>;
var
  X: T;
  ResultArray: TArray<R>;
begin
  ResultArray := [];
  for X in Self.Data do
    ResultArray := ResultArray + Lambda(X);
  Exit(TArrayContainer<R>.Create(ResultArray));
end;

procedure TArrayContainer<T>.ForEach(const Lambda: TForEachAltRef<T>);
var
  X: T;
begin
  for X in Self.Data do
    Lambda(X);
end;

procedure TArrayContainer<T>.ForEach(const Lambda: TForEachIndRef<T>);
var
  I: Integer;
  X: T;
begin
  I := 0;
  for X in Self.Data do
  begin
    if Lambda(X, I) then
      Break;
    Inc(I);
  end;
end;

procedure TArrayContainer<T>.ForEach(const Lambda: TForEachRef<T>);
var
  X: T;
begin
  for X in Self.Data do
    if Lambda(X) then
      Break;
end;

function TArrayContainer<T>.Map<R>(const Lambda: TMapToRef<T, R>): TArrayContainer<R>;
var
  X: T;
  ResultArray: TArray<R>;
begin
  ResultArray := [];
  for X in Self.Data do
    ResultArray := ResultArray + [Lambda(X)];
  Exit(TArrayContainer<R>(ResultArray));
end;

function TArrayContainer<T>.Map<R>(const Lambda: TMapIndToRef<T, R>): TArrayContainer<R>;
var
  I: Integer;
  X: T;
  ResultArray: TArray<R>;
begin
  ResultArray := [];
  I := 0;
  for X in Self.Data do
  begin
    ResultArray := ResultArray + [Lambda(X, I)];
    Inc(I);
  end;
  Exit(TArrayContainer<R>(ResultArray));
end;

function TArrayContainer<T>.Map(const Lambda: TMapRef<T>): TArrayContainer<T>;
var
  X: T;
  ResultArray: TArray<T>;
begin
  ResultArray := [];
  for X in Self.Data do
    ResultArray := ResultArray + [Lambda(X)];
  Exit(TArrayContainer<T>.Create(ResultArray));
end;

function TArrayContainer<T>.Map(const Lambda: TMapIndRef<T>): TArrayContainer<T>;
var
  I: Integer;
  X: T;
  ResultArray: TArray<T>;
begin
  ResultArray := [];
  I := 0;
  for X in Self.Data do
  begin
    ResultArray := ResultArray + [Lambda(X, I)];
    Inc(I);
  end;
  Exit(TArrayContainer<T>.Create(ResultArray));
end;

function TArrayContainer<T>.Reduce<R>(const Init: R; const Lambda: TReduceToRef<T, R>): R;
var
  X: T;
begin
  Result := Init;
  for X in Self.Data do
    Result := Lambda(Result, X);
end;

function TArrayContainer<T>.Reduce<R>(const Init: R; const Lambda: TReduceIndToRef<T, R>): R;
var
  I: Integer;
  X: T;
begin
  Result := Init;
  I := 0;
  for X in Self.Data do
  begin
    Result := Lambda(Result, X, I);
    Inc(I);
  end;
end;

function TArrayContainer<T>.Reduce(const Lambda: TReduceIndRef<T>): T;
var
  I: Integer;
  X: T;
  DataArray: TArray<T>;
begin
  DataArray := Self.Data;
  if Length(DataArray) >= 1 then
  begin
    Result := DataArray[Low(DataArray)];
    if Length(DataArray) > 1 then
      for I := Low(DataArray) + 1 to High(DataArray) do
        Result := Lambda(Result, DataArray[I], I);
  end
  else
    Exit(Default(T));
end;

function TArrayContainer<T>.Reduce(const Lambda: TReduceRef<T>): T;
var
  I: Integer;
  X: T;
  DataArray: TArray<T>;
begin
  DataArray := Self.Data;
  if Length(DataArray) >= 1 then
  begin
    Result := DataArray[Low(DataArray)];
    if Length(DataArray) > 1 then
      for I := Low(DataArray) + 1 to High(DataArray) do
        Result := Lambda(Result, DataArray[I]);
  end
  else
    Exit(Default(T));
end;

function TArrayContainer<T>.Reduce(const Init: T; const Lambda: TReduceIndRef<T>): T;
var
  I: Integer;
  X: T;
begin
  Result := Init;
  I := 0;
  for X in Self.Data do
  begin
    Result := Lambda(Result, X, I);
    Inc(I);
  end;
end;

function TArrayContainer<T>.Reduce(const Init: T; const Lambda: TReduceRef<T>): T;
var
  X: T;
begin
  Result := Init;
  for X in Self.Data do
    Result := Lambda(Result, X);
end;

function TArrayContainer<T>.Some(const Lambda: TPredicateRef<T>): Boolean;
var
  X: T;
begin
  for X in Self.Data do
    if Lambda(X) then
      Exit(True);
  Exit(False);
end;

function TArrayContainer<T>.Order: TArrayContainer<T>;
var
  ResultArray: TArray<T>;
begin
  ResultArray := Copy(Self.Data);
  TArray.Sort<T>(ResultArray);
  Result := TArrayContainer<T>.Create(ResultArray);
end;

function TArrayContainer<T>.Order(const Comparer: IComparer<T>): TArrayContainer<T>;
var
  ResultArray: TArray<T>;
begin
  ResultArray := Copy(Self.Data);
  TArray.Sort<T>(ResultArray, Comparer);
  Result := TArrayContainer<T>.Create(ResultArray);
end;

function TArrayContainer<T>.FirstOrDefault(): T;
begin
  if (Length(Self.Data) > 0) then
    Exit(Self.Data[Low(Self.Data)])
  else
    Exit(Default(T));
end;

function TArrayContainer<T>.FirstOrDefault(const Lambda: TPredicateRef<T>): T;
var
  X: T;
begin
  for X in Self.Data do
    if Lambda(X) then
      Exit(X);
  Exit(Default(T));
end;

end.
