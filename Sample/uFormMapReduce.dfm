object FormMapReduce: TFormMapReduce
  Left = 0
  Top = 0
  Caption = 'MapReduce sample'
  ClientHeight = 329
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabelOutput: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 193
    Width = 341
    Height = 13
    Align = alTop
    Caption = 'Result'
    ExplicitTop = 157
    ExplicitWidth = 30
  end
  object LabelArrayElems: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 341
    Height = 13
    Align = alTop
    Caption = 'Array elements separated by |'
    ExplicitWidth = 147
  end
  object EditArrayElems: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 22
    Width = 341
    Height = 21
    Align = alTop
    TabOrder = 0
    Text = #1054#1044#1048#1053'|two|ThReE|'#9650#9650#9650#9650
  end
  object MemoOutput: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 212
    Width = 341
    Height = 114
    Align = alClient
    TabOrder = 1
    ExplicitTop = 176
    ExplicitHeight = 150
  end
  object ButtonMap: TButton
    AlignWithMargins = True
    Left = 3
    Top = 49
    Width = 341
    Height = 30
    Align = alTop
    Caption = 'Map to list'
    TabOrder = 2
    OnClick = ButtonMapClick
  end
  object ButtonReduce: TButton
    AlignWithMargins = True
    Left = 3
    Top = 121
    Width = 341
    Height = 30
    Align = alTop
    Caption = 'Reduce to list'
    TabOrder = 3
    OnClick = ButtonReduceClick
    ExplicitTop = 85
  end
  object ButtonForEach: TButton
    AlignWithMargins = True
    Left = 3
    Top = 157
    Width = 341
    Height = 30
    Align = alTop
    Caption = 'ForEach + '#9733
    TabOrder = 4
    OnClick = ButtonForEachClick
    ExplicitTop = 121
  end
  object ButtonMapParallel: TButton
    AlignWithMargins = True
    Left = 3
    Top = 85
    Width = 341
    Height = 30
    Align = alTop
    Caption = 'Parallel map to list'
    TabOrder = 5
    OnClick = ButtonMapParallelClick
    ExplicitLeft = 6
    ExplicitTop = 57
  end
end
