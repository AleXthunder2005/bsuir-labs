object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 5.1, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 436
  ClientWidth = 516
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
    Left = 40
    Top = 20
    Width = 440
    Height = 19
    Alignment = taCenter
    Caption = #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1074#1099#1087#1086#1083#1085#1080#1090' '#1089#1083#1080#1103#1085#1080#1077' '#1076#1074#1091#1093' '#1089#1087#1080#1089#1082#1086#1074' '
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
  object FirstListGrid: TStringGrid
    Left = 40
    Top = 64
    Width = 113
    Height = 257
    TabStop = False
    ColCount = 1
    DefaultColWidth = 110
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssNone
    TabOrder = 0
  end
  object AddToFirstListButton: TButton
    Left = 40
    Top = 371
    Width = 113
    Height = 24
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 1
    TabStop = False
    OnClick = AddToFirstListButtonClick
  end
  object FirstListEdit: TEdit
    Left = 40
    Top = 344
    Width = 113
    Height = 21
    TabStop = False
    MaxLength = 7
    PopupMenu = CopyPastePopupMenu
    TabOrder = 2
    TextHint = '0'
    OnChange = EditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
  end
  object SecondListGrid: TStringGrid
    Left = 184
    Top = 64
    Width = 113
    Height = 257
    TabStop = False
    ColCount = 1
    DefaultColWidth = 110
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssNone
    TabOrder = 3
  end
  object AddToSecondListButton: TButton
    Left = 184
    Top = 371
    Width = 113
    Height = 24
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 4
    TabStop = False
    OnClick = AddToSecondListButtonClick
  end
  object SecondListEdit: TEdit
    Left = 184
    Top = 342
    Width = 113
    Height = 21
    TabStop = False
    MaxLength = 7
    PopupMenu = CopyPastePopupMenu
    TabOrder = 5
    TextHint = '0'
    OnChange = EditChange
    OnDblClick = EditDblClick
    OnKeyDown = EditKeyDown
    OnKeyPress = EditKeyPress
  end
  object ResultListGrid: TStringGrid
    Left = 360
    Top = 64
    Width = 113
    Height = 257
    TabStop = False
    ColCount = 1
    DefaultColWidth = 110
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssNone
    TabOrder = 6
  end
  object MergeButton: TButton
    Left = 360
    Top = 342
    Width = 113
    Height = 24
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1089#1083#1080#1103#1085#1080#1077
    TabOrder = 7
    TabStop = False
    OnClick = MergeButtonClick
  end
  object ResetButton: TButton
    Left = 360
    Top = 371
    Width = 113
    Height = 24
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100
    TabOrder = 8
    TabStop = False
    OnClick = ResetButtonClick
  end
  object ExitButton: TButton
    Left = 360
    Top = 401
    Width = 113
    Height = 24
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 9
    TabStop = False
    OnClick = ExitButtonClick
  end
  object MainMenu: TMainMenu
    Left = 472
    Top = 88
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
    Left = 472
    Top = 136
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'Answer'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Left = 472
    Top = 176
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 472
    Top = 48
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
