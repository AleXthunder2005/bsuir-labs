object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1072' 2.1, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 338
  ClientWidth = 445
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
    Width = 426
    Height = 32
    Alignment = taCenter
    Caption = 
      #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1086#1087#1088#1077#1076#1077#1083#1080#1090', '#1087#1088#1080#1085#1072#1076#1083#1077#1078#1080#1090' '#1083#1080' '#1090#1086#1095#1082#1072' '#1089' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072#1084#1080' ('#1061',Y), ' +
      #1084#1085#1086#1075#1086#1091#1075#1086#1083#1100#1085#1080#1082#1091', '#1079#1072#1076#1072#1085#1085#1086#1084#1091' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072#1084#1080' '#1074#1077#1088#1096#1080#1085
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
    Top = 132
    Width = 137
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1091' X:'
  end
  object Label4: TLabel
    Left = 21
    Top = 110
    Width = 316
    Height = 13
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1083#1103' '#1074#1074#1086#1076#1072' '#1082#1086#1086#1088#1076#1080#1085#1072#1090' '#1058#1054#1063#1050#1048': '#1086#1090' -99 '#1076#1086' 999'
  end
  object AnswerLabel: TLabel
    Left = 21
    Top = 319
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 21
    Top = 151
    Width = 137
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1091' Y:'
  end
  object Label3: TLabel
    Left = 21
    Top = 76
    Width = 269
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074#1077#1088#1096#1080#1085' '#1084#1085#1086#1075#1086#1091#1075#1086#1083#1100#1085#1080#1082#1072':'
  end
  object Label5: TLabel
    Left = 21
    Top = 54
    Width = 306
    Height = 13
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1083#1103' '#1074#1074#1086#1076#1072' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072' '#1074#1077#1088#1096#1080#1085': '#1086#1090' 3 '#1076#1086' 20'
  end
  object Label6: TLabel
    Left = 21
    Top = 187
    Width = 335
    Height = 13
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1083#1103' '#1074#1074#1086#1076#1072' '#1082#1086#1086#1088#1076#1080#1085#1072#1090' '#1042#1045#1056#1064#1048#1053#1067': '#1086#1090' -99 '#1076#1086' 999'
  end
  object Edit1: TEdit
    Left = 164
    Top = 129
    Width = 142
    Height = 21
    MaxLength = 9
    PopupMenu = CopyPastePopupMenu
    TabOrder = 1
    TextHint = '0'
    OnChange = EditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
  end
  object StringGrid: TStringGrid
    Left = 21
    Top = 206
    Width = 159
    Height = 78
    TabStop = False
    ColCount = 4
    DefaultColWidth = 38
    Enabled = False
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goTabs]
    ScrollBars = ssNone
    TabOrder = 3
    OnExit = StringGridExit
    OnGetEditMask = StringGridGetEditMask
    OnKeyPress = StringGridKeyPress
    OnSetEditText = StringGridSetEditText
  end
  object Edit2: TEdit
    Left = 164
    Top = 151
    Width = 142
    Height = 21
    MaxLength = 9
    PopupMenu = CopyPastePopupMenu
    TabOrder = 2
    TextHint = '0'
    OnChange = EditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
  end
  object CalculateButton: TButton
    Left = 272
    Top = 290
    Width = 142
    Height = 23
    Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
    Enabled = False
    TabOrder = 4
    OnClick = CalculateButtonClick
  end
  object ResetButton: TButton
    Left = 312
    Top = 129
    Width = 102
    Height = 43
    Caption = #1057#1073#1088#1086#1089
    TabOrder = 5
    WordWrap = True
    OnClick = ResetButtonClick
  end
  object CoordCountEdit: TEdit
    Left = 296
    Top = 73
    Width = 118
    Height = 21
    MaxLength = 9
    PopupMenu = CopyPastePopupMenu
    TabOrder = 0
    TextHint = '0'
    OnChange = CoordCountEditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = CoordCountEditKeyPress
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
    Top = 136
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
