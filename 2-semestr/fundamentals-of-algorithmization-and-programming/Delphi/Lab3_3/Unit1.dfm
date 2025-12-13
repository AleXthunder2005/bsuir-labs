object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1072' 3.3, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 313
  ClientWidth = 440
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ConditionLabel: TLabel
    Left = 8
    Top = 8
    Width = 396
    Height = 16
    Alignment = taCenter
    Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1086#1090#1089#1086#1088#1090#1080#1088#1091#1077#1090' '#1084#1072#1089#1089#1080#1074' '#1084#1077#1090#1086#1076#1086#1084' '#1087#1088#1086#1089#1090#1099#1093' '#1074#1089#1090#1072#1074#1086#1082
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
    Left = 29
    Top = 58
    Width = 190
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1083#1077#1084#1077#1085#1090#1086#1074':'
  end
  object Label4: TLabel
    Left = 29
    Top = 39
    Width = 379
    Height = 13
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1083#1103' '#1074#1074#1086#1076#1072' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' '#1084#1072#1089#1089#1080#1074#1072' : '#1086#1090' 1 '#1076#1086' 15'
  end
  object Label2: TLabel
    Left = 31
    Top = 89
    Width = 327
    Height = 13
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1083#1103' '#1074#1074#1086#1076#1072' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' '#1084#1072#1089#1089#1080#1074#1072' : '#1086#1090' -99 '#1076#1086' 999'
  end
  object Label3: TLabel
    Left = 504
    Top = 8
    Width = 166
    Height = 16
    Alignment = taCenter
    Caption = #1055#1086#1096#1072#1075#1086#1074#1072#1103' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103
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
  object Edit1: TEdit
    Left = 225
    Top = 55
    Width = 183
    Height = 21
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1095#1080#1089#1083#1086' '#1086#1090' 1 '#1076#1086' 1000!'
    MaxLength = 9
    PopupMenu = CopyPastePopupMenu
    TabOrder = 0
    TextHint = '0'
    OnChange = EditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
  end
  object StringGrid: TStringGrid
    Left = 29
    Top = 108
    Width = 381
    Height = 80
    ColCount = 7
    DefaultColWidth = 53
    DefaultRowHeight = 30
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goTabs]
    TabOrder = 1
    OnExit = StringGridExit
    OnGetEditMask = StringGridGetEditMask
    OnKeyPress = StringGridKeyPress
    OnSetEditText = StringGridSetEditText
  end
  object CalculateButton: TButton
    Left = 295
    Top = 194
    Width = 115
    Height = 25
    Caption = #1054#1090#1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = CalculateButtonClick
  end
  object AnswerStringGrid: TStringGrid
    Left = 29
    Top = 225
    Width = 381
    Height = 80
    ColCount = 7
    DefaultColWidth = 53
    DefaultRowHeight = 30
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goTabs]
    TabOrder = 3
  end
  object Memo: TMemo
    Left = 448
    Top = 39
    Width = 273
    Height = 266
    Enabled = False
    Lines.Strings = (
      'Memo')
    TabOrder = 4
  end
  object MainMenu: TMainMenu
    Left = 416
    Top = 72
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
    Left = 416
    Top = 104
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'Answer'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Left = 416
    Top = 144
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 416
    Top = 40
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
