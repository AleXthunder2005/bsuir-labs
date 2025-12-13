unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.Menus, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    ManualMenuItem: TMenuItem;
    AboutDevelopersMenuItem: TMenuItem;
    BoatTimer: TTimer;
    BackgroundImage: TImage;
    SpeedLabel: TLabel;
    procedure ManualMenuItemClick(Sender: TObject);
    procedure AboutDevelopersMenuItemClick(Sender: TObject);
    procedure BoatTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    MainForm: TMainForm;
    BoatBitmap: TBitmap;
    X, Speed: Integer;

implementation


const
    kW = Ord('W');
    kSmallW = Ord('w');
    kRusW = Ord('Ц');
    kRusSmallW = Ord('ц');
    kS = Ord('S');
    kSmallS = Ord('s');
    kRusS = Ord('Ы');
    kRusSmallS = Ord('ы');
    kEsc = 27;

{$R *.dfm}

procedure TMainForm.AboutDevelopersMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, 'Разработчик: Наривончик Александр Михайлович, гр. 351004', 'О разработчике', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    BoatBitmap.Free;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
        BoatBitmap := TBitmap.Create;
        BoatBitmap.LoadFromFile('boatBMP.bmp');
        BackgroundImage.Canvas.Draw(0, 80, BoatBitmap);

        X := 0;
        Speed := 1;
        SpeedLabel.Caption := 'Скорость: ' + IntToStr(Speed) + ' км/ч ';
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case Key of
        kW, kSmallW, kRusSmallW, kRusW:
            if Speed < 50 then
            begin
                Inc(Speed);
                SpeedLabel.Caption := 'Скорость: ' + IntToStr(Speed) + ' км/ч ';
            end;
        kS, kSmallS, kRusSmallS, kRusS:
            if Speed > 0 then
            begin
                Dec(Speed);
                SpeedLabel.Caption := 'Скорость: ' + IntToStr(Speed) + ' км/ч ';
            end;
        kEsc:
            MainForm.Close;
        else
          Key := 0;
    end;
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
MessageBox(Handle, 'Программа создает анимацию движения катера:' + #13#10 + '1. Нажмите клавишу "W", чтобы увеличить скорость парусника' + #13#10 + '2. Нажмите клавишу "S", чтобы уменьшить скорость парусника' + #13#10 + '3. Нажмите клавишу "Esc", чтобы выйти.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.BoatTimerTimer(Sender: TObject);
begin
    if X > BackgroundImage.Width - 60 then
        X := -BoatBitmap.Width;
    X := X + Speed;
    BackgroundImage.Canvas.Draw(X, 80, BoatBitmap);
end;

end.
