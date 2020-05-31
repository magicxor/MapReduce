program ArrayLinqSources;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  ArrayContainer in 'ArrayContainer.pas';

begin
  try
    Writeln('It works!');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
