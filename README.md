# MapReduce / ArrayLinq

Methods that use higher-order functions to perform some tasks:

Every, Some, Filter, Map, FlatMap, Reduce, ForEach, Order, FirstOrDefault

(LINQ analogs: All, Any, Where, Select, SelectMany, Aggregate, ForEach, OrderBy, FirstOrDefault)

### Usage

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

### Compilation guide

In order to compile this code on Windows, you need to install the Embarcadero RAD Studio XE8 (or higher).

See also: [RAD Studio docker images](https://github.com/magicxor/radstudio-docker)
