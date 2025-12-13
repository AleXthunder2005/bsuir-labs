object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 5.2, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 504
  ClientWidth = 798
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ConditionLabel: TLabel
    Left = 56
    Top = -1
    Width = 686
    Height = 36
    Alignment = taCenter
    AutoSize = False
    BiDiMode = bdLeftToRight
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1087#1086#1079#1074#1086#1083#1080#1090' '#1085#1072#1081#1090#1080' '#1084#1080#1085#1080#1084#1072#1083#1100#1085#1099#1077' '#1087#1091#1090#1080' '#1084#1077#1078#1076#1091' '#1082#1086#1088#1085#1077#1084' '#1073#1080 +
      #1085#1072#1088#1085#1086#1075#1086' '#1076#1077#1088#1077#1074#1072' '#1080' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1091#1102#1097#1080#1084#1080' '#1083#1080#1089#1090#1100#1103#1084#1080', '#1072' '#1090#1072#1082#1078#1077' '#1091#1076#1072#1083#1080#1090' '#1094#1077#1085#1090#1088 +
      #1072#1083#1100#1085#1099#1077' '#1074#1077#1088#1096#1080#1085#1099' '#1101#1090#1080#1093' '#1087#1091#1090#1077#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    WordWrap = True
  end
  object AnswerLabel: TLabel
    Left = 657
    Top = 203
    Width = 133
    Height = 64
    Alignment = taCenter
    AutoSize = False
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial Narrow'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    WordWrap = True
  end
  object ValueEdit: TEdit
    Left = 665
    Top = 49
    Width = 121
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    PopupMenu = CopyPastePopupMenu
    TabOrder = 0
    TextHint = '0'
    OnChange = ValueEditChange
    OnDblClick = ValueEditDblClick
    OnKeyDown = ValueEditKeyDown
    OnKeyPress = ValueEditKeyPress
  end
  object AddButton: TButton
    Left = 665
    Top = 79
    Width = 121
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = AddButtonClick
  end
  object ProcessingButton: TButton
    Left = 665
    Top = 141
    Width = 121
    Height = 25
    Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100
    TabOrder = 2
    OnClick = ProcessingButtonClick
  end
  object DeleteButton: TButton
    Left = 665
    Top = 110
    Width = 121
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = DeleteButtonClick
  end
  object ExitButton: TButton
    Left = 665
    Top = 172
    Width = 121
    Height = 25
    Caption = #1042#1099#1081#1090#1080
    TabOrder = 4
    OnClick = ExitButtonClick
  end
  object ScrollBox: TScrollBox
    Left = 16
    Top = 50
    Width = 643
    Height = 438
    TabOrder = 5
    object TreeImage: TImage
      Left = -2
      Top = -2
      Width = 1000
      Height = 434
      Transparent = True
    end
  end
  object MainMenu: TMainMenu
    Left = 736
    Top = 320
    object FileMenuItem: TMenuItem
      Caption = #1060#1072#1081#1083
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
      ShortCut = 16452
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
    Left = 736
    Top = 368
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 736
    Top = 280
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
  object SavePictureDialog: TSavePictureDialog
    DefaultExt = '.bmp'
    FileName = 'Tree'
    Filter = 
      'Bitmaps (*.bmp)|*.bmp|Portable Network Graphics (*.png)|*.png|JP' +
      'EG Image File (*.jpg)|*.jpg'
    Left = 736
    Top = 424
  end
end
