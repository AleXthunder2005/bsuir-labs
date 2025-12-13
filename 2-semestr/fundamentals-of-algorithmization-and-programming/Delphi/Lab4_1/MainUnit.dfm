object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 4.1, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 501
  ClientWidth = 744
  Color = clBtnFace
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TitelLabel: TLabel
    Left = 98
    Top = 16
    Width = 544
    Height = 42
    Alignment = taCenter
    Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1091#1102#1097#1080#1077' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object StringGrid: TStringGrid
    Left = 24
    Top = 64
    Width = 681
    Height = 385
    TabStop = False
    ColCount = 7
    DefaultColWidth = 25
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
    OnClick = StringGridClick
    OnDrawCell = StringGridDrawCell
    OnKeyDown = StringGridKeyDown
  end
  object AddRecordButton: TButton
    Left = 576
    Top = 466
    Width = 129
    Height = 27
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
    TabOrder = 1
    TabStop = False
    OnClick = AddRecordButtonClick
  end
  object BackButton: TButton
    Left = 24
    Top = 466
    Width = 129
    Height = 27
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103
    TabOrder = 2
    TabStop = False
    OnClick = BackButtonClick
  end
  object InfoButton: TButton
    Left = 440
    Top = 466
    Width = 130
    Height = 27
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1092#1080#1088#1084#1072#1093
    TabOrder = 3
    TabStop = False
    OnClick = InfoButtonClick
  end
  object MainMenu: TMainMenu
    Left = 704
    Top = 8
    object FileMenuItem: TMenuItem
      Caption = #1060#1072#1081#1083
      OnClick = FileMenuItemClick
      object OpenMenuItem: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = OpenMenuItemClick
      end
      object SaveMenuItem: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = SaveMenuItemClick
      end
    end
    object ManualMenuItem: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      ShortCut = 112
      OnClick = ManualMenuItemClick
    end
    object AboutDeveloperMenuItem: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = AboutDeveloperMenuItemClick
    end
  end
  object OpenDialog: TOpenDialog
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093' '#1086' '#1082#1086#1084#1087#1083#1077#1082#1090#1091#1102#1097#1080#1093' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072'|*.hdb'
    Left = 704
    Top = 56
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.hdb'
    FileName = 'DataFile'
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093' '#1086' '#1082#1086#1084#1087#1083#1077#1082#1090#1091#1102#1097#1080#1093' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072'|*.hdb'
    Left = 704
    Top = 112
  end
end
