object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 6.2, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 515
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object ConditionLabel: TLabel
    Left = 56
    Top = 8
    Width = 573
    Height = 19
    Alignment = taCenter
    Caption = #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1087#1086#1089#1090#1088#1086#1080#1090' '#1084#1072#1075#1080#1095#1077#1089#1082#1080#1081' '#1082#1074#1072#1076#1088#1072#1090' "'#1084#1077#1090#1086#1076#1086#1084' '#1090#1077#1088#1088#1072#1089'"'
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object BuildButton: TButton
    Left = 586
    Top = 425
    Width = 113
    Height = 24
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100
    Enabled = False
    TabOrder = 0
    TabStop = False
    OnClick = BuildButtonClick
  end
  object ValueEdit: TEdit
    Left = 586
    Top = 398
    Width = 113
    Height = 21
    TabStop = False
    MaxLength = 7
    PopupMenu = CopyPastePopupMenu
    TabOrder = 1
    TextHint = '0'
    OnChange = ValueEditChange
    OnKeyDown = ValueEditKeyDown
    OnKeyPress = ValueEditKeyPress
  end
  object StringGrid: TStringGrid
    Left = 8
    Top = 40
    Width = 569
    Height = 449
    ColCount = 10
    DefaultColWidth = 40
    DefaultRowHeight = 30
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    ScrollBars = ssNone
    TabOrder = 2
  end
  object ResetButton: TButton
    Left = 586
    Top = 455
    Width = 113
    Height = 24
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 3
    TabStop = False
    OnClick = ResetButtonClick
  end
  object MainMenu: TMainMenu
    Left = 600
    Top = 104
    object FileMenuItem: TMenuItem
      Caption = #1060#1072#1081#1083
      object OpenMenuItem: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = OpenMenuItemClick
      end
      object SaveMenuItem: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = SaveMenuItemClick
      end
    end
    object ManualMenuItem: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = ManualMenuItemClick
    end
    object AboutDeveloperMenuItem: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = AboutDeveloperMenuItemClick
    end
  end
  object OpenDialog: TOpenDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Options = [ofEnableSizing]
    Left = 600
    Top = 152
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'Answer'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Left = 600
    Top = 192
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 600
    Top = 64
    object CopyButton: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ShortCut = 16451
      OnClick = CopyButtonClick
    end
    object PasteButton: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ShortCut = 16470
      OnClick = PasteButtonClick
    end
    object CutButton: TMenuItem
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      ShortCut = 16472
      OnClick = CutButtonClick
    end
  end
end
