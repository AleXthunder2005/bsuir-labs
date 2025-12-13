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
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    CalculateButton: TButton;
    Label5: TLabel;
    AnswerLabel: TLabel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    CopyPastePopupMenu: TPopupMenu;
    PasteButton: TMenuItem;
    procedure OpenMenuItemClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CalculateButtonClick(Sender: TObject);
    procedure EditDblClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure SaveAsMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

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

Function CalculateResult():Real;
Begin

End;

Function CheckEdit (Edit: TEdit): Boolean;
Begin
    With Edit Do
    Begin
        If (Length(Text) = 0) Or (Text = '-') Then
            CheckEdit := False
        Else
            CheckEdit := True;
    End;
End;

Procedure EditButton1Enable();
var
    IsEditsCorrect: Boolean;
    I: Byte;
Begin
    With MainForm Do
    Begin
        I := 0;
        Repeat
            Inc(I);
            IsEditsCorrect := CheckEdit(TEdit(FindComponent('Edit' + IntToStr(I))));
        Until (Not IsEditsCorrect) Or (I = 3);
        If IsEditsCorrect Then
            CalculateButton.Enabled := True
        Else
            CalculateButton.Enabled := False;
    End;
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

////////////////////////////POPUP MENU /////////////////////////////////////
procedure TMainForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    Num, Code: Integer;
begin
    Val(Clipboard.AsText, Num, Code);
    If Clipboard.HasFormat(CF_TEXT) And ((Code = 0) And (Num < MAX+1) And (Num > MIN-1)) Then
        PasteButton.Enabled := True
    Else
        PasteButton.Enabled := False;
end;

procedure TMainForm.PasteButtonClick(Sender: TObject);
var
    Num, Code: Integer;
begin
    with TEdit(ActiveControl)do
    Begin
        PasteFromClipboard;
        Val(Text, Num, Code);
        If (Code <> 0) Or (Num < MIN) Or (Num > MAX) Then
        Begin
            Text := '';
            Beep;
        End;
    End;
end;

procedure TMainForm.CutButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CutToClipboard;
end;

procedure TMainForm.CopyButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CopyToClipboard;
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
            Writeln(FileOut, 'Наибольшее значение функции на промежутке равно: ', AnswerLabel.Caption);
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

//////////////////////////////// EDIT /////////////////////////////////////////
procedure TMainForm.EditChange(Sender: TObject);
var
    S:String;
begin
    with Sender As TEdit do
    Begin
        if (Length(Text) > 1) then
        Begin
            if ((Text[1] = kMINUS ) Or (Text[1] = '0')) And (Text[2] = '0') then
            Begin
                S := Text;
                Delete(S, 2, 1);
                Text := S;
            End
            Else
            if (Text[1] = '0') And (Text[2] <> '0') then
            Begin
                S := Text;
                Delete(S, 1, 1);
                Text := S;
            End;

        End;

        EditButton1Enable;
        if AnswerLabel.Caption <> '...' then
        Begin
            AnswerLabel.Caption := '...';
            SaveAsMenuItem.Enabled := False;
            SaveMenuItem.Enabled := False;
        End;
    End;
end;

procedure TMainForm.EditDblClick(Sender: TObject);
begin
    with Sender As TEdit do
        Text := '';
end;

procedure TMainForm.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Begin
    with MainForm, Sender As TEdit do
    case key of
    kENTER, kDOWN:
        SelectNext(ActiveControl, True, True);
    kUP:
        SelectNext(ActiveControl, False, True);
    kINSERT:
        Key := 0;
    end;
End;

procedure TMainForm.EditKeyPress(Sender: TObject; var Key: Char);
var
    Num, Code: Integer;
    S: String;
begin
    with Sender As TEdit Do
        case key of
            '0'..'9', kMINUS:
            Begin
                S := Text;
                Insert(Key, S, SelStart+1);
                Val (S, Num, Code);
                If (Code <> 0) And (S <> '-')  Then
                Begin
                    Key := kNULL;
                    Beep;
                End
                Else
                    If (Num > MAX) Or (Num < MIN) Then
                    Begin
                        Key := kNULL;
                        Beep;
                    End
            End;
            kBACKSPACE:;
        Else
            Key := kNULL;
        end;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, '1. Последовательно введите все коэффициенты и задайте отрезок соответствующими значениями (целые числа от -1000 до 1000) в соответствующие поля.' + #13#10 + '2. Нажмите кнопку "Вычислить".' + #13#10 + '3. Получите результат!'+ #13#10 + '4. В случае ввода из файла убедитесь, что файл содержит все 7 чисел, записанных в отдельных строках', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

//////////////////////////////////// OPEN ////////////////////////////////////////
Function ReadNumFromFile(Var FileIn: TextFile; Var Num: Integer): Boolean;
Var
    IsFileCorrect: Boolean;
    NumStr: String;
    Code: Integer;

Begin
    Readln(FileIn, NumStr);
    Val(NumStr, Num, Code);

    If Code = 0 then
        IsFileCorrect := True
    Else
    Begin
        MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
        IsFileCorrect := False;
    End;

    If (IsFileCorrect) And ((Num < MIN) Or (Num > MAX)) then
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
    A, B, C: Integer;
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
            IsFileCorrect := ReadNumFromFile(FileIn, A);
            If (IsFileCorrect) Then
                IsFileCorrect := ReadNumFromFile(FileIn, B);
            If (IsFileCorrect) Then
                IsFileCorrect := ReadNumFromFile(FileIn, C);

            If (IsFileCorrect) And Not EoF(FileIn) then
            Begin
                IsFileCorrect := False;
                MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
            End;

            CloseFile(FileIn);

            If (IsFileCorrect) then
            Begin
                Edit1.Text := IntToStr(A);
                Edit2.Text := IntToStr(B);
                Edit3.Text := IntToStr(C);

            End;
        End;
    End;
end;
end.
