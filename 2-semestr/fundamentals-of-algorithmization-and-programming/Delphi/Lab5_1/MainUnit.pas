unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Grids, Clipbrd;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    SaveAsMenuItem: TMenuItem;
    ManualMenuItem: TMenuItem;
    AboutDeveloperMenuItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    CopyPastePopupMenu: TPopupMenu;
    CopyButton: TMenuItem;
    PasteButton: TMenuItem;
    CutButton: TMenuItem;
    FirstListGrid: TStringGrid;
    AddToFirstListButton: TButton;
    FirstListEdit: TEdit;
    SecondListGrid: TStringGrid;
    AddToSecondListButton: TButton;
    SecondListEdit: TEdit;
    ResultListGrid: TStringGrid;
    MergeButton: TButton;
    ConditionLabel: TLabel;
    ResetButton: TButton;
    ExitButton: TButton;
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure SaveAsMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddToFirstListButtonClick(Sender: TObject);
    procedure AddToSecondListButtonClick(Sender: TObject);
    procedure MergeButtonClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure EditDblClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    MainForm: TMainForm;

implementation
uses
    ListLibraryInit;

const
    kMINUS = #45;
    kBACKSPACE = #8;
    kINSERT = 45;
    MAX = 9999999;
    MIN = -999999;

var
    FirstListHeader, SecondListHeader, ResultListHeader: TElemPointer;

{$R *.dfm}

procedure TMainForm.AboutDeveloperMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, 'Разработчик: Наривончик Александр Михайлович, гр. 351004', 'О разработчике', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, '1. Заполните оба списка целочисленными значениями от -999999 до 9999999' + #13#10 + '2. Нажмите кнопку "Выполнить слияние".' + #13#10 + '3. Получите результат!'+ #13#10 + '4. В случае ввода из файла убедитесь, что файл содержит элементы (числа от -999999 до 9999999) первого списка записанные в отдельных строках, затем символ "-" в новой строке, а затем элементы второго списка.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

procedure OutputNewValueToGrid(NewValue: String; Grid: TStringGrid);
begin
    with Grid do
    begin
        if Cells[0, 1].IsEmpty then
            Cells[0, 1] := NewValue
        else
        begin
            RowCount := RowCount + 1;
            Cells[0, RowCount - 1] := NewValue;
        end;
    end;
end;

procedure OutputList (Header: TElemPointer; Grid: TStringGrid);
var
    Curr: TElemPointer;
begin
    Curr := Header;

    while Curr^.Next <> nil do
    begin
        Curr := Curr^.Next;
        OutputNewValueToGrid(IntToStr(Curr^.Value), Grid);
    end;
end;

procedure ClearStringGrid (Grid: TStringGrid);
var
    I: Integer;
begin
    with Grid do
    begin
        for I := RowCount-1 DownTo 1 do
            Cells[0, I] := '';
        RowCount := 2;
    end;
end;

procedure TMainForm.AddToFirstListButtonClick(Sender: TObject);
begin
    InsertElement(FirstListHeader, StrToInt(FirstListEdit.Text));
    ClearStringGrid(FirstListGrid);
    OutputList(FirstListHeader, FirstListGrid);

    FirstListEdit.Text := '';
end;

procedure TMainForm.AddToSecondListButtonClick(Sender: TObject);
begin
    InsertElement(SecondListHeader, StrToInt(SecondListEdit.Text));
    ClearStringGrid(SecondListGrid);
    OutputList(SecondListHeader, SecondListGrid);

    SecondListEdit.Text := '';
end;

procedure TMainForm.CopyButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CopyToClipboard;
end;

procedure TMainForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    IValue: Integer;
    Buffer: String;
begin
    Buffer := Clipboard.AsText;
    PasteButton.Enabled := True;
    PasteButton.Enabled := TryStrToInt(Buffer, IValue)
end;

procedure TMainForm.CutButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CutToClipboard;
end;

procedure TMainForm.PasteButtonClick(Sender: TObject);
begin
     TEdit(ActiveControl).PasteFromClipboard;
end;

procedure TMainForm.EditKeyPress(Sender: TObject; var Key: Char);
begin
    if Not (Key in ['0'..'9', kBACKSPACE, kMINUS]) then
        Key := #0;
end;

procedure TMainForm.ExitButtonClick(Sender: TObject);
begin
    MainForm.Close;
end;

procedure TMainForm.EditDblClick(Sender: TObject);
begin
    TEdit(ActiveControl).Text := '';
end;

procedure TMainForm.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = kINSERT then
        Key := 0;
end;

procedure EditAddButtonEnabled(ActiveEdit: TEdit);
begin
    with ActiveEdit do
    begin
    if Name = 'FirstListEdit' then
        MainForm.AddToFirstListButton.Enabled := not ((Text = '') or (Text = '-'))
    else
        if Name = 'SecondListEdit' then
            MainForm.AddToSecondListButton.Enabled := not ((Text = '') or (Text = '-'));
    end;
end;

procedure TMainForm.EditChange(Sender: TObject);
var
    CursPos: Byte;
    TempStr: String;
    IValue: Integer;
begin
    with TEdit(Sender) do
    begin
        if (Length(Text) > 0) And (Text <> '-') then
        begin
            CursPos := SelStart;
            TempStr := Text;

            if not TryStrToInt(TempStr, IValue) then
            begin
                Delete (TempStr, SelStart, 1);
                Text := TempStr;
                SelStart := CursPos-1;
            end
            else
            begin
                Text := IntToStr(IValue);
                SelStart := CursPos;
            end;
        end;
    end;

    EditAddButtonEnabled(TEdit(Sender));
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    FirstListGrid.Cells[0, 0] := 'Первый список';
    SecondListGrid.Cells[0, 0] := 'Второй список';
    ResultListGrid.Cells[0, 0] := 'Результат';

    FirstListHeader := InitializeList();
    SecondListHeader := InitializeList();
    ResultListHeader := InitializeList();
end;

procedure TMainForm.MergeButtonClick(Sender: TObject);
begin
    ClearStringGrid(ResultListGrid);
    ResultListHeader := MergeLists(FirstListHeader, SecondListHeader);
    OutputList(ResultListHeader, ResultListGrid);

    SaveAsMenuItem.Enabled := True;
    SaveMenuItem.Enabled := True;
end;

function ReadNumFromFile(var FileIn: TextFile): Integer;
var
    IsFileCorrect: Boolean;
    NumStr: String;
    Code: Integer;
    Num: Integer;

begin
    Readln(FileIn, NumStr);

    if NumStr = '-' then
        ReadNumFromFile := -1
    else
    begin
        Val(NumStr, Num, Code);

        if Code = 0 then
            IsFileCorrect := True
        else
        begin
            MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
            IsFileCorrect := False;
        end;

        if (IsFileCorrect) and ((Num < MIN) or (Num > MAX)) then
        begin
            MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
            IsFileCorrect := False;
        end;

        if IsFileCorrect then
            ReadNumFromFile := 1
        else
            ReadNumFromFile := 0
    end;
end;

function CheckFile(var FileIn: TextFile): Boolean;
var
    IsFileCorrect: Boolean;
    Code: Integer;
begin
    IsFileCorrect := True;

    repeat
        Code := ReadNumFromFile(FileIn);

        case Code of
            -1:;
            0:IsFileCorrect := False;
            1:IsFileCorrect := True;
        end;
    until not isFileCorrect or (Code = -1) or EoF(FileIn);

    if isFileCorrect and not Eof(FileIn) then
    begin
        repeat
            Code := ReadNumFromFile(FileIn);

            if Code = -1 then
            begin
                IsFileCorrect := False;
                MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
            end
            else
                if Code = 1 then
                    IsFileCorrect := True
                else
                    IsFileCorrect := False;

        until not IsFileCorrect or EoF(FileIn);

    end;
    CheckFile := IsFileCorrect;
end;

procedure ResetProgram();
begin
    with MainForm do
    begin
        ClearStringGrid(ResultListGrid);
        ClearStringGrid(FirstListGrid);
        ClearStringGrid(SecondListGrid);

        DisposeList(ResultListHeader);
        DisposeList(FirstListHeader);
        DisposeList(SecondListHeader);

        FirstListEdit.Text := '';
        SecondListEdit.Text := '';

        SaveAsMenuItem.Enabled := False;
        SaveMenuItem.Enabled := False;
    end;
end;

procedure TMainForm.OpenMenuItemClick(Sender: TObject);
var
    FileIn: TextFile;
    Path, Value: String;
    IsFileCorrect: Boolean;
begin
    If OpenDialog.Execute Then
    Begin

        ResetProgram;

        IsFileCorrect := True;
        Path := OpenDialog.FileName;
        AssignFile(FileIn, Path);

        Try
            Reset(FileIn);
        Except
            IsFileCorrect := False;
            MessageBox(Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
        End;

        if IsFileCorrect then
        begin
            IsFileCorrect := CheckFile(FileIn);
            CloseFile(FileIn);
        end;

        If IsFileCorrect Then
        Begin
            Reset(FileIn);

            repeat
                Readln(FileIn, Value);
                if Value <> '-' then
                    InsertElement(FirstListHeader, StrToInt(Value));
            until (Value = '-') or EoF(FileIn);

            if (Value = '-') and not EoF(FileIn) then
            begin
                repeat
                    Readln(FileIn, Value);
                    InsertElement(SecondListHeader, StrToInt(Value));
                until EoF(FileIn);
            end;

            CloseFile(FileIn);

            OutputList(FirstListHeader, FirstListGrid);
            OutputList(SecondListHeader, SecondListGrid);
        End;
    End;
end;

procedure TMainForm.ResetButtonClick(Sender: TObject);
begin
    ResetProgram;
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
            CloseFile(FileOut);
            OutputListToTextFile(ResultListHeader, FileOut);
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
