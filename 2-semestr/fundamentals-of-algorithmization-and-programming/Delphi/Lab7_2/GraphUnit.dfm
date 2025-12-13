object GraphForm: TGraphForm
  Left = 0
  Top = 0
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 7.2, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 561
  ClientWidth = 740
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 700
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object UpPanel: TPanel
    Left = 0
    Top = 0
    Width = 740
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object TitleLabel: TLabel
      Left = 0
      Top = 0
      Width = 740
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
    Width = 740
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      740
      31)
    object SourceLabel: TLabel
      Left = 161
      Top = 8
      Width = 192
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = #1053#1072#1081#1090#1080' '#1076#1083#1080#1085#1091' '#1087#1091#1090#1080' '#1080#1079' '#1075#1086#1088#1086#1076#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'System'
      Font.Style = []
      ParentFont = False
    end
    object DestLabel: TLabel
      Left = 470
      Top = 8
      Width = 8
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = #1074
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'System'
      Font.Style = []
      ParentFont = False
    end
    object ExitButton: TButton
      AlignWithMargins = True
      Left = 2
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
      TabStop = False
      OnClick = ExitButtonClick
    end
    object FindButton: TButton
      Left = 595
      Top = 4
      Width = 145
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1053#1072#1081#1090#1080' '#1076#1083#1080#1085#1091' '#1087#1091#1090#1080
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'System'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnClick = FindButtonClick
    end
    object DestEdit: TEdit
      Left = 484
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
      OnChange = EditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object SourceEdit: TEdit
      Left = 359
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
      TabOrder = 3
      TextHint = '0'
      OnChange = EditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
  end
  object ScrollBox: TScrollBox
    Left = 0
    Top = 33
    Width = 740
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
    object MainImage: TImage
      Left = 0
      Top = 0
      Width = 736
      Height = 493
      Align = alClient
      ExplicitLeft = 136
      ExplicitTop = 40
    end
  end
  object CopyPastePopupMenu: TPopupMenu
    OnPopup = CopyPastePopupMenuPopup
    Left = 686
    Top = 57
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
