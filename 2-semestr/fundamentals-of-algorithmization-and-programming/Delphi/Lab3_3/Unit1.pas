unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtDlgs, Clipbrd,
  Vcl.Grids;

type
    TArr = Array of Integer;
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
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    CopyPastePopupMenu: TPopupMenu;
    PasteButton: TMenuItem;
    StringGrid: TStringGrid;
    CalculateButton: TButton;
    AnswerStringGrid: TStringGrid;
    Memo: TMemo;
    Label2: TLabel;
    Label3: TLabel;
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
    procedure FormCreate(Sender: TObject);
    procedure StringGridGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGridExit(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  ItemCount: Integer;
  DefaultFormWidth, BigFormWidth: Integer;

const
    MAX = 15;
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

Procedure ClearStringGrid();
Var
    I: Integer;
Begin
    for I := 0 to ItemCount-1 do
        MainForm.StringGrid.Cells[I, 1] := '';
    for I := 0 to ItemCount-1 do
        MainForm.AnswerStringGrid.Cells[I, 1] := '';
End;

Procedure EditButtonEnabled(Button: TButton);
var
    I:Integer;
Begin
    With MainForm Do
    Begin
        Button.Enabled := True;
        for I := 0 to ItemCount-1 do
            if (Trim(StringGrid.Cells[I, 1]) = '-') Or (Trim(StringGrid.Cells[I, 1])= '') then
                Button.Enabled := False;

        if  Button.Enabled = True then
            Button.Enabled := (Edit1.Text <> '');
    End;
End;

Function SortArr(Arr: TArr): TArr;
Var
    I, J, K, Buf: Integer;
Begin
    MainForm.Memo.Text := '';

    For K := Low(Arr) to High(Arr) do
        MainForm.Memo.Text := MainForm.Memo.Text + IntToStr(Arr[K]) + '  ';
    MainForm.Memo.Text := MainForm.Memo.Text + #13#10 + '---------------------------------------------------' + #13#10;

    For I := 1 to High(Arr)  do
    Begin
        Buf := Arr[I];
        J := I;
        While ((J > 0) And (Arr[J-1] > Buf)) Do
        Begin
            Arr[J] := Arr[J-1];
            Dec(J);
        End;
        Arr[J] := Buf;

        For K := Low(Arr) to High(Arr) do
            MainForm.Memo.Text := MainForm.Memo.Text + IntToStr(Arr[K]) + '  ';
        MainForm.Memo.Text := MainForm.Memo.Text + #13#10;

    End;
    SortArr := Arr;
End;


procedure TMainForm.CalculateButtonClick(Sender: TObject);
var
    NumArr: TArr;
    I: Integer;
begin
    SetLength(NumArr, ItemCount);
    for I := Low(NumArr) To High(NumArr) do
        NumArr[I] := StrToInt(StringGrid.Cells[I,1]);

    NumArr := SortArr(NumArr);

    for I := Low(NumArr) To High(NumArr) do
        AnswerStringGrid.Cells[I,1] := IntToStr(NumArr[I]) ;

    MainForm.Width := BigFormWidth;

    SaveAsMenuItem.Enabled := True;
    SaveMenuItem.Enabled := True;
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
    Num, Code, CursPos: Integer;
    S: String;
begin
    with TEdit(ActiveControl)do
    Begin
        CursPos := SelStart;
        S := Text;

        PasteFromClipboard;
        Val(Text, Num, Code);
        If (Code <> 0) Or (Num < MIN) Or (Num > MAX) Then
        Begin
            Text := S;
            SelStart := CursPos;
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
    I: Integer;
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
            Writeln(FileOut, 'Введенный массив:');
            for I := 0 to ItemCount-1 do
                Write(FileOut, StringGrid.Cells [I, 1]: 4);

            Writeln(FileOut);
            Writeln(FileOut, 'Отсортированный массив:');
            for I := 0 to ItemCount-1 do
                Write(FileOut, AnswerStringGrid.Cells [I, 1]: 4);

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

procedure TMainForm.StringGridExit(Sender: TObject);
var
    I,J: Integer;
    str: String;
begin
    for I := 0 to ItemCount do
    begin
       str := StringGrid.Cells[I, 1];
        j := 1;
        while J <= High(str) do
        begin
            if str[J] = ' ' then
            begin
                delete(str, j, 1);
                dec(J);
            end;
            inc(j);
        end;
        StringGrid.Cells[I, 1] := str;
    end;
end;

procedure TMainForm.StringGridGetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
    Value := '#99';
end;

procedure TMainForm.StringGridKeyPress(Sender: TObject; var Key: Char);
begin
    if Not(Key in ['0'..'9', #8, kMINUS]) then Key := #0;
end;

procedure TMainForm.StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
Var
    NumStr, Num:String;
    IValue, I: Integer;
begin
    EditButtonEnabled(CalculateButton);
    MainForm.Width := DefaultFormWidth;

    SaveAsMenuItem.Enabled := False;
    SaveMenuItem.Enabled := False;
end;

Procedure EditStringGrids;
var
    I:Integer;
Begin
    ClearStringGrid;
    With MainForm do
    Begin
        if Edit1.Text = '' then
        Begin
            ItemCount := 7;
            StringGrid.Options := StringGrid.Options - [goEditing];
        End
        Else
        Begin
            ItemCount := StrToInt(Edit1.Text);
            StringGrid.Options := StringGrid.Options + [goEditing];
        End;
        StringGrid.ColCount := ItemCount;
        AnswerStringGrid.ColCount := ItemCount;
        for I := 0 to ItemCount-1 do
        Begin
            StringGrid.Cells[I, 0] := IntToStr(I+1);
            AnswerStringGrid.Cells[I, 0] := IntToStr(I+1);
        End;
    End;
End;

//////////////////////////////// EDIT /////////////////////////////////////////
procedure TMainForm.EditChange(Sender: TObject);
var
    S:String;
    Num, Code, CursPos: Integer;
begin
    with Sender As TEdit do
    Begin
        S := Text;
        CursPos := SelStart;

        Val(S, Num, Code);
        If (Code = 0) And (Num > MIN-1) And (Num < MAX+1) Then
        Begin
            Text := IntToStr(Num);
            SelStart := CursPos;
        End
        Else
        Begin
            Delete (S, SelStart, 1);
            Text := S;
            SelStart := CursPos-1;
        End;

        if Text = '0' then
            Text := '';

        MainForm.Width := DefaultFormWidth;
        EditButtonEnabled(CalculateButton);
        EditStringGrids;
        ClearStringGrid;
    End;

    if SaveAsMenuItem.Enabled = True then
    Begin
        SaveAsMenuItem.Enabled := False;
        SaveMenuItem.Enabled := False;
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
    kINSERT:
        Key := 0;
    end;
End;

procedure TMainForm.EditKeyPress(Sender: TObject; var Key: Char);
begin
    with Sender As TEdit Do
        case key of
            '0'..'9':;
            kBACKSPACE:;
            kMINUS:;
        Else
            Key := kNULL;
        end;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
    I:Integer;
begin
    DefaultFormWidth := MainForm.Width;
    BigFormWidth := 900;
    ItemCount := 7;
    for I := 0 to ItemCount-1 do
    Begin
        StringGrid.Cells[I, 0] := IntToStr(I+1);
        AnswerStringGrid.Cells[I, 0] := IntToStr(I+1);
    End;
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, '1. Введите в соответствующее поле количество элементов массива(от 1 до 15).' + #13#10 + '2. Введите элементы массива (от -99 до 999)' + #13#10 + '3. Нажмите кнопку "Отсортировать".' + #13#10 + '4. Получите результат!'+ #13#10 + '5. В случае ввода из файла убедитесь, что файл содержит количество элементов и сами элементы массива, записанные в отдельных строках.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

//////////////////////////////////// OPEN ////////////////////////////////////////
Function ReadNumFromFile(Var FileIn: TextFile; Var Num: Integer; Const MINNUM: Integer; Const MAXNUM: Integer): Boolean;
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

    If (IsFileCorrect) And ((Num < MINNUM) Or (Num > MAXNUM)) then
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
    IsFileCorrect: Boolean;
    I, N: Integer;
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
            IsFileCorrect := ReadNumFromFile(FileIn, ItemCount, MIN, MAX);
            If (IsFileCorrect) then
            Begin
                Edit1.Text := IntToStr(ItemCount);
                I := 0;
                Repeat
                    IsFileCorrect := ReadNumFromFile(FileIn, N, -99, 999);
                    if IsFileCorrect then
                        StringGrid.Cells[I,1] := IntToStr(N);
                        Inc(I);
                Until Not IsFileCorrect Or (I = ItemCount);
            End;

            If (IsFileCorrect) And Not EoF(FileIn) then
            Begin
                IsFileCorrect := False;
                MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
            End;

            CloseFile(FileIn);
            if Not IsFileCorrect then
            Begin
                ClearStringGrid;
                EditStringGrids;
                Edit1.Text := '';
            End;

            EditButtonEnabled(CalculateButton);
        End;
    End;
end;
end.
