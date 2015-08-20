program MapReduceSample;

uses
  Vcl.Forms,
  uFormMapReduce in 'uFormMapReduce.pas' {FormMapReduce},
  MapReduce in '..\Source\MapReduce.pas',
  MapParallel in '..\SourceParallel\MapParallel.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  //
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMapReduce, FormMapReduce);
  Application.Run;
end.
