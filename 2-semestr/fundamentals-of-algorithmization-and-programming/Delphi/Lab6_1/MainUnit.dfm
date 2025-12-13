object MainForm: TMainForm
  Left = 0
  Top = 329
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 6.1, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 283
  ClientWidth = 1194
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object BackgroundImage: TImage
    Left = 0
    Top = 0
    Width = 1198
    Height = 281
  end
  object SpeedLabel: TLabel
    Left = 8
    Top = 8
    Width = 350
    Height = 33
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = cl3DDkShadow
    Font.Height = -27
    Font.Name = 'Bahnschrift SemiBold'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object MainMenu: TMainMenu
    Left = 736
    Top = 8
    object ManualMenuItem: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = ManualMenuItemClick
    end
    object AboutDevelopersMenuItem: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = AboutDevelopersMenuItemClick
    end
  end
  object BoatTimer: TTimer
    Interval = 40
    OnTimer = BoatTimerTimer
    Left = 736
    Top = 64
  end
end
