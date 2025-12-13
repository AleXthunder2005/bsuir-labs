unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtDlgs, Clipbrd,
  Vcl.Grids, Vcl.ExtCtrls;

type
    TArray = Array of Integer;
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
    Label4: TLabel;
    Edit1: TEdit;
    BuildButton: TButton;
    AnswerLabel: TLabel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    CopyPastePopupMenu: TPopupMenu;
    PasteButton: TMenuItem;
    StringGrid: TStringGrid;
    RangeLabel: TLabel;
    InfoAnswerLabel: TLabel;
    CalculateButton: TButton;
    procedure OpenMenuItemClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BuildButtonClick(Sender: TObject);
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
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CalculateButtonClick(Sender: TObject);
    procedure StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  N: Integer;
  IsBuilded: Boolean;



const
    MAX = 10;
    MIN = 1;
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


Function CheckEdit (Edit: TEdit): Boolean;
Begin
    With Edit Do
    Begin
        If (Length(Text) = 0) Then
            CheckEdit := False
        Else
            CheckEdit := True;
    End;
End;

Procedure EditButton1Enable();
var
    IsEditsCorrect: Boolean;
Begin
    With MainForm Do
    Begin
        IsEditsCorrect := CheckEdit(Edit1);
        If IsEditsCorrect Then
            BuildButton.Enabled := True
        Else
            BuildButton.Enabled := False;
    End;
End;

Procedure ClearStringGrid();
Var
    I: Integer;
Begin
    for I := 0 to 10 do
        MainForm.StringGrid.Cells[I Mod 6, I Div 6] := '';
End;

procedure TMainForm.BuildButtonClick(Sender: TObject);
begin
    IsBuilded := True;
    ClearStringGrid;
    N := StrToInt (Edit1.Text);
    StringGrid.Visible := False;
    StringGrid.Visible := True;
    MainForm.AnswerLabel.Caption := '...';
    SaveAsMenuItem.Enabled := False;
    SaveMenuItem.Enabled := False;
    MainForm.CalculateButton.Enabled := False;
end;

////////////////////////////POPUP MENU /////////////////////////////////////
procedure TMainForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    Num, Code: Integer;
begin
    Val(Clipboard.AsText, Num, Code);
    If Clipboard.HasFormat(CF_TEXT) And ((Code = 0) And (Num < MAX+1) And (Num > -1)) Then
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

Function CheckNumber(Num: Integer): Boolean;
Var
    I: Integer;
    NumRoot: Real;
Begin
    NumRoot := Sqrt(Num);
    I := 1;
    Repeat
        Inc(I);
    Until ((Num Mod I = 0) Or (I > NumRoot));

    CheckNumber := (I > NumRoot);
    If Num = 1 Then
        CheckNumber := False;
End;

Function GetСountOfPrimeNumbers(Var Arr: TArray): Integer;
Var
    I, Count: Integer;
    IsPrimeNumber: Boolean;
Begin
    Count := 0;

    For I := 0 To High(Arr) Do
    Begin
        IsPrimeNumber := CheckNumber(Arr[I]);
        If IsPrimeNumber Then
            Inc(Count);
    End;
    GetСountOfPrimeNumbers := Count;
End;

Procedure CalculateResult;
Var
    Arr: TArray;
    I, J, K: Integer;
Begin
    SetLength(Arr, N);
    K := 0;
    I := 0;
    Repeat
        J := 0;
        Repeat
            Arr[K] := StrToInt(MainForm.StringGrid.Cells[J, I]);
            Inc(K);
            Inc(J);
        Until (J = 5) Or (K = N);
        Inc(I);
    Until (I = 2) Or (K = N);
    MainForm.Answerlabel.Caption := IntToStr(GetСountOfPrimeNumbers(Arr));
End;

procedure TMainForm.CalculateButtonClick(Sender: TObject);
begin
    CalculateResult;
    SaveAsMenuItem.Enabled := True;
    SaveMenuItem.Enabled := True;
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
            Writeln(FileOut, MainForm.InfoAnswerLabel.Caption + ' ' + MainForm.AnswerLabel.Caption);
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

procedure TMainForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
Var
    IsLocked: Boolean;
begin
    if IsBuilded then
    Begin
        if N < 5 then
            IsLocked := (Arow = 1) Or (Acol > N-1)
        else
            IsLocked := (Acol Mod 5 >= N Mod 5) And (Arow Div 1 >= N Div 5);
    End
    Else
    IsLocked := True;
    if IsLocked then
    begin
        StringGrid.Canvas.Brush.Color:=clGrayText;
        StringGrid.Canvas.FillRect(StringGrid.CellRect(ACol,ARow));
    end;
end;

procedure TMainForm.StringGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Begin
    with MainForm, Sender As TStringGrid do
    case key of
    kINSERT:
        Key := 0;
    end;
End;

procedure TMainForm.StringGridKeyPress(Sender: TObject; var Key: Char);
begin
    with Sender As TStringGrid Do
        case key of
            '0'..'9':;
            kBACKSPACE:;
        Else
            Key := kNULL;
        end;
end;

procedure TMainForm.StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
  Var
    IsLocked: Boolean;
begin
    if IsBuilded then
    Begin
    if N < 5 then
        IsLocked := (Arow = 1) Or (Acol > N-1)
    else
        IsLocked := (Acol Mod 5 >= N Mod 5) And (Arow Div 1 >= N Div 5);
    End
    Else
        IsLocked := True;
    if IsLocked then
        StringGrid.Options := StringGrid.Options - [goEditing]
    Else
        StringGrid.Options := StringGrid.Options + [goEditing];

end;

Procedure EditCalculateButtonEnabled();
Var
    K, I, J: Integer;
    IsStringGridCorrect: Boolean;
Begin
    IsStringGridCorrect := True;
    K := 0;
    I := 0;
    Repeat
        J := 0;
        Repeat
        If MainForm.StringGrid.Cells[J, I] = '' then
            IsStringGridCorrect := False;
            Inc(K);
            Inc(J);
        Until Not IsStringGridCorrect Or (J = 5) Or (K = N);
        Inc(I);
    Until Not IsStringGridCorrect Or (I = 2) Or (K = N);

    if IsStringGridCorrect then
        MainForm.CalculateButton.Enabled := True
    Else
        MainForm.CalculateButton.Enabled := False;
End;

procedure TMainForm.StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
   IValue : Integer;
   S:String;
begin

    With (Sender as TStringGrid) Do
    Begin
        if  not TryStrToInt(Value, IValue) Or (IValue < MIN) Or (IValue > 100) then
        Begin
            Cells[ACol, ARow] := '';
            Beep;
        End;
        if (Length(Cells[ACol, ARow]) > 0) And (Cells[ACol, ARow][1] = '0') then
        Begin
            S := Cells[ACol, ARow];
            Delete(S, 1, 1);
            Cells[ACol, ARow] := S;
        End;
     End;
   EditCalculateButtonEnabled;
   MainForm.AnswerLabel.Caption := '...';
   SaveAsMenuItem.Enabled := False;
   SaveMenuItem.Enabled := False;
end;

//////////////////////////////// EDIT /////////////////////////////////////////
procedure TMainForm.EditChange(Sender: TObject);
var
    S:String;
begin
    with Sender As TEdit do
    Begin
        if (Length(Text) > 0) And (Text[1] = '0') then
        Begin
            S := Text;
            Delete(S, 1, 1);
            Text := S;
        End;

        IsBuilded := False;
        EditButton1Enable;
        MainForm.AnswerLabel.Caption := '...';
        ClearStringGrid;
        MainForm.CalculateButton.Enabled := False;

        If SaveAsMenuItem.Enabled = True then
        Begin
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
            '0'..'9':
            Begin
                S := Text;
                Insert(Key, S, SelStart+1);
                Val (S, Num, Code);
                If (Code <> 0) Or (Num > MAX) Or (Num < MIN)  Then
                Begin
                    Key := kNULL;
                    Beep;
                End;
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
    MessageBox(Handle, '1. Введите в соответствующее поле количество N элементов массива (число от 1 до 10).' + #13#10 + '2. Нажмите кнопку "Построить".' + #13#10 + '3. Последовательно введите в каждое поле таблицы элементы массива (числа от 1 до 100).'+ #13#10 + '4. Нажмите кнопку "Вычислить".' + #13#10 + '5. Получите результат!' + #13#10 + '6. В случае ввода из файла убедитесь, что файл содержит количество элементов массива(от 1 до 10) и сами элементы массива (от 1 до 100), записанные в отдельных строках.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
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
    Temp, I, J, K: Integer;
    Arr:TArray;
    IsFileCorrect: Boolean;
begin
    If OpenDialog.Execute Then
    Begin
        IsFileCorrect := True;
        Path := OpenDialog.FileName;
        AssignFile(FileIn, Path);

        ClearStringGrid;
        MainForm.Edit1.Text := '';

        Try
            Reset(FileIn);
        Except
            IsFileCorrect := False;
            MessageBox(Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
        End;

        If (IsFileCorrect) Then
        Begin
            IsFileCorrect := ReadNumFromFile(FileIn, N);
            if IsFileCorrect then
            Begin
                SetLength(Arr, N);
                I := 0;
                Repeat
                    IsFileCorrect := ReadNumFromFile(FileIn, Temp);
                    if IsFileCorrect then
                        Arr[I] := Temp;
                    Inc(I);
                Until Not IsFileCorrect Or (I = N);

            End;

            If (IsFileCorrect) And Not EoF(FileIn) then
            Begin
                IsFileCorrect := False;
                MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
            End;

            CloseFile(FileIn);

            MainForm.StringGrid.Visible := False;
            MainForm.StringGrid.Visible := True;

            If (IsFileCorrect) then
            Begin
                Edit1.Text := IntToStr(N);
                IsBuilded := True;

                K := 0;
                I := 0;
                Repeat
                    J := 0;
                    Repeat
                        MainForm.StringGrid.Cells[J, I] := IntToStr(Arr[K]);
                        Inc(K);
                        Inc(J);
                    Until (J = 5) Or (K = N);
                    Inc(I);
                Until (I = 2) Or (K = N);
                MainForm.CalculateButton.Enabled := True;
             End;
        End;
    End;
end;
end.
