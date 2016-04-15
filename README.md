# MapReduce
Routines that use higher-order functions to perform some tasks.

Non-parallel: Mutable ForEach, Immutable ForEach, Map, Filter, Every, Some, Reduce.

Parallel: Map, Filter, Every, Some.

### Usage

```delphi
procedure TestMap();
var
  ResultArr: TArray<string>;
begin
  ResultArr := TMapReduce<string>.Map(['white', 'black', 'ginger'],
                function(const X: string): string
                begin
                  Result := X + ' cat';
                end);
  // ResultArr = ('white cat', 'black cat', 'ginger cat')
end;
```

```delphi
procedure TestReduce();
var
  ResultStr: string;
begin
  ResultStr := TMapReduce<string>.Reduce(['white', 'black', 'ginger'], string.Empty,
                function(const Accumulator: string; const X: string): string
                begin
                  Result := Accumulator + X + ' cat, '
                end)
                .TrimRight([',', ' ']);
  // ResultStr = 'white cat, black cat, ginger cat'
end;
```

And so on.

### Compilation guide

In order to compile this sources on Windows, you need to install the Embarcadero RAD Studio XE8 environment (or higher).