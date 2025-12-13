unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Clipbrd;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    ManualMenuItem: TMenuItem;
    AboutDeveloperMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    SaveAsMenuItem: TMenuItem;
    ConditionLabel: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    CalculateButton: TButton;
    Label5: TLabel;
    AnswerLabel: TLabel;
    CopyPastePopupMenu: TPopupMenu;
    CopyButton: TMenuItem;
    PasteButton: TMenuItem;
    CutButton: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure ManualMenuItemClick(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure CalculateButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure SaveAsMenuItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.AboutDeveloperMenuItemClick(Sender: TObject);
begin
   MessageBox(Handle, 'Разработчик: Наривончик Александр Михайлович, гр. 351004', 'О разработчике', MB_OK Or MB_ICONINFORMATION);
end;

Function CalculateResult():Real;
Var
    I, Fact, N: Integer;
    Sum: Real;

Begin
    N := StrToInt(MainForm.Edit1.Text);
    Sum := 0;
    Fact := 1;
    For I := 1 To N Do
    Begin
        Fact := Fact * I;
        Sum := Sum + 1 / Fact;
    End;
    CalculateResult:= Sum;
End;

procedure TMainForm.CalculateButtonClick(Sender: TObject);
var
    Answer: Real;
begin
    Answer := CalculateResult;
    AnswerLabel.Caption := FloatToStr(Answer);
    SaveAsMenuItem.Enabled := True;
    SaveMenuItem.Enabled := True;
end;

procedure TMainForm.CopyButtonClick(Sender: TObject);
begin
    Edit1.CopyToClipboard;
end;

procedure TMainForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    Num, Code: Integer;
begin
    Val(Clipboard.AsText, Num, Code);
    If Clipboard.HasFormat(CF_TEXT) And ((Code = 0) And (Num < 13)) Then
        PasteButton.Enabled := True
    Else
        PasteButton.Enabled := False;
end;

procedure TMainForm.CutButtonClick(Sender: TObject);
begin
    Edit1.CutToClipboard;
end;

procedure TMainForm.Edit1Change(Sender: TObject);
var
    S:String;
begin
    with Edit1 do
    Begin
        If (Length(Text) <> 0) And (Text[1] = '0') Then
        Begin
            S := Text;
            Delete(S, 1, 1);
            Text := S;
        End;

        If (Length(Edit1.Text) <> 0) Then
            CalculateButton.Enabled := True
        Else
            CalculateButton.Enabled := False;

        If AnswerLabel.Caption <> '...' then
        Begin
            AnswerLabel.Caption := '...';
            SaveAsMenuItem.Enabled := False;
            SaveMenuItem.Enabled := False;
        End;
    End;
end;

procedure TMainForm.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = 45 then
        Key := 0;
end;

procedure TMainForm.Edit1KeyPress(Sender: TObject; var Key: Char);
var
    Num: Word;
    S: String;
begin
    with Edit1 Do
        case key of
            '0'..'9':
            Begin
                If (Key = '0') And (SelStart = 0)  Then
                    Key := #0
                Else
                Begin
                    S := Text;
                    Insert(Key, S, SelStart+1);
                    Num := StrToInt(S);
                    If (Num > 12) Or (Num < 1) Then
                    Begin
                        Key := #0;
                        Beep;
                    End;
                End;
            End;
            #8:
        Else
            Key := #0;
        end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, '1. Введите число(от 1 до 12) в соответствующее поле.' + #13#10 + '2. Нажмите кнопку "Вычислить".' + #13#10 + '3. Получите результат!'+ #13#10 + '4. В случае ввода из файла убедитесь, что файл содержит только число от 1 до 12', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

Function ReadNumFromFile(Var FileIn: TextFile; Var Num: Integer): Boolean;
Var
    IsFileCorrect: Boolean;
    NumStr: String;
    Code: Integer;

Begin
    IsFileCorrect := True;
    Readln(FileIn, NumStr);
    Val(NumStr, Num, Code);

    If Code = 0 then
        IsFileCorrect := True
    Else
    Begin
        MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
        IsFileCorrect := False;
    End;

    If (IsFileCorrect) And ((Num < 1) Or (Num > 12)) then
    Begin
        MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
        IsFileCorrect := False;
    End;

    ReadNumFromFile := IsFileCorrect;
End;

procedure TMainForm.OpenMenuItemClick(Sender: TObject);
var
    FileIn: TextFile;
    Path: String;
    N: Integer;
    IsFileCorrect: Boolean;
begin
    If OpenDialog.Execute Then
    Begin
        IsFileCorrect := True;
        Path := OpenDialog.FileName;
        AssignFile(FileIn, Path);

        Try
            Reset(FileIn);
        Except
            IsFileCorrect := False;
            MessageBox(Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
        End;

        If (IsFileCorrect) Then
        Begin
            IsFileCorrect := ReadNumFromFile(FileIn, N);

            If (IsFileCorrect) And Not EoF(FileIn) then
            Begin
                IsFileCorrect := False;
                MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
            End;

            CloseFile(FileIn);

            If (IsFileCorrect) then
                Edit1.Text := IntToStr(N);
        End;
    End;
end;

procedure TMainForm.PasteButtonClick(Sender: TObject);
var
    Num, Code: Integer;
begin
    with TEdit(ActiveControl)do
    Begin
        PasteFromClipboard;
        Val(Text, Num, Code);
        If (Code <> 0) Or (Num < 1) Or (Num > 12) Then
        Begin
            Text := '';
            Beep;
        End;
    End;
end;

Procedure SaveAnswer ();
var
    IsFileCorrect: Boolean;
    FileOut: TextFile;
    Path: String;
Begin
    With MainForm Do
    Begin
        IsFileCorrect := True;
        Path := SaveDialog.FileName;
        AssignFile(FileOut, Path);
        Try
            Rewrite(FileOut);
        Except
            IsFileCorrect := False;
            MessageBox(Handle, 'Не удалось сохранить ответ в файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
        End;

        If IsFileCorrect then
        Begin
            Writeln(FileOut, 'Cумма равна: ', AnswerLabel.Caption);
            CloseFile(FileOut);
            MessageBox(Handle, 'Сохранено успешно!', 'Сохранение', MB_OK Or MB_ICONINFORMATION);
        End;
    End;
End;

procedure TMainForm.SaveAsMenuItemClick(Sender: TObject);
begin
    If SaveDialog.Execute Then
        SaveAnswer();
end;

procedure TMainForm.SaveMenuItemClick(Sender: TObject);
begin
    If(SaveDialog.FileName = 'Answer') Then
    Begin
        If SaveDialog.Execute Then
            SaveAnswer();
    End
    Else
        SaveAnswer();
end;

end.
