object AddRecordForm: TAddRecordForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
  ClientHeight = 255
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object HardwareNameLabel: TLabel
    Left = 8
    Top = 51
    Width = 147
    Height = 16
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TitleLabel: TLabel
    Left = 160
    Top = 8
    Width = 150
    Height = 19
    Caption = #1053#1086#1074#1086#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object CompanyNameLabel: TLabel
    Left = 8
    Top = 80
    Width = 142
    Height = 16
    Caption = #1060#1080#1088#1084#1072' '#1080#1079#1075#1086#1090#1086#1074#1080#1090#1077#1083#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DescriptionLabel: TLabel
    Left = 8
    Top = 105
    Width = 144
    Height = 32
    Caption = #1043#1083#1072#1074#1085#1072#1103' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1072#1103' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object WarrantyLabel: TLabel
    Left = 8
    Top = 143
    Width = 135
    Height = 16
    Caption = #1043#1072#1088#1072#1085#1090#1080#1103' ('#1084#1077#1089#1103#1094#1099'):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PriceLabel: TLabel
    Left = 8
    Top = 171
    Width = 80
    Height = 16
    Caption = #1062#1077#1085#1072' (BYN):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object HardwareNameEdit: TEdit
    Left = 161
    Top = 48
    Width = 295
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 17
    ParentFont = False
    PopupMenu = CopyPastePopupMenu
    TabOrder = 0
    TextHint = #1053#1072#1079#1074#1072#1085#1080#1077
    OnChange = StrEditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = StrEditKeyPress
  end
  object CompanyNameEdit: TEdit
    Left = 161
    Top = 78
    Width = 296
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 17
    ParentFont = False
    PopupMenu = CopyPastePopupMenu
    TabOrder = 1
    TextHint = #1060#1080#1088#1084#1072
    OnChange = StrEditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = StrEditKeyPress
  end
  object DescriptionEdit: TEdit
    Left = 161
    Top = 108
    Width = 296
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 40
    ParentFont = False
    PopupMenu = CopyPastePopupMenu
    TabOrder = 2
    TextHint = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1072
    OnChange = StrEditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = StrEditKeyPress
  end
  object WarrantyEdit: TEdit
    Left = 161
    Top = 138
    Width = 97
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 3
    ParentFont = False
    PopupMenu = CopyPastePopupMenu
    TabOrder = 3
    TextHint = '0'
    OnChange = WarrantyEditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = WarrantyEditKeyPress
  end
  object AddButton: TButton
    Left = 333
    Top = 214
    Width = 123
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 5
    TabStop = False
    OnClick = AddButtonClick
  end
  object CancelButton: TButton
    Left = 8
    Top = 214
    Width = 113
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 6
    TabStop = False
    OnClick = CancelButtonClick
  end
  object PriceEdit: TEdit
    Left = 161
    Top = 168
    Width = 96
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 9
    ParentFont = False
    PopupMenu = CopyPastePopupMenu
    TabOrder = 4
    TextHint = '0.00'
    OnChange = PriceEditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = PriceEditKeyPress
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 424
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
