object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1072' 2.3, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 424
  ClientWidth = 355
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clMenu
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  Menu = MainMenu
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object ConditionLabel: TLabel
    Left = 8
    Top = 8
    Width = 337
    Height = 25
    Alignment = taCenter
    Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1087#1086#1089#1090#1088#1086#1080#1090' '#1084#1072#1090#1088#1080#1094#1091' '#1087#1086#1088#1103#1076#1082#1072' N '#1079#1084#1077#1081#1082#1086#1081
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenu
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 21
    Top = 62
    Width = 63
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' N:'
  end
  object Label4: TLabel
    Left = 21
    Top = 39
    Width = 198
    Height = 13
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1083#1103' '#1095#1080#1089#1083#1072' N : '#1086#1090' 1 '#1076#1086' 10'
  end
  object AnswerLabel: TLabel
    Left = 340
    Top = 389
    Width = 9
    Height = 13
    Caption = '...'
    Visible = False
  end
  object Edit1: TEdit
    Left = 90
    Top = 58
    Width = 164
    Height = 20
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1095#1080#1089#1083#1086' '#1086#1090' 1 '#1076#1086' 1000!'
    MaxLength = 9
    PopupMenu = CopyPastePopupMenu
    TabOrder = 1
    TextHint = '0'
    OnChange = EditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
  end
  object CalculateButton: TButton
    Left = 260
    Top = 58
    Width = 74
    Height = 21
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100
    Enabled = False
    TabOrder = 0
    TabStop = False
    OnClick = CalculateButtonClick
  end
  object StringGrid: TStringGrid
    Left = 21
    Top = 89
    Width = 313
    Height = 313
    ColCount = 10
    DefaultColWidth = 30
    DefaultRowHeight = 30
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 2
  end
  object MainMenu: TMainMenu
    Left = 344
    Top = 112
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
      object SaveAsMenuItem: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
        Enabled = False
        ShortCut = 49235
        OnClick = SaveAsMenuItemClick
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
    Left = 344
    Top = 144
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'Answer'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Left = 344
    Top = 184
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 344
    Top = 80
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
