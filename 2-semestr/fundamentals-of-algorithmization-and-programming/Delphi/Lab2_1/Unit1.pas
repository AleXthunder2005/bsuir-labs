unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtDlgs, Clipbrd,
  Vcl.Grids;

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
    Label4: TLabel;
    Edit1: TEdit;
    AnswerLabel: TLabel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    CopyPastePopupMenu: TPopupMenu;
    PasteButton: TMenuItem;
    StringGrid: TStringGrid;
    Label2: TLabel;
    Edit2: TEdit;
    CalculateButton: TButton;
    ResetButton: TButton;
    Label3: TLabel;
    Label5: TLabel;
    CoordCountEdit: TEdit;
    Label6: TLabel;
    procedure OpenMenuItemClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
    procedure ResetButtonClick(Sender: TObject);
    procedure CalculateButtonClick(Sender: TObject);
    procedure CoordCountEditChange(Sender: TObject);
    procedure CoordCountEditKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGridGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure StringGridExit(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  CoordCount: Integer;

const
    MAX = 999;
    MIN = -99;
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

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, '1. Введите в соответствующие поля количество вершин (от 3 до 20), координаты точки(от -99 до 999) и координаты каждой вершины (от -99 до 999).' + #13#10 + '2. Нажмите кнопку "Вычислить".' + #13#10 + '3. Получите результат!' + #13#10  + '4. В случае ввода из файла убедитесь, что файл содержит число от 3 до 20 (количество вершин), затем в каждой новой строке через пробел координаты каждой вершины, а затем и координаты точки.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.FormCreate(Sender: TObject);
Var
    I:Integer;
begin
    CoordCount := 3;
    StringGrid.Cells[0,1] := 'X';
    StringGrid.Cells[0,2] := 'Y';
    for I := 1 to CoordCount do
        StringGrid.Cells[I,0] := IntToStr(I);
end;

////////////////////////////////////////////////////////////////////////////////

Procedure ClearStringGrid();
Var
    I, J: Integer;
Begin
    for I := 1 to 2 do
        for j := 1 to CoordCount do
            MainForm.StringGrid.Cells[J, I] := '';
End;

Function CheckCoordEdit (Edit: TEdit): Boolean;
Begin
    With Edit Do
    Begin
        If (Length(Text) = 0) Or (Text = '1') Or (Text = '2') Then
            CheckCoordEdit := False
        Else
            CheckCoordEdit := True;
    End;
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

Procedure EditButtonEnabled(Button: TButton);
var
    IsEditsCorrect: Boolean;
    I:Integer;
Begin
    With MainForm Do
    Begin
        Button.Enabled := True;
        for I := 1 to CoordCount do
            if (Trim(StringGrid.Cells[I, 1]) = '-') Or (Trim(StringGrid.Cells[I, 2]) = '-') Or (Trim(StringGrid.Cells[I, 1])= '') Or (Trim(StringGrid.Cells[I, 2])= '') then
                Button.Enabled := False;

        if  Button.Enabled = True then
            Button.Enabled := (CheckEdit(Edit1) And CheckEdit(Edit2) And CheckCoordEdit(CoordCountEdit));
    End;
End;

Procedure ResetStringGrid();
Begin
    With MainForm Do
    Begin
        CoordCountEdit.Text := '';
        Edit1.Text := '';
        Edit2.Text := '';
        ClearStringGrid;
        CoordCount := 3;

        StringGrid.Visible := False;
        StringGrid.Visible := True;

        AnswerLabel.Caption := '';
        SaveAsMenuItem.Enabled := False;
        SaveMenuItem.Enabled := False;
    End;
End;

procedure TMainForm.ResetButtonClick(Sender: TObject);
begin
    ResetStringGrid;
end;
////////////////////////////POPUP MENU /////////////////////////////////////
procedure TMainForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    Num, Code: Integer;
begin
    Val(Clipboard.AsText, Num, Code);
    If (Code = 0) And (Num < MAX+1) And (Num > MIN-1) Then
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

procedure TMainForm.CalculateButtonClick(Sender: TObject);
Var
    N, I, X, Y, Min, Max: Integer;
    IsPointOnPolygon, IsPointOnLine, IsPointBetweenXCoord, IsPointBetweenYCoord: Boolean;
    ArrX, ArrY: Array Of Integer;
begin
    X := StrToInt(Edit1.Text);
    Y := StrToInt(Edit2.Text);

    SaveAsMenuItem.Enabled := True;
    SaveMenuItem.Enabled := True;

    N := CoordCount;
    SetLength(ArrX, N+1);
    SetLength(ArrY, N+1);

    for I := 1 to N do
    Begin
        ArrX[I-1] := StrToInt(StringGrid.Cells[I,1]);
        ArrY[I-1] := StrToInt(StringGrid.Cells[I,2]);
    End;

    ArrX[N] := ArrX[0];
    ArrY[N] := ArrY[0];

    I := 1;
    Repeat
        IsPointOnLine := ((Y - ArrY[I-1]) * (ArrX[I] - ArrX[I-1]) = (ArrY[I] - ArrY[I-1]) * (X - ArrX[I-1]));

        If ArrX[I-1] > ArrX[I] Then
        Begin
            Min := ArrX[I];
            Max := ArrX[I - 1];
        End
        Else
        Begin
            Min := ArrX[I - 1];
            Max := ArrX[I];
        End;

        IsPointBetweenXCoord := (X >= Min) And (X <= Max);

        If ArrY[I-1] > ArrY[I] Then
        Begin
            Min := ArrY[I];
            Max := ArrY[I - 1];
        End
        Else
        Begin
            Min := ArrY[I - 1];
            Max := ArrY[I];
        End;

        IsPointBetweenYCoord := (Y >= Min) And (Y <= Max);

        IsPointOnPolygon := (IsPointOnLine And IsPointBetweenXCoord And IsPointBetweenYCoord);
        Inc(I);
    Until(IsPointOnPolygon) Or (I > N);

    If IsPointOnPolygon Then
        AnswerLabel.Caption := 'Точка находится на одной из сторон многоугольника'
    Else
        AnswerLabel.Caption := 'Точка не находится ни на одной из сторон многоугольника';
end;


/////////////////////////////////////////// SAVE  ///////////////////////////
Procedure SaveAnswer ();
var
    IsFileCorrect: Boolean;
    FileOut: TextFile;
    Path: String;
    I,J: Integer;
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
            Writeln(FileOut, 'Многоугольник задан координатами вершин:');
            for I := 1 to 2 do
            Begin
                 for j := 0 to CoordCount do
                     Write(FileOut, StringGrid.Cells [J, I]: 5);
                 Writeln(FileOut);
            End;
            Writeln(FileOut, 'Координаты точки:' , Edit1.Text:5, Edit2.Text:5);
            Writeln(FileOut, AnswerLabel.Caption);

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
    for I := 1 to StringGrid.colcount do
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

        str := StringGrid.Cells[I, 2];
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
        StringGrid.Cells[I, 2] := str;
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
    CalculateButton.Enabled := True;
    EditButtonEnabled(CalculateButton);

    AnswerLabel.Caption := '';
    SaveAsMenuItem.Enabled := False;
    SaveMenuItem.Enabled := False;
end;

Procedure EditStringGrid;
Var
    I: Integer;
Begin
    ClearStringGrid;
    With MainForm.StringGrid Do
    Begin
        ColCount := CoordCount+1;
        if CoordCount < 9 then
            Width := DefaultColWidth * ColCount + 2 * ColCount - 1 - (ColCount Div 5)
        else
            Width  := 393;

        for I := 1 to CoordCount do
            Cells[I,0] := IntToStr(I);
    End;
End;

//////////////////////////////// EDIT /////////////////////////////////////////
procedure TMainForm.CoordCountEditChange(Sender: TObject);
var
    S, SBuf:String;
    Num, Code, CursPos: Integer;
begin
    with Sender As TEdit do
    Begin
        S := Text;
        CursPos := SelStart;

        Val(S, Num, Code);
        If (Code = 0) And (Num > 0) And (Num < 21) Then
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
    End;

    If CheckCoordEdit(CoordCountEdit) Then
    Begin
        CoordCount := StrToInt(CoordCountEdit.Text);
        MainForm.StringGrid.Enabled := True;
    End
    Else
    Begin
        CoordCount := 3;
        MainForm.StringGrid.Enabled := False;
    End;

        EditStringGrid;
        EditButtonEnabled(CalculateButton);
        If SaveAsMenuItem.Enabled = True then
        Begin
            AnswerLabel.Caption := '';
            SaveAsMenuItem.Enabled := False;
            SaveMenuItem.Enabled := False;
        End;
end;

procedure TMainForm.CoordCountEditKeyPress(Sender: TObject; var Key: Char);
begin
    with Sender As TEdit Do
        case key of
            '0'..'9':;
            kBACKSPACE:;
        Else
            Key := kNULL;
        end;
end;

procedure TMainForm.EditChange(Sender: TObject);
var
    S:String;
    Num, Code, CursPos: Integer;
begin
    with Sender As TEdit do
    Begin
        S := Text;
        CursPos := SelStart;

        if Text <> '-' then
        Begin
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
        End;
        EditButtonEnabled(CalculateButton);
    End;

    if SaveAsMenuItem.Enabled = True then
    Begin
        AnswerLabel.Caption := '';
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
    kENTER, kDOWN:
        SelectNext(ActiveControl, True, True);
    kUP:
        SelectNext(ActiveControl, False, True);
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

    If (IsFileCorrect) And ((Num < 3) Or (Num > 20)) then
    Begin
        MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
        IsFileCorrect := False;
    End;

    ReadNumFromFile := IsFileCorrect;
End;

Function ReadCoordFromFile(Var FileIn: TextFile; Var X: Integer; Var Y: Integer): Boolean;
Var
    IsFileCorrect: Boolean;
    NumStr: String;
    Code, I, Num: Integer;

Begin
    IsFileCorrect := True;
    Readln(FileIn, NumStr);

    I := 2;
    Repeat
        if NumStr[I] = ' ' then
        Begin
            Val(Copy(NumStr, 1, I-1), Num, Code);
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
        End;
        Inc(I);
    Until (NumStr[I-1] = ' ') Or Not IsFileCorrect;

    If IsFileCorrect Then
    Begin
        X := Num;
        Val(Copy(NumStr, I, High(NumStr) - I + 1), Num, Code);
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

        if IsFileCorrect then
            Y := Num;
    End;

    ReadCoordFromFile := IsFileCorrect;
End;

procedure TMainForm.OpenMenuItemClick(Sender: TObject);
var
    FileIn: TextFile;
    Path: String;
    I, X, Y: Integer;
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
            IsFileCorrect := ReadNumFromFile(FileIn, CoordCount);
            if IsFileCorrect then
                CoordCountEdit.Text := IntToStr(CoordCount);

            I := 0;
            while IsFileCorrect And (I < CoordCount) do
            Begin
                IsFileCorrect := ReadCoordFromFile(FileIn, X, Y);
                if IsFileCorrect then
                Begin
                    With StringGrid do
                    Begin
                        Cells[I+1, 1] := IntToStr(X);
                        Cells[I+1, 2] := IntToStr(Y);
                    End;
                End;
                Inc(I);
            End;

            If IsFileCorrect then
            Begin
                IsFileCorrect := ReadCoordFromFile(FileIn, X, Y);
                If IsFileCorrect then
                Begin
                    Edit1.Text := IntToStr(X);
                    Edit2.Text:= IntToStr(Y);
                End;
            End;

            If (IsFileCorrect) And Not EoF(FileIn) then
            Begin
                IsFileCorrect := False;
                MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
            End;

            if Not IsFileCorrect then
                ResetStringGrid;

            CloseFile(FileIn);
        End;
    End;
end;
end.
