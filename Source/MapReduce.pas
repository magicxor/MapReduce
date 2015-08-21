unit MapReduce;

interface

uses
  SysUtils;

type
  TMapReduce<T> = class
  strict private
  type
    TForEachRef   = reference to procedure(var X: T; const I: Integer; var Done: Boolean);
    TMapRef       = reference to function(const X: T; const I: Integer): T;
    TFilterRef    = reference to function(const X: T; const I: Integer): Boolean;
    TPredicateRef = reference to function(const X: T): Boolean;
    TReduceRef    = reference to function(const Accumulator: T; const X: T; const I: Integer): T;
  public
    class procedure ForEachArrChange(var Source: TArray<T>; const Lambda: TForEachRef); overload; static;
    class procedure ForEachArrChange(var Source: array of T; const Lambda: TForEachRef); overload; static;

    class function MapToArr(const Source: IEnumerable<T>; const Lambda: TMapRef): TArray<T>; static;
    class function Map(const Source: TArray<T>; const Lambda: TMapRef): TArray<T>; overload; static;
    class function Map(const Source: array of T; const Lambda: TMapRef): TArray<T>; overload; static;

    class function FilterToArr(const Source: IEnumerable<T>; const Lambda: TFilterRef): TArray<T>; static;
    class function Filter(const Source: TArray<T>; const Lambda: TFilterRef): TArray<T>; overload; static;
    class function Filter(const Source: array of T; const Lambda: TFilterRef): TArray<T>; overload; static;

    class function Every(const Source: IEnumerable<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Every(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Every(const Source: array of T; const Lambda: TPredicateRef): Boolean; overload; static;

    class function Some(const Source: IEnumerable<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Some(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean; overload; static;
    class function Some(const Source: array of T; const Lambda: TPredicateRef): Boolean; overload; static;

    class function Reduce(const Source: IEnumerable<T>; const Init: T; const Lambda: TReduceRef): T; overload; static;
    class function Reduce(const Source: TArray<T>; const Init: T; const Lambda: TReduceRef): T; overload; static;
    class function Reduce(const Source: array of T; const Init: T; const Lambda: TReduceRef): T; overload; static;
  end;

  TMapReduce<T, R> = class (TMapReduce<T>)
  strict private
  type
    TMapToRef      = reference to function(const X: T; const I: Integer): R;
  public
    class function MapToArr(const Source: IEnumerable<T>; const Lambda: TMapToRef): TArray<R>; static;
    class function Map(const Source: TArray<T>; const Lambda: TMapToRef): TArray<R>; overload; static;
    class function Map(const Source: array of T; const Lambda: TMapToRef): TArray<R>; overload; static;
  end;

implementation

class procedure TMapReduce<T>.ForEachArrChange(var Source: TArray<T>; const Lambda: TForEachRef);
{$Include ForEach}
class procedure TMapReduce<T>.ForEachArrChange(var Source: array of T; const Lambda: TForEachRef);
{$Include ForEach}

class function TMapReduce<T>.MapToArr(const Source: IEnumerable<T>; const Lambda: TMapRef): TArray<T>;
{$Include Map}
class function TMapReduce<T>.Map(const Source: TArray<T>; const Lambda: TMapRef): TArray<T>;
{$Include Map}
class function TMapReduce<T>.Map(const Source: array of T; const Lambda: TMapRef): TArray<T>;
{$Include Map}
class function TMapReduce<T, R>.MapToArr(const Source: IEnumerable<T>; const Lambda: TMapToRef): TArray<R>;
{$Include Map}
class function TMapReduce<T, R>.Map(const Source: TArray<T>; const Lambda: TMapToRef): TArray<R>;
{$Include Map}
class function TMapReduce<T, R>.Map(const Source: array of T; const Lambda: TMapToRef): TArray<R>;
{$Include Map}

class function TMapReduce<T>.FilterToArr(const Source: IEnumerable<T>; const Lambda: TFilterRef): TArray<T>;
{$Include Filter}
class function TMapReduce<T>.Filter(const Source: TArray<T>; const Lambda: TFilterRef): TArray<T>;
{$Include Filter}
class function TMapReduce<T>.Filter(const Source: array of T; const Lambda: TFilterRef): TArray<T>;
{$Include Filter}

class function TMapReduce<T>.Every(const Source: IEnumerable<T>; const Lambda: TPredicateRef): Boolean;
{$Include Every}
class function TMapReduce<T>.Every(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
{$Include Every}
class function TMapReduce<T>.Every(const Source: array of T; const Lambda: TPredicateRef): Boolean;
{$Include Every}

class function TMapReduce<T>.Some(const Source: IEnumerable<T>; const Lambda: TPredicateRef): Boolean;
{$Include Some}
class function TMapReduce<T>.Some(const Source: TArray<T>; const Lambda: TPredicateRef): Boolean;
{$Include Some}
class function TMapReduce<T>.Some(const Source: array of T; const Lambda: TPredicateRef): Boolean;
{$Include Some}

class function TMapReduce<T>.Reduce(const Source: IEnumerable<T>; const Init: T; const Lambda: TReduceRef): T;
{$Include Reduce}
class function TMapReduce<T>.Reduce(const Source: TArray<T>; const Init: T; const Lambda: TReduceRef): T;
{$Include Reduce}
class function TMapReduce<T>.Reduce(const Source: array of T; const Init: T; const Lambda: TReduceRef): T;
{$Include Reduce}

end.
