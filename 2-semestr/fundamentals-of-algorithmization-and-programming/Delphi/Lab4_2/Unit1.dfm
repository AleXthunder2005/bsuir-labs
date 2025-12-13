object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 4.2, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 273
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ConditionLabel: TLabel
    Left = 24
    Top = 8
    Width = 435
    Height = 32
    Alignment = taCenter
    Caption = 
      #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1091#1076#1072#1083#1080#1090' '#1080#1079' '#1087#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1080' '#1089#1080#1084#1074#1086#1083#1086#1074' '#1040','#1042' '#1080' '#1057' '#1087#1086#1089#1083#1077#1076#1086#1074 +
      #1072#1090#1077#1083#1100#1085#1086#1089#1090#1080' '#1040#1040#1040#1040' '#1080' '#1040#1042#1057', '#1072' '#1090#1072#1082' '#1078#1077' '#1079#1072#1084#1077#1085#1080#1090' '#1042#1040#1042#1040' '#1085#1072' '#1042#1040
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
  object CalculateButton: TButton
    Left = 328
    Top = 240
    Width = 137
    Height = 25
    Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100
    Enabled = False
    TabOrder = 0
    TabStop = False
    OnClick = CalculateButtonClick
  end
  object Memo: TMemo
    Left = 24
    Top = 56
    Width = 441
    Height = 161
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1074#1072#1096' '#1090#1077#1082#1089#1090
    ParentCustomHint = False
    Lines.Strings = (
      'Memo')
    ParentShowHint = False
    PopupMenu = CopyPastePopupMenu
    ShowHint = True
    TabOrder = 1
    OnChange = MemoChange
    OnKeyDown = MemoKeyDown
    OnKeyPress = MemoKeyPress
  end
  object MainMenu: TMainMenu
    Left = 456
    Top = 48
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
    Left = 456
    Top = 96
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'Answer'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Left = 456
    Top = 136
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 456
    Top = 8
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
