object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 2.1, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 276
  ClientWidth = 489
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
    Left = 45
    Top = 8
    Width = 341
    Height = 32
    Alignment = taCenter
    Caption = 
      #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1085#1072#1081#1076#1105#1090' '#1085#1072#1080#1073#1086#1083#1100#1096#1077#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1092#1091#1085#1082#1094#1080#1080' y=(ax2+bx+c)/(dx+e)' +
      ' '#1085#1072' '#1086#1090#1088#1077#1079#1082#1077' [x1;x2]'
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
    Left = 45
    Top = 85
    Width = 146
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1040':'
  end
  object Label2: TLabel
    Left = 45
    Top = 112
    Width = 145
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1042':'
  end
  object Label3: TLabel
    Left = 45
    Top = 139
    Width = 145
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1057':'
  end
  object Label4: TLabel
    Left = 45
    Top = 63
    Width = 289
    Height = 13
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1083#1103' '#1074#1074#1086#1076#1080#1084#1099#1093' '#1095#1080#1089#1077#1083': '#1086#1090' -1000 '#1076#1086' 1000'
  end
  object Label5: TLabel
    Left = 45
    Top = 206
    Width = 318
    Height = 13
    Caption = #1053#1072#1080#1073#1086#1083#1100#1096#1077#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1092#1091#1085#1082#1094#1080#1080' '#1085#1072' '#1087#1088#1086#1084#1077#1078#1091#1090#1082#1077' '#1088#1072#1074#1085#1086':'
  end
  object AnswerLabel: TLabel
    Left = 387
    Top = 206
    Width = 9
    Height = 13
    Caption = '...'
  end
  object Edit1: TEdit
    Left = 205
    Top = 82
    Width = 137
    Height = 21
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
  object Edit2: TEdit
    Left = 205
    Top = 109
    Width = 137
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
  object Edit3: TEdit
    Left = 205
    Top = 136
    Width = 137
    Height = 21
    MaxLength = 9
    PopupMenu = CopyPastePopupMenu
    TabOrder = 3
    TextHint = '0'
    OnChange = EditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
  end
  object CalculateButton: TButton
    Left = 205
    Top = 163
    Width = 137
    Height = 25
    Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
    Enabled = False
    TabOrder = 0
    TabStop = False
    OnClick = CalculateButtonClick
  end
  object MainMenu: TMainMenu
    Left = 400
    Top = 56
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
    Left = 400
    Top = 104
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'Answer'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Left = 400
    Top = 160
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 400
    Top = 16
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
