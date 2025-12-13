object MainForm: TMainForm
  Left = 537
  Top = 165
  Caption = #1055#1072#1088#1072#1076#1086#1082#1089' '#1041#1077#1088#1090#1088#1072#1085#1072
  ClientHeight = 649
  ClientWidth = 1184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ChordImage: TImage
    Left = 8
    Top = 8
    Width = 1320
    Height = 680
  end
  object AnswerLabel: TLabel
    Left = 145
    Top = 20
    Width = 168
    Height = 29
    Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NumberLabel: TLabel
    Left = 319
    Top = 20
    Width = 7
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RunButton: TButton
    Left = 16
    Top = 16
    Width = 123
    Height = 33
    Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1084#1086#1076#1091#1083#1103#1094#1080#1102
    TabOrder = 0
    OnClick = RunButtonClick
  end
end
