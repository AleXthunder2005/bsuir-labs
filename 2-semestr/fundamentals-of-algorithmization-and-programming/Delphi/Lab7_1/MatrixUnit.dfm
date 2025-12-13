object MatrixForm: TMatrixForm
  Left = 0
  Top = 0
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' 7.1, '#1053#1072#1088#1080#1074#1086#1085#1095#1080#1082' '#1040#1083#1077#1082#1089#1072#1085#1076#1088', 351004'
  ClientHeight = 541
  ClientWidth = 684
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DownPanel: TPanel
    Left = 0
    Top = 510
    Width = 684
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 530
    DesignSize = (
      684
      31)
    object ExitButton: TButton
      AlignWithMargins = True
      Left = 537
      Top = 6
      Width = 145
      Height = 25
      Anchors = [akRight, akBottom]
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
  end
  object UpPanel: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 1
    object TitleLabel: TLabel
      Left = 0
      Top = 0
      Width = 684
      Height = 33
      Align = alClient
      Alignment = taCenter
      Caption = #1052#1072#1090#1088#1080#1094#1072' '#1089#1084#1077#1078#1085#1086#1089#1090#1080
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -21
      Font.Name = 'Lucida Fax'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 173
      ExplicitHeight = 24
    end
  end
  object ScrollBox: TScrollBox
    Left = 0
    Top = 33
    Width = 684
    Height = 477
    Align = alClient
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    ExplicitHeight = 497
    object MainImage: TImage
      Left = 0
      Top = 0
      Width = 680
      Height = 473
      Align = alClient
      ExplicitLeft = 3
      ExplicitTop = 4
      ExplicitWidth = 766
      ExplicitHeight = 491
    end
  end
  object MainMenu: TMainMenu
    Left = 648
    Top = 48
    object FileMenuItem: TMenuItem
      Caption = #1060#1072#1081#1083
      object SaveMenuItem: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = SaveMenuItemClick
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.txt'
    FileName = 'Matrix'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Left = 648
    Top = 104
  end
end
