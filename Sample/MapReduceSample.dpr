program MapReduceSample;

uses
  Vcl.Forms,
  uFormMapReduce in 'uFormMapReduce.pas' {FormMapReduce},
  MapReduce in '..\Source\MapReduce.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMapReduce, FormMapReduce);
  Application.Run;
end.
