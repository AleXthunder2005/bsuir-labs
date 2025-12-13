unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtDlgs, Clipbrd;

type
  TSet = Set Of Char;
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

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    MainForm: TMainForm;
    Text: AnsiString;
    AnswerSet: TSet;

const
    MAX = 1000;
    MIN = -1000;
    kNULL = #0;
    kBACKSPACE = #8;
    kMINUS = #45;
    kDOWN = 40;
    kUP = 38;
    kENTER = 13;
    kINSERT = 45;

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
        if Trim(Memo.Text) = '' then
            CalculateButton.Enabled := False
        Else
            CalculateButton.Enabled := True;
    End;
End;

Procedure FindSymbols(Line: AnsiString);
Var
    I: Integer;
Const
    SearchCharacters = ['+', '-', '/', '*', '0'..'9'];
Begin
    AnswerSet := [];
    For I := 1 To Length(Line) Do
        If Line[I] In SearchCharacters Then
            Include(AnswerSet, Line[I]);
End;

procedure TMainForm.CalculateButtonClick(Sender: TObject);
var
    TextIn, BufText: AnsiString;
    I: Integer;
    C:Char;
begin
    I := 0;
    TextIn := '';
    Repeat
        BufText := Memo.Lines[I];
        TextIn := TextIn + BufText;
        Inc(I);
    Until I = Memo.Lines.Count;
    FindSymbols(TextIn);
    Memo.Text := Memo.Text + #13#10 + '-----------------------------------------------' + #13#10;
    If AnswerSet <> [] Then
    Begin
        For C := '*' To '9' Do
            If C In AnswerSet Then
                Memo.Text := Memo.Text + C + ' ';
    End
    Else
        Memo.Text := Memo.Text + 'В тексте не было найдено нужных символов';

    SaveAsMenuItem.Enabled := True;
    SaveMenuItem.Enabled := True;
end;

////////////////////////////POPUP MENU /////////////////////////////////////
procedure TMainForm.CopyPastePopupMenuPopup(Sender: TObject);
begin
    If Clipboard.HasFormat(CF_TEXT) Then
        PasteButton.Enabled := True
    Else
        PasteButton.Enabled := False;
end;

procedure TMainForm.PasteButtonClick(Sender: TObject);
begin
    with TMemo(ActiveControl)do
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
/////////////////////////////////////////// SAVE  ///////////////////////////
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

////////////////////////////////////////////////////////////////////////////////

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
    MessageBox(Handle, '1. Введите ваш текст.' + #13#10 + '2. Нажмите кнопку "Обработать".' + #13#10 + '3. Получите результат!'+ #13#10 + '4. В случае ввода из файла убедитесь, что файл содержит текст.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.MemoChange(Sender: TObject);
begin
    EditCalculateButtonEnabled;
    SaveMenuItem.Enabled := False;
    SaveAsMenuItem.Enabled := False;
end;

//////////////////////////////////// OPEN ////////////////////////////////////////

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
                TextIn := TextIn + BufText + ' ';
            Until Eof(FileIn);
            Text := TextIn;
            Memo.Text := Text;
            CloseFile(FileIn);
        End;
    End;
end;
end.
