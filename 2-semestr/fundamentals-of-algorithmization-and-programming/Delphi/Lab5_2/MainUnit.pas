unit MainUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, Clipbrd,
  Vcl.ExtDlgs;

type
  TMainForm = class(TForm)
    ValueEdit: TEdit;
    AddButton: TButton;
    ProcessingButton: TButton;
    DeleteButton: TButton;
    ExitButton: TButton;
    TreeImage: TImage;
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    ManualMenuItem: TMenuItem;
    AboutDeveloperMenuItem: TMenuItem;
    OpenDialog: TOpenDialog;
    CopyPastePopupMenu: TPopupMenu;
    CopyButton: TMenuItem;
    PasteButton: TMenuItem;
    CutButton: TMenuItem;
    ConditionLabel: TLabel;
    ScrollBox: TScrollBox;
    AnswerLabel: TLabel;
    SavePictureDialog: TSavePictureDialog;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExitButtonClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure ValueEditChange(Sender: TObject);
    procedure ValueEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ValueEditDblClick(Sender: TObject);
    procedure ValueEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ProcessingButtonClick(Sender: TObject);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
    BinaryTreeUnit;

const
    kBACKSPACE = #8;
    kINSERT = 45;
    MIN_VALUE = 1;
    MAX_VALUE = 9999;
    RADIUS = 20;
    DELTA_X = 30;
    DELTA_Y = 35;
    DEFAULT_HEIGHT = 550;
    DEFAULT_WIDTH = 700  ;

var
    TreeStart: TPointer;
    MinTreeCoord, MaxTreeCoord: Integer;

{$R *.dfm}

procedure TMainForm.AboutDeveloperMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, 'Разработчик: Наривончик Александр Михайлович, гр. 351004', 'О разработчике', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.CopyButtonClick(Sender: TObject);
begin
    ValueEdit.CopyToClipboard;
end;

procedure TMainForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    IValue: Integer;
    Buffer: String;
    IsCorrect: Boolean;
begin
    Buffer := Clipboard.AsText;
    IsCorrect := TryStrToInt(Buffer, IValue);
    PasteButton.Enabled := IsCorrect;
end;

procedure TMainForm.CutButtonClick(Sender: TObject);
begin
    ValueEdit.CutToClipboard;
end;

procedure TMainForm.PasteButtonClick(Sender: TObject);
begin
    ValueEdit.PasteFromClipboard;
end;

procedure EditButtonEnabled();
begin
    with MainForm do
    begin
        AddButton.Enabled := ValueEdit.Text <> '';
        DeleteButton.Enabled := ValueEdit.Text <> '';
    end;
end;

procedure TMainForm.ValueEditChange(Sender: TObject);
var
    CursPos: Byte;
    TempStr: String;
    IValue: Integer;
begin
    with ValueEdit do
    begin
        if Text = '0' then
            Text := ''
        else
            if (Length(Text) > 0) then
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
    EditButtonEnabled;
    AnswerLabel.Caption := ''
end;

procedure TMainForm.ValueEditDblClick(Sender: TObject);
begin
    ValueEdit.Text := '';
end;

procedure TMainForm.ValueEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = kINSERT then
        Key := 0;
end;

procedure TMainForm.ValueEditKeyPress(Sender: TObject; var Key: Char);
begin
    if Not (Key in ['0'..'9', kBACKSPACE]) then
        Key := #0;
end;

procedure TMainForm.ExitButtonClick(Sender: TObject);
begin
    MainForm.Close;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    TreeStart := CreateEmptyTree;
    TreeImage.Width := DEFAULT_WIDTH;
    TreeImage.Height := DEFAULT_HEIGHT;
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, '1. Введите значение (от 1 до 9999) нового узла в поле и нажмите кнопку "Добавить". Постройте таким образом бинарное дерево' + #13#10 + '2. Чтобы удалить узел, введите его значение в поле и нажмите удалить.' + #13#10 + '3. Нажмите кнопку "Обработать" и получите результат!'+ #13#10 + '4. В случае ввода из файла убедитесь, что файл содержит значение каждого узла в новой строке.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

procedure DrawTree(TreeRoot: TPointer; X, Y: Integer);
var
    Coef: Integer;
begin
    with MainForm.TreeImage do
    begin
        Canvas.Ellipse(X-RADIUS, Y-RADIUS, X+RADIUS, Y+RADIUS);
        Canvas.TextOut(X-7, Y-7, IntToStr(TreeRoot^.Value));

        if (TreeRoot^.NextLeft <> nil) and (TreeRoot^.NextRight = nil) then
        begin
            DrawTree(TreeRoot^.NextLeft, X - DELTA_X, Y+DELTA_Y);
            Canvas.MoveTo(X - RADIUS, Y);
            Canvas.LineTo(X - DELTA_X, Y+DELTA_Y-RADIUS);
        end
        else if (TreeRoot^.NextRight <> nil) and (TreeRoot^.NextLeft = nil) then
        begin
            DrawTree(TreeRoot^.NextRight, X + DELTA_X, Y+DELTA_Y);
            Canvas.MoveTo(X + RADIUS, Y);
            Canvas.LineTo(X + DELTA_X, Y+DELTA_Y-RADIUS);
        end
        else if (TreeRoot^.NextRight <> nil) and (TreeRoot^.NextLeft <> nil) then
        begin
            Coef := CalculateTreeCoef(TreeRoot^.NextLeft);
            DrawTree(TreeRoot^.NextLeft, X - Coef * DELTA_X, Y+DELTA_Y);
            Canvas.MoveTo(X-RADIUS, Y);
            Canvas.LineTo(X - Coef * DELTA_X, Y+DELTA_Y-RADIUS);

            Coef := CalculateTreeCoef(TreeRoot^.NextRight);
            DrawTree(TreeRoot^.NextRight, X + Coef * DELTA_X, Y+DELTA_Y);
            Canvas.MoveTo(X+RADIUS, Y);
            Canvas.LineTo(X + Coef * DELTA_X, Y+DELTA_Y-RADIUS);
        end;
    end;
end;

procedure CalculateWidth(TreeRoot: TPointer; X, Y: Integer);
var
    Coef: Integer;
begin
    if TreeRoot <> nil then
    begin
        if (TreeRoot^.NextLeft <> nil) and (TreeRoot^.NextRight = nil) then
        begin
            CalculateWidth(TreeRoot^.NextLeft, X - DELTA_X, Y+DELTA_Y);
        end
        else if (TreeRoot^.NextRight <> nil) and (TreeRoot^.NextLeft = nil) then
        begin
            CalculateWidth(TreeRoot^.NextRight, X + DELTA_X, Y+DELTA_Y);
        end
        else if (TreeRoot^.NextRight <> nil) and (TreeRoot^.NextLeft <> nil) then
        begin
            Coef := CalculateTreeCoef(TreeRoot^.NextLeft);
            CalculateWidth(TreeRoot^.NextLeft, X - Coef * DELTA_X, Y+DELTA_Y);

            Coef := CalculateTreeCoef(TreeRoot^.NextRight);
            CalculateWidth(TreeRoot^.NextRight, X + Coef * DELTA_X, Y+DELTA_Y);
        end;
        if X < MinTreeCoord then
            MinTreeCoord := X;

        if X > MaxTreeCoord then
            MaxTreeCoord := X;
    end;
end;

function CalculateHeight(TreeRoot: TPointer): Integer;
begin
    CalculateHeight := FindMaxDepth(TreeRoot) * DELTA_Y + RADIUS + 70;
end;

procedure EditImageSize(TreeStart: TPointer);
var
    CurrWidth, CurrHeight: Integer;
begin
    MinTreeCoord := 0;
    MaxTreeCoord := 0;
    CalculateWidth(TreeStart, 0, 0);

    CurrHeight := CalculateHeight(TreeStart);
    CurrWidth := -MinTreeCoord + MaxTreeCoord + 2 * RADIUS + 100;

    with MainForm.TreeImage do
    begin
        if CurrWidth > DEFAULT_WIDTH then
            Width := CurrWidth
        else
            Width := DEFAULT_WIDTH;

        if CurrHeight > DEFAULT_HEIGHT then
            Height := CurrHeight
        else
            Height := DEFAULT_HEIGHT;
    end;
end;

procedure TMainForm.AddButtonClick(Sender: TObject);
begin
    AddElemToTree(StrToInt(ValueEdit.Text), TreeStart);
    TreeImage.Picture := nil;
    ValueEdit.Text := '';
    EditImageSize(TreeStart);
    if TreeStart <> nil then
        DrawTree(TreeStart, -MinTreeCoord + RADIUS + 50, 70);
end;

procedure TMainForm.DeleteButtonClick(Sender: TObject);
begin
    if TreeStart <> nil then
    begin
        DeleteElemInTree(StrToInt(ValueEdit.Text), TreeStart);
        ValueEdit.Text := '';
        TreeImage.Picture := nil;
        EditImageSize(TreeStart);
        if TreeStart <> nil then
            DrawTree(TreeStart, -MinTreeCoord + RADIUS + 50, 70);
    end;
end;

procedure TMainForm.ProcessingButtonClick(Sender: TObject);
begin
    if TreeStart <> nil then
    begin
        AnswerLabel.Caption := 'Длина наименьшего пути:' + IntToStr(FindMinDepth(TreeStart)-1);
        EditTree(TreeStart);
        TreeImage.Picture := nil;
        EditImageSize(TreeStart);
        if TreeStart <> nil then
            DrawTree(TreeStart, -MinTreeCoord + RADIUS + 50, 70);
    end;
end;

procedure TMainForm.SaveMenuItemClick(Sender: TObject);
begin
    if SavePictureDialog.Execute then
        try
            TreeImage.Picture.SaveToFile(SavePictureDialog.FileName);
        except
            MessageBox(MainForm.Handle, 'Не удалось сохранить файл!', 'Ошибка', MB_OK or MB_ICONERROR);
        end;
end;

function ReadNumFromFile(var FileIn: TextFile; var Num: Integer): Boolean;
var
    IsFileCorrect: Boolean;
    NumStr: String;
    Code: Integer;

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

    if (IsFileCorrect) and ((Num < MIN_VALUE) or (Num > MAX_VALUE)) then
    begin
        MessageBox(MainForm.Handle, 'Неверный формат данных в файле!', 'Ошибка', MB_OK or MB_ICONERROR);
        IsFileCorrect := False;
    end;

    ReadNumFromFile := IsFileCorrect;
End;

function CheckFile(var FileIn: TextFile): Boolean;
var
    IsFileCorrect: Boolean;
    TempNum: Integer;
begin
    IsFileCorrect := True;

    try
        Reset(FileIn);
    except
        IsFileCorrect := False;
        MessageBox(MainForm.Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
    end;

    if IsFileCorrect then
    begin
        repeat
            IsFileCorrect := ReadNumFromFile(FileIn, TempNum);
        until not IsFileCorrect or EoF(FileIn);

        CloseFile(FileIn);
    end;

    CheckFile := IsFileCorrect;
end;

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

        if CheckFile(FileIn) then
        begin
            ClearTree(TreeStart);
            TreeStart := CreateEmptyTree();

            Reset(FileIn);
            repeat
                Readln(FileIn, TempNum);
                AddElemToTree(TempNum, TreeStart);
            until EoF(FileIn);
            CloseFile(FileIn);

            AnswerLabel.Caption := '';
            ValueEdit.Text := '';
            TreeImage.Picture := nil;
            EditImageSize(TreeStart);
            if TreeStart <> nil then
                DrawTree(TreeStart, -MinTreeCoord + RADIUS + 50, 70);
        end;
    end;
end;
end.
