program ArrayLinqSamples;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  ArrayContainer in '..\sources\ArrayContainer.pas',
  Cat in 'Cat.pas';

var myPet: string;

begin
  try
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

    Writeln('Your pet is ' + myPet);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
