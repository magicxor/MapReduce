unit uFormMapReduce;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Generics.Collections, Vcl.ExtCtrls;

type
  TIndObjDict = TDictionary<TObject, Byte>;
  TIndObjPair = TPair<TObject, Byte>;
  TIndObjArr  = TArray<TIndObjPair>;
  TSuit       = (CMap, CMapParallel, CReduce, CForEach);

  TFormMapReduce = class(TForm)
    EditArrayElems: TEdit;
    MemoOutput: TMemo;
    LabelOutput: TLabel;
    LabelArrayElems: TLabel;
    ButtonMap: TButton;
    ButtonMapParallel: TButton;
    ButtonReduce: TButton;
    ButtonForEach: TButton;
    LabelStats: TLabel;
    RadioGroupShowResult: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnClickProcess(Sender: TObject);
  private
    FIndexedObjectsDict: TIndObjDict;
  public
    { Public declarations }
  end;

var
  FormMapReduce: TFormMapReduce;

implementation

uses MapReduce, MapParallel, System.Diagnostics, System.DateUtils;

{$R *.dfm}

function BuildObjectDict(AIndexedObjectsArr: TIndObjArr): TIndObjDict;
var
  X: TIndObjPair;
begin
  Result := TIndObjDict.Create();
  for X in AIndexedObjectsArr do
  begin
    Result.Add(X.Key, X.Value);
  end;
end;

procedure FillLines(ASender: TObject; AInputText: string; AOutputLines: TStrings;
  ASuitDict: TIndObjDict; ANeedResult: boolean);
var
  TempArr: TArray<string>;
  TmpStr: string;
begin
  AOutputLines.Clear;
  TmpStr := string.Empty;

  case TSuit(ASuitDict.Items[ASender]) of
    CMap:
      begin
        TempArr := TMapReduce<string>.Map(
          //
          string(AInputText).Split(['|']),
          function(const X: string; const I: Integer): string
          begin
            Result := I.ToString + ' ' + X;
          end);
      end;
    CMapParallel:
      begin
        TempArr := TMapParallel<string>.Map(
        //
          string(AInputText).Split(['|']),
          function(const X: string; const I: Integer): string
          begin
            Result := I.ToString + ' ' + X;
          end);
      end;
    CReduce:
      begin
        TmpStr := TMapReduce<string>.Reduce(
        //
          string(AInputText).Split(['|']), string.Empty,
          function(const Accumulator: string; const X: string; const I: Integer): string
          begin
            if I = 0 then
              Result := I.ToString + ' ' + X
            else
              Result := Accumulator + sLineBreak + I.ToString + ' ' + X;
          end);
      end;
    CForEach:
      begin
        TempArr := string(AInputText).Split(['|']);
        TMapReduce<string>.ForEachArrChange(TempArr,
          procedure(var X: string; const I: Integer; var Done: boolean)
          begin
            X := X + ' ★';
          end);
      end;
  else
    raise Exception.Create('Unknown button');
  end;

  if ANeedResult then
    if TmpStr = string.Empty then
      AOutputLines.AddStrings(TempArr)
    else
      AOutputLines.Text := TmpStr;
end;

procedure TFormMapReduce.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FIndexedObjectsDict);
end;

procedure TFormMapReduce.FormCreate(Sender: TObject);
begin
  FIndexedObjectsDict := BuildObjectDict([
  //
    TIndObjPair.Create(ButtonMap, Byte(CMap)),
  //
    TIndObjPair.Create(ButtonMapParallel, Byte(CMapParallel)),
  //
    TIndObjPair.Create(ButtonReduce, Byte(CReduce)),
  //
    TIndObjPair.Create(ButtonForEach, Byte(CForEach))]);
end;

procedure TFormMapReduce.BtnClickProcess(Sender: TObject);
var
  SW: TStopwatch;
begin
  SW := TStopwatch.StartNew;
  FillLines(Sender, EditArrayElems.Text, MemoOutput.Lines, FIndexedObjectsDict,
    not RadioGroupShowResult.ItemIndex.ToBoolean);
  SW.Stop;
  LabelStats.Caption := FormatDateTime('hh:nn:ss:zzz', EncodeTime(SW.Elapsed.Hours,
    SW.Elapsed.Minutes, SW.Elapsed.Seconds, SW.Elapsed.Milliseconds));
end;

end.
