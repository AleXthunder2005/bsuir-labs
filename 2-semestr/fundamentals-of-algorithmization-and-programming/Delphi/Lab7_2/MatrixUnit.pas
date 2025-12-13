unit MatrixUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus;

type
  TMatrixForm = class(TForm)
    DownPanel: TPanel;
    ExitButton: TButton;
    UpPanel: TPanel;
    TitleLabel: TLabel;
    ScrollBox: TScrollBox;
    MainImage: TImage;
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    SaveDialog: TSaveDialog;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MatrixForm: TMatrixForm;

implementation
uses
    MatrixImplemetUnit;

const
    CELL_WIDTH = 30;
    PAD = 30;
    TEXT_PAD = 10;

{$R *.dfm}

procedure TMatrixForm.ExitButtonClick(Sender: TObject);
begin
    MatrixForm.Close;
end;

procedure OutputMatrix();
var
    I, J, X, Y: Word;
begin
    MatrixForm.MainImage.Picture := nil;
    with MatrixForm.MainImage.Canvas do
    begin
        Font.Name := 'System';
        Pen.Color := clDefault;
        Brush.Color := clSkyBlue;

        Y := PAD;
        for I := Low(Matrix)+1 to High(Matrix)+1 do
        begin
            X := PAD + I * CELL_WIDTH;

            Rectangle(X, Y, X + CELL_WIDTH, Y + CELL_WIDTH);
            TextOut(X + TEXT_PAD, Y + TEXT_PAD, IntToStr(I));

            Rectangle(Y, X, Y + CELL_WIDTH, X + CELL_WIDTH);
            TextOut(Y + TEXT_PAD, X + TEXT_PAD, IntToStr(I));
        end;

        for I := Low(Matrix) to High(Matrix) do
        begin
            X := PAD + CELL_WIDTH + I * CELL_WIDTH;
            for J := Low(Matrix) to High(Matrix) do
            begin
                if Matrix[I, J] = 0 then
                    Brush.Color := clBtnHighlight
                else
                    Brush.Color := TColor($0093DAFF);

                Y := PAD + CELL_WIDTH + J * CELL_WIDTH;
                Rectangle(X, Y, X + CELL_WIDTH, Y + CELL_WIDTH);
                TextOut(X + TEXT_PAD, Y + TEXT_PAD, IntToStr(Matrix[I,J]));
            end;
        end;
    end;
end;

procedure EditImageSize();
var
    Size: Word;
begin
    Size := Length(Matrix) * CELL_WIDTH + 2 * PAD + CELL_WIDTH;
    with MatrixForm.MainImage do
    begin
        Align := alClient;
        if (Size > Width) or (Size > Height) then
        begin
            Align := alNone;
            Width := Size;
            Height := Size;
        end
        else
            Align := alClient;
    end;

end;

procedure TMatrixForm.FormShow(Sender: TObject);
begin
    FillMatrix();
    EditImageSize();
    OutputMatrix();
end;

Function IsSaveFilesPathCorrect(var SaveFile: TextFile): Boolean;
Var
    IsFileCorrect: Boolean;
    Path: String;
Begin
    With MatrixForm Do
    Begin
        IsFileCorrect := True;

        Path := SaveDialog.FileName;
        AssignFile(SaveFile, Path);

        If FileExists(Path) And (MessageBox(Handle, 'Вы действетельно хотите перезаписать файл?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDNO) Then
            IsFileCorrect := False;

        If IsFileCorrect Then
            Try
                Rewrite(SaveFile);
            Except
                IsFileCorrect := False;
                MessageBox(Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
            End;

        If IsFileCorrect Then
            CloseFile(SaveFile);
    End;

    IsSaveFilesPathCorrect := IsFileCorrect;
End;

procedure TMatrixForm.SaveMenuItemClick(Sender: TObject);
Var
    SaveFile: TextFile;
    I, J: Word;
begin
    If SaveDialog.Execute And IsSaveFilesPathCorrect(SaveFile) Then
    Begin
        Rewrite(SaveFile);
        Writeln(SaveFile, 'Полученная матрица смежности:');

        for I := Low(Matrix) to High(Matrix) do
        begin
            for J := Low(Matrix) to High(Matrix) do
                 Write(SaveFile, Matrix[I,J], ' ');

            Writeln(SaveFile);
        end;

        CloseFile(SaveFile);
        MessageBox(Handle, 'Сохранено успешно!', 'Сохранение', MB_YESNO Or MB_ICONINFORMATION);
    End;
end;

end.
