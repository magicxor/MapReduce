unit uFormMapReduce;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormMapReduce = class(TForm)
    EditArrayElems: TEdit;
    MemoOutput: TMemo;
    LabelOutput: TLabel;
    LabelArrayElems: TLabel;
    ButtonMap: TButton;
    ButtonReduce: TButton;
    ButtonForEach: TButton;
    ButtonMapParallel: TButton;
    procedure ButtonMapClick(Sender: TObject);
    procedure ButtonReduceClick(Sender: TObject);
    procedure ButtonForEachClick(Sender: TObject);
    procedure ButtonMapParallelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMapReduce: TFormMapReduce;

implementation

uses MapReduce, MapParallel;

{$R *.dfm}

procedure TFormMapReduce.ButtonForEachClick(Sender: TObject);
var
  TempArr: TArray<string>;
begin
  TempArr := string(EditArrayElems.Text).Split(['|']);
  TMapReduce<string>.ForEachArrChange(TempArr,
    procedure(var X: string; const I: Integer; var Done: Boolean)
    begin
      X := X + ' ★';
    end);
  MemoOutput.Clear;
  MemoOutput.Lines.AddStrings(TempArr);
end;

procedure TFormMapReduce.ButtonMapClick(Sender: TObject);
begin
  MemoOutput.Clear;
  MemoOutput.Lines.AddStrings(TMapReduce<string>.Map(
    //
    string(EditArrayElems.Text).Split(['|']),
    function(const X: string; const I: Integer): string
    begin
      Result := I.ToString + ' ' + X;
    end));
end;

procedure TFormMapReduce.ButtonMapParallelClick(Sender: TObject);
begin
  MemoOutput.Clear;
  MemoOutput.Lines.AddStrings(TMapParallel<string>.Map(
    //
    string(EditArrayElems.Text).Split(['|']),
    function(const X: string; const I: Integer): string
    begin
      Result := I.ToString + ' ' + X;
    end));
end;

procedure TFormMapReduce.ButtonReduceClick(Sender: TObject);
begin
  MemoOutput.Lines.Text := (TMapReduce<string>.Reduce(
  //
    string(EditArrayElems.Text).Split(['|']), string.Empty,
    function(const Accumulator: string; const X: string; const I: Integer): string
    begin
      if I = 0 then
        Result := I.ToString + ' ' + X
      else
        Result := Accumulator + sLineBreak + I.ToString + ' ' + X;
    end));
end;

end.
