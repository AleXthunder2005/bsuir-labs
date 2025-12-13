unit StartUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Menus;

type
  TStartForm = class(TForm)
    ProgramNameLabel: TLabel;
    StartButtonLabel: TLabel;
    DogImage: TImage;
    StartMainMenu: TMainMenu;
    ManualMenuItem: TMenuItem;
    AboutDeveloperMenuItem: TMenuItem;
    ExitLabel: TLabel;
    procedure LabelMouseEnter(Sender: TObject);
    procedure LabelMouseLeave(Sender: TObject);
    procedure StartButtonLabelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExitLabelClick(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StartForm: TStartForm;

implementation
uses
    MainUnit, ManualUnit;
{$R *.dfm}

procedure TStartForm.StartButtonLabelClick(Sender: TObject);
begin
    StartForm.Visible := False;
    MainForm.ShowModal;
    StartForm.Visible := True;
end;

procedure TStartForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TStartForm.AboutDeveloperMenuItemClick(Sender: TObject);
begin
   MessageBox(Handle, 'Разработчик: Наривончик Александр Михайлович, гр. 351004', 'О разработчике', MB_OK Or MB_ICONINFORMATION);
end;

procedure TStartForm.ExitLabelClick(Sender: TObject);
begin
    StartForm.Close;
end;

procedure TStartForm.LabelMouseEnter(Sender: TObject);
begin
    With Sender As TLabel Do
    Begin
        Font.Size := Font.Size + 4;
        Top := Top - 5;
        Left := Left - 5;
    End;
end;

procedure TStartForm.LabelMouseLeave(Sender: TObject);
begin
    With Sender As TLabel Do
    Begin
        Font.Size := Font.Size - 4;
        Top := Top + 5;
        Left := Left + 5;
    End;
end;

procedure TStartForm.ManualMenuItemClick(Sender: TObject);
begin
    ManualForm.ShowModal;
end;

end.
