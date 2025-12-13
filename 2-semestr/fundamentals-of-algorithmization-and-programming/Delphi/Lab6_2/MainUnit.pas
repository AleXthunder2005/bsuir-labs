unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus, Clipbrd;

type
  TMainForm = class(TForm)
    ConditionLabel: TLabel;
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    ManualMenuItem: TMenuItem;
    AboutDeveloperMenuItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    CopyPastePopupMenu: TPopupMenu;
    CopyButton: TMenuItem;
    PasteButton: TMenuItem;
    CutButton: TMenuItem;
    BuildButton: TButton;
    ValueEdit: TEdit;
    StringGrid: TStringGrid;
    ResetButton: TButton;
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure ValueEditChange(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure ValueEditKeyPress(Sender: TObject; var Key: Char);
    procedure ValueEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BuildButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

type
  TMagicSquare = array of array of Integer;

const
    kMINUS = #45;
    kBACKSPACE = #8;
    kINSERT = 45;
    MAX = 19;
    Min = 3;

var
    MagicSquare: TMagicSquare;

{$R *.dfm}

procedure TMainForm.AboutDeveloperMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, 'Разработчик: Наривончик Александр Михайлович, гр. 351004', 'О разработчике', MB_OK Or MB_ICONINFORMATION);
end;

procedure ClearStringGrid (Grid: TStringGrid);
var
    I, J: Integer;
begin
    with Grid do
    begin
        for I := ColCount-1 downto 0 do
            for J := RowCount-1 DownTo 0 do
                Cells[J, I] := '';
        RowCount := 10;
        ColCount := 10;
    end;
end;

procedure BuildMagicSquare(var MagicSquare: TMagicSquare);
var
    I, J, N, K, M, Counter, Delta: Integer;
    TempMatrix: Array Of Array Of Integer;
begin
    N := Length(MagicSquare);
    SetLength(TempMatrix, 2*N-1, 2*N-1);

    I := Length(TempMatrix) div 2;
    J := 0;
    for Counter := 1 to Sqr(N) do
    begin
        TempMatrix[I, J] := Counter;

        if(Counter mod N = 0) then
        begin
            J := 0 + Counter div N;
            I := Length(TempMatrix) div 2 + Counter div N;
        end
        else
        begin
            Dec(I);
            Inc(J);
        end;
    end;

    Delta := N div 2;
    for K := Delta downto 1 do
    begin
        M := K;
        J :=  N div 2 - (Delta - K)-1;
        I := High(TempMatrix) div 2 - K + 1;

        while M > 0 do
        begin
            TempMatrix[I, High(TempMatrix)- Delta - (Delta-K)] := TempMatrix[I, J];
            TempMatrix[I, Delta + Delta-K] := TempMatrix[I, High(TempMatrix) - Delta + (Delta-K)+1];

            TempMatrix[High(TempMatrix)- Delta - (Delta-K), I] := TempMatrix[J, I];
            TempMatrix[Delta + Delta-K, I] := TempMatrix[High(TempMatrix)- Delta + (Delta-K)+1, I];

            Inc(I, 2);
            Dec(M);
        end;
    end;

    Delta := N div 2;
    for I := 0 to High(MagicSquare) do
        for J := 0 to High(MagicSquare) do
            MagicSquare[I, J] := TempMatrix[I + Delta, J + Delta];
end;

procedure OutputMagicSquare(MagicSquare: TMagicSquare);
var
    I, J: Integer;
begin
    with MainForm.StringGrid do
    begin
        RowCount := Length(MagicSquare);
        ColCount := Length(MagicSquare);

        for I := 0 to High(MagicSquare) do
        begin
            for J := 0 to High(MagicSquare) do
               Cells[J, I] := IntToStr(MagicSquare[I, J]);
        end;
    end;
end;

procedure TMainForm.BuildButtonClick(Sender: TObject);
var
    N: Integer;
begin
    ClearStringGrid(StringGrid);
    N := StrToInt(ValueEdit.Text);
    SetLength(MagicSquare, N, N);
    BuildMagicSquare(MagicSquare);
    OutputMagicSquare(MagicSquare);
    SaveMenuItem.Enabled := True;
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

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, '1. Введите в поле порядок магического квадрата (нечётное число от 3 до 19' + #13#10 + '2. Нажмите кнопку "Построить".' + #13#10 + '3. Получите результат!'+ #13#10 + '4. В случае ввода из файла убедитесь, что файл содержит нечётное число от 3 до 19.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

procedure ResetProgram();
begin
    with MainForm do
    begin
        ClearStringGrid(StringGrid);
        ValueEdit.Text := '';
        SaveMenuItem.Enabled := False;
    end;
end;

function ReadNumFromFile(var FileIn: TextFile; var Num: Integer): Boolean;
var
    IsFileCorrect: Boolean;
    NumStr: String;
    Code: Integer;
begin
    try
        Reset(FileIn);
    except
        IsFileCorrect := False;
        MessageBox(MainForm.Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
    end;
    if IsFileCorrect then
    begin
        Readln(FileIn, NumStr);
        Val(NumStr, Num, Code);

        if Code = 0 then
            IsFileCorrect := True
        else
        begin
            MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK or MB_ICONERROR);
            IsFileCorrect := False;
        end;

        if (IsFileCorrect) and ((Num < MIN) or (Num > MAX)) then
        begin
            MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK or MB_ICONERROR);
            IsFileCorrect := False;
        end;

        if (IsFileCorrect) and not Odd(Num) then
        begin
            MessageBox(MainForm.Handle, 'Число в файле должно быть нечётным!', 'Ошибка', MB_OK or MB_ICONERROR);
            IsFileCorrect := False;
        end;
        CloseFile(FileIn);
    end;
    ReadNumFromFile := IsFileCorrect;
End;

procedure TMainForm.OpenMenuItemClick(Sender: TObject);
var
    FileIn: TextFile;
    Path: String;
    TempNum: Integer;
begin
    if OpenDialog.Execute Then
    begin
        Path := OpenDialog.FileName;
        AssignFile(FileIn, Path);

        if ReadNumFromFile(FileIn, TempNum) then
        begin
            ResetProgram;
            ValueEdit.Text := IntToStr(TempNum);
            SetLength(MagicSquare, TempNum, TempNum);
            BuildMagicSquare(MagicSquare);
            OutputMagicSquare(MagicSquare);
            SaveMenuItem.Enabled := True;
        end;
    end;
end;

procedure TMainForm.PasteButtonClick(Sender: TObject);
begin
     TEdit(ActiveControl).PasteFromClipboard;
end;

procedure TMainForm.ResetButtonClick(Sender: TObject);
begin
    ResetProgram;
end;

procedure OutputSquareToTextFile(MagicSquare: TMagicSquare; var FileOut: TextFile);
var
    I, J: Integer;
begin
    for I := 0 to High(MagicSquare) do
    begin
        for J := 0 to High(MagicSquare) do
           Write(FileOut, IntToStr(MagicSquare[I, J]) + ' ');
        Writeln(FileOut);
    end;
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
            OutputSquareToTextFile(MagicSquare, FileOut);
            CloseFile(FileOut);
            MessageBox(Handle, 'Сохранено успешно!', 'Сохранение', MB_OK Or MB_ICONINFORMATION);
        End;
    End;
End;

procedure TMainForm.SaveMenuItemClick(Sender: TObject);
begin
    If SaveDialog.Execute Then
        SaveAnswer();
end;

procedure EditAddButtonEnabled(ActiveEdit: TEdit);
begin
    with ActiveEdit do
    begin
        MainForm.BuildButton.Enabled := not ((Text = '') or (Text = '1')) and Odd(StrToInt(Text));
    end;
end;

procedure TMainForm.ValueEditChange(Sender: TObject);
var
    CursPos: Byte;
    TempStr: String;
    IValue: Integer;
begin
    with TEdit(Sender) do
    begin
        if Text = '0' then
            Text := ''
        else
        if (Length(Text) > 0) and (Text <> '1') then
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

            if (IValue > Max) or (IValue < MIN) then
            begin
                Delete (TempStr, SelStart, 1);
                Text := TempStr;
                SelStart := CursPos-1;
            end
        end;
    end;

    EditAddButtonEnabled(TEdit(Sender));
end;

procedure TMainForm.ValueEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 begin
    if Key = kINSERT then
        Key := 0;
end;

procedure TMainForm.ValueEditKeyPress(Sender: TObject; var Key: Char);
begin
    if Not (Key in ['0'..'9', kBACKSPACE, kMINUS]) then
        Key := #0;
end;
end.
