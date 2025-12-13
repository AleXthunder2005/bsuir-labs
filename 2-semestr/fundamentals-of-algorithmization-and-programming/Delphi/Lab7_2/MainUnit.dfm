object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 7.2, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnHighlight
  Constraints.MinHeight = 300
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UpPanel: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object TitleLabel: TLabel
      Left = 0
      Top = 0
      Width = 784
      Height = 33
      Align = alClient
      Alignment = taCenter
      Caption = 
        #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1084#1072' '#1085#1072#1081#1076#1077#1090' '#1082#1088#1072#1090#1095#1072#1081#1096#1080#1077' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1103' '#1084#1077#1078#1076#1091' '#1074#1089#1077#1084#1080' '#1087#1072#1088#1072#1084 +
        #1080' '#1075#1086#1088#1086#1076#1086#1074
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -21
      Font.Name = 'Lucida Fax'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 723
      ExplicitHeight = 24
    end
  end
  object DownPanel: TPanel
    Left = 0
    Top = 530
    Width = 784
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 534
    DesignSize = (
      784
      31)
    object TopCountLabel: TLabel
      Left = 375
      Top = 6
      Width = 134
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074#1077#1088#1096#1080#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'System'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 367
    end
    object ExitButton: TButton
      AlignWithMargins = True
      Left = 10
      Top = 4
      Width = 145
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'System'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ExitButtonClick
    end
    object BuildButton: TButton
      Left = 626
      Top = 4
      Width = 145
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'System'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BuildButtonClick
    end
    object TopCountEdit: TEdit
      Left = 515
      Top = 6
      Width = 105
      Height = 24
      Anchors = [akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'System'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      PopupMenu = CopyPastePopupMenu
      TabOrder = 2
      TextHint = '0'
      OnChange = TopCountEditChange
      OnKeyDown = TopCountEditKeyDown
      OnKeyPress = TopCountEditKeyPress
    end
    object ConvertButton: TButton
      Left = 161
      Top = 4
      Width = 145
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1075#1088#1072#1092
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'System'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ConvertButtonClick
    end
  end
  object ScrollBox: TScrollBox
    Left = 0
    Top = 33
    Width = 784
    Height = 497
    HorzScrollBar.Color = clHighlight
    HorzScrollBar.ParentColor = False
    VertScrollBar.Color = clHotLight
    VertScrollBar.ParentColor = False
    Align = alClient
    DoubleBuffered = True
    Color = clBtnHighlight
    ParentColor = False
    ParentDoubleBuffered = False
    TabOrder = 2
    OnMouseWheelDown = ScrollBoxMouseWheelDown
    OnMouseWheelUp = ScrollBoxMouseWheelUp
    object MainImage: TImage
      Left = 0
      Top = 0
      Width = 780
      Height = 493
      Align = alClient
      OnMouseDown = MainImageMouseDown
      OnMouseMove = MainImageMouseMove
      ExplicitLeft = 3
      ExplicitTop = 4
      ExplicitWidth = 766
      ExplicitHeight = 491
    end
  end
  object ElemPopupMenu: TPopupMenu
    Left = 712
    Top = 56
    object DeleteButton: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = DeleteButtonClick
    end
  end
  object MainMenu: TMainMenu
    Left = 712
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
    DefaultExt = '.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Left = 720
    Top = 168
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.txt'
    FileName = 'Lists'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Left = 712
    Top = 232
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 718
    Top = 289
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
