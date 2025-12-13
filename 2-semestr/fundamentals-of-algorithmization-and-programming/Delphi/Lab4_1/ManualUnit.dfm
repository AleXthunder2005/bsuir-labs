object ManualForm: TManualForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
  ClientHeight = 316
  ClientWidth = 576
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
  object ManualLabel: TLabel
    Left = 8
    Top = 8
    Width = 128
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BackButton: TButton
    Left = 8
    Top = 281
    Width = 129
    Height = 27
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103
    TabOrder = 0
    TabStop = False
    OnClick = BackButtonClick
  end
end
