unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtDlgs, Clipbrd;

type
  TMainForm = class(TForm)
    ConditionLabel: TLabel;
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    SaveAsMenuItem: TMenuItem;
    ManualMenuItem: TMenuItem;
    AboutDeveloperMenuItem: TMenuItem;
    CalculateButton: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    CopyPastePopupMenu: TPopupMenu;
    PasteButton: TMenuItem;
    Memo: TMemo;
    procedure OpenMenuItemClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CalculateButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure SaveAsMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure MemoKeyPress(Sender: TObject; var Key: Char);
    procedure MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

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

Procedure EditCalculateButtonEnabled();
Begin
    With MainForm Do
    Begin
        if Memo.Text = '' then
            CalculateButton.Enabled := False
        Else
            CalculateButton.Enabled := True;
    End;
End;


procedure EditLine(Line: String);
begin
    if Pos('AAAA', Line) <> 0 then
    begin
        Delete(Line, Pos('AAAA', Line), 4);
        EditLine(Line);
    end
    else
        if Pos('ABC', Line) <> 0 then
        begin
            Delete(Line, Pos('ABC', Line), 3);
            EditLine(Line);
        end
        else
            if Pos('BABA', Line) <> 0 then
            begin
                Delete(Line, Pos('BABA', Line), 2);
                EditLine(Line);
            end
            else
            begin
                MainForm.Memo.Text := Line;
            end;
end;

procedure TMainForm.CalculateButtonClick(Sender: TObject);
var
    TextIn, BufText: String;
    I: Integer;
begin
    I := 0;
    TextIn := '';
    Repeat
        BufText := Memo.Lines[I];
        TextIn := TextIn + BufText;
        Inc(I);
    Until I = Memo.Lines.Count;

    EditLine(TextIn);

    SaveAsMenuItem.Enabled := True;
    SaveMenuItem.Enabled := True;
end;

function IsTextCorrect(Text: String): Boolean;
var
    I: Integer;
    IsCorrect: Boolean;
begin
    IsCorrect := True;
    I := Low(Text);
    while (I <= High(Text)) And IsCorrect do
    begin
        if (Text[I] <> 'A') And (Text[I] <> 'B') And (Text[I] <> 'C') then
            IsCorrect := False;
        Inc(I);
    end;
    IsTextCorrect := IsCorrect;
end;

procedure TMainForm.CopyPastePopupMenuPopup(Sender: TObject);
begin
    If Clipboard.HasFormat(CF_TEXT) And IsTextCorrect(Clipboard.AsText)Then
        PasteButton.Enabled := True
    Else
        PasteButton.Enabled := False;
end;

procedure TMainForm.PasteButtonClick(Sender: TObject);
begin
    with MainForm.Memo do
    Begin
        PasteFromClipboard;
    End;
end;

procedure TMainForm.CutButtonClick(Sender: TObject);
begin
    TMemo(ActiveControl).CutToClipboard;
end;

procedure TMainForm.CopyButtonClick(Sender: TObject);
begin
    TMemo(ActiveControl).CopyToClipboard;
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
            Writeln(FileOut, Memo.Text);
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

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    Memo.Text := '';
    Memo.TextHint := 'Введите ваш текст';
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, '1. Введите последовательность символов А,В и С.' + #13#10 + '2. Нажмите кнопку "Обработать".' + #13#10 + '3. Получите результат!'+ #13#10 + '4. В случае ввода из файла убедитесь, что файл содержит последовательность из А,В и С.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.MemoChange(Sender: TObject);
begin
    EditCalculateButtonEnabled;
    SaveMenuItem.Enabled := False;
    SaveAsMenuItem.Enabled := False;
end;

procedure TMainForm.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = 45 then
        Key := 0;
end;

procedure TMainForm.MemoKeyPress(Sender: TObject; var Key: Char);
begin
    case Key of
        'A','B','C', #8:;
    else
        Key := #0;
    end;
end;

procedure TMainForm.OpenMenuItemClick(Sender: TObject);
var
    FileIn: TextFile;
    Path, BufText, TextIn: String;
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
            Repeat
                Readln(FileIn, BufText);
                TextIn := TextIn + BufText;
            Until Eof(FileIn);

            if IsTextCorrect(TextIn) then
            begin
                Memo.Text := TextIn;
            end
            else
                MessageBox(Handle, 'В файле должна быть последовательность из букв A,B и C!', 'Ошибка', MB_OK Or MB_ICONERROR);
            CloseFile(FileIn);
        End;
    End;
end;
end.
