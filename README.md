# MapReduce / ArrayLinq

Methods that use higher-order functions to perform some tasks:

Every, Some, Filter, Map, FlatMap, Reduce, ForEach, Order, FirstOrDefault

### Usage

v0.2:

```delphi
myPet := TArrayContainer<TCat>
  .Create([TCat.Create('Tiger', 10, 'black', True),
    TCat.Create('Kitty', 7, 'ginger', True),
    TCat.Create('Simba', 9, 'white', True),
    TCat.Create('Barsik', 6, 'gray', False),
    TCat.Create('Sam', 8, 'white', True),
    TCat.Create('Musya', 5, 'black', True)])
  .Filter(function(const x: TCat): boolean begin exit((x.Weight > 5) and (x.HasTail)); end)
  .Map<string>(function(const x: TCat): string begin exit(x.Name); end)
  .Order()
  .FirstOrDefault(function(const x: string): boolean begin exit(x.StartsWith('S')) end);

Writeln('Your pet is ' + myPet); // Sam
```

v0.1:

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

### Compilation guide

In order to compile this code on Windows, you need to install the Embarcadero RAD Studio XE8 (or higher).

See also: [RAD Studio docker images](https://github.com/magicxor/radstudio-docker)
