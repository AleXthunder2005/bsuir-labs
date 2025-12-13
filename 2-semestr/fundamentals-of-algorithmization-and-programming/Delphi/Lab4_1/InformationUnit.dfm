object InformationForm: TInformationForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1092#1080#1088#1084#1072#1093
  ClientHeight = 324
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TitleLabel: TLabel
    Left = 72
    Top = 8
    Width = 193
    Height = 19
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1092#1080#1088#1084#1072#1093
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGrid: TStringGrid
    Left = 24
    Top = 33
    Width = 297
    Height = 241
    ColCount = 2
    FixedCols = 0
    ScrollBars = ssNone
    TabOrder = 0
  end
  object BackButton: TButton
    Left = 24
    Top = 289
    Width = 129
    Height = 27
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103
    TabOrder = 1
    TabStop = False
    OnClick = BackButtonClick
  end
end
