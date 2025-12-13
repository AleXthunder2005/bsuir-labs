object AddTopForm: TAddTopForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1077#1088#1096#1080#1085#1091
  ClientHeight = 159
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TitleLabel: TLabel
    Left = 8
    Top = 8
    Width = 322
    Height = 18
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1077#1088#1096#1080#1085#1091', '#1089#1074#1103#1079#1072#1085#1085#1091#1102' '#1089' '#1074#1077#1088#1096#1080#1085#1086#1081
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -16
    Font.Name = 'Lucida Fax'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object TopValueLabel: TLabel
    Left = 34
    Top = 54
    Width = 109
    Height = 16
    Caption = #1053#1086#1084#1077#1088' '#1074#1077#1088#1096#1080#1085#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 34
    Top = 87
    Width = 78
    Height = 16
    Caption = #1044#1083#1080#1085#1072' '#1087#1091#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = []
    ParentFont = False
  end
  object TopValueEdit: TEdit
    Left = 168
    Top = 55
    Width = 162
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = []
    ParentFont = False
    PopupMenu = CopyPastePopupMenu
    TabOrder = 0
    TextHint = '0'
    OnChange = EditChange
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
  end
  object CloseButton: TButton
    AlignWithMargins = True
    Left = 8
    Top = 126
    Width = 145
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TabStop = False
    OnClick = CloseButtonClick
  end
  object ConfirmButton: TButton
    Left = 231
    Top = 126
    Width = 145
    Height = 25
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TabStop = False
    OnClick = ConfirmButtonClick
  end
  object WayLengthEdit: TEdit
    Left = 168
    Top = 85
    Width = 162
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = []
    ParentFont = False
    PopupMenu = CopyPastePopupMenu
    TabOrder = 3
    TextHint = '0'
    OnChange = EditChange
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 358
    Top = 17
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
