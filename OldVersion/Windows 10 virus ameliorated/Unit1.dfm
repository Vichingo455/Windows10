object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Windows 10'
  ClientHeight = 242
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 264
    Top = 112
  end
  object Timer2: TTimer
    Interval = 1
    OnTimer = Timer2Timer
    Left = 128
    Top = 112
  end
  object Timer3: TTimer
    Interval = 1
    OnTimer = Timer3Timer
    Left = 360
    Top = 112
  end
  object Timer4: TTimer
    Interval = 10000
    OnTimer = Timer4Timer
    Left = 32
    Top = 112
  end
end
