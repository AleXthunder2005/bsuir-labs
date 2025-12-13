unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.Grids;

type
    THardwareRecord = Record
        HardwareName: String[17];
        CompanyName: String[17];
        Description: String[40];
        Warranty: Word;
        Price: Real;
    end;
  TMainForm = class(TForm)
    TitelLabel: TLabel;
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    ManualMenuItem: TMenuItem;
    AboutDeveloperMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    StringGrid: TStringGrid;
    AddRecordButton: TButton;
    BackButton: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    InfoButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure AddRecordButtonClick(Sender: TObject);
    procedure StringGridClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure InfoButtonClick(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
    procedure FileMenuItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
    DelColomn = 5;
    EditColomn = 6;
    clGrayCarbon = TColor($232323);
    kRIGHT = 39;

var
  MainForm: TMainForm;
  IsStringGridNotEmpty, IsSomeChanges: Boolean;
  RecordsFile, CorrectedRecordsFile, SaveFile: File Of THardwareRecord;
  DefaultCorrectedRecordsFilePath : String;

implementation

uses
    AddRecordUnit, EditRecordUnit, InformationUnit, ManualUnit;
{$R *.dfm}

Procedure ResetRectFocus;
Var
    NewFocusRect: TGridRect;
Begin
    NewFocusRect.Left := 0;
    NewFocusRect.Top  := 1;
    NewFocusRect.Right := 0;
    NewFocusRect.Bottom := 1;
    MainForm.StringGrid.Selection := NewFocusRect;
End;

Procedure DeleteRecordFromGrid (Row: Integer);
Var
    I: Integer;
Begin
    With MainForm.StringGrid Do
    Begin
        if RowCount = 2 then
        Begin
           Cells[0, 1] := '';
           Cells[1, 1] := '';
           Cells[2, 1] := '';
           Cells[3, 1] := '';
           Cells[4, 1] := '';
           Cells[DelColomn, 1] := '';
           Cells[EditColomn, 1] := '';
           IsStringGridNotEmpty := False;
        End
        Else
        Begin
            For I := Row + 1 To RowCount - 1 Do
            Begin
                Cells[0, I-1] := Cells[0, I];
                Cells[1, I-1] := Cells[1, I];
                Cells[2, I-1] := Cells[2, I];
                Cells[3, I-1] := Cells[3, I];
                Cells[4, I-1] := Cells[4, I];
            End;
            RowCount := RowCount - 1;
        End;
    End;
    IsSomeChanges := True;
End;

procedure DeleteRecordFromCorrectedFile(RecordsNum: Integer);
var
    I, RecordsCount: Integer;
    TempRecord: THardwareRecord;
begin
    RecordsCount := FileSize(CorrectedRecordsFile);

    for I := RecordsNum to RecordsCount-1 do
    begin
        Seek(CorrectedRecordsFile, I);
        Read(CorrectedRecordsFile, TempRecord);
        Seek(CorrectedRecordsFile, I-1);
        Write(CorrectedRecordsFile,TempRecord);
    end;

    Seek(CorrectedRecordsFile, RecordsCount-1);
    Truncate(CorrectedRecordsFile);
end;

Procedure EditRecord(Row: Integer);
Begin
    CurrRow := Row;
    EditRecordForm.ShowModal;
End;

procedure TMainForm.StringGridClick(Sender: TObject);
var
    SelectedRectCol, SelectedRectRow: Integer;

begin
    SelectedRectCol := StringGrid.Selection.Right;
    SelectedRectRow := StringGrid.Selection.Bottom;

    if (IsStringGridNotEmpty) then
        case SelectedRectCol of
            DelColomn:
            Begin
                If MessageBox(Handle, 'Вы действительно хотите удалить выбранную запись?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES Then
                Begin
                    DeleteRecordFromGrid(SelectedRectRow);
                    DeleteRecordFromCorrectedFile(SelectedRectRow);
                End;
                ResetRectFocus;
            End;
            EditColomn:
            Begin
                EditRecord(SelectedRectRow);
                ResetRectFocus;
            End;
        end;
end;
procedure TMainForm.AboutDeveloperMenuItemClick(Sender: TObject);
begin
   MessageBox(Handle, 'Разработчик: Наривончик Александр Михайлович, гр. 351004', 'О разработчике', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.AddRecordButtonClick(Sender: TObject);
begin
    AddRecordForm.ShowModal;
end;

procedure TMainForm.BackButtonClick(Sender: TObject);
begin
    MainForm.Close;
end;

Procedure AddRecordToGrid(NewHardwareRecord: THardwareRecord);
Begin
    With MainForm.StringGrid, NewHardwareRecord Do
    Begin
        if IsStringGridNotEmpty then
            RowCount := RowCount + 1
        else
            IsStringGridNotEmpty := True;

        Cells[0, RowCount-1] := HardwareName;
        Cells[1, RowCount-1] := CompanyName;
        Cells[2, RowCount-1] := Description;
        Cells[3, RowCount-1] := IntToStr(Warranty) + ' мес';
        Cells[4, RowCount-1] := FloatToStr(Price);
        Cells[DelColomn, RowCount-1] := '  X';
        Cells[EditColomn, RowCount-1] := ' ...';
    End;
End;

Function CheckSaveFile: Boolean;
var
    CanBeSaved, IsFileCorrect: Boolean;
    Path: String;
begin
    if MainForm.SaveDialog.Execute then
    begin
        IsFileCorrect := True;

        Path := MainForm.SaveDialog.FileName;
        AssignFile(SaveFile, Path);

        try
            Rewrite(SaveFile);
        except
            IsFileCorrect := False;
            MessageBox(MainForm.Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
        end;

        if IsFileCorrect then
            CloseFile(SaveFile);

        CanBeSaved := IsFileCorrect;
    end
    else
        CanBeSaved := False;

    CheckSaveFile := CanBeSaved;
end;

procedure SaveDataFile;
var
    RecordsCount, I: Integer;
    TempRecord: THardwareRecord;
begin
    Rewrite(SaveFile);
    RecordsCount := FileSize(CorrectedRecordsFile);
    I := 0;
    Seek(CorrectedRecordsFile, 0);

    while I < RecordsCount do
    begin
        Read(CorrectedRecordsFile, TempRecord);
        Write(SaveFile, TempRecord);
        Inc(I);
    end;
    CloseFile(SaveFile);
    IsSomeChanges := False;
end;

procedure TMainForm.SaveMenuItemClick(Sender: TObject);
begin
    If CheckSaveFile then
        SaveDataFile;
end;

procedure ClearStringGrid;
var
    I: Integer;
begin
    for I := MainForm.StringGrid.RowCount-1 DownTo 1  do
        DeleteRecordFromGrid(I);
    IsStringGridNotEmpty := False;
end;

procedure TMainForm.FileMenuItemClick(Sender: TObject);
begin
    if IsStringGridNotEmpty then
        SaveMenuItem.Enabled := True
    else
        SaveMenuItem.Enabled := False;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    CloseFile(CorrectedRecordsFile);
    Erase(CorrectedRecordsFile);
    ClearStringGrid;
end;

procedure FillCorrectedRecordsFile;
var
    TempRecord: THardwareRecord;
    RecordsCount, I: Integer;
begin
    Reset(RecordsFile);
    RecordsCount := FileSize(RecordsFile);
    I := 0;
    while I < RecordsCount do
    begin
        Read(RecordsFile, TempRecord);
        Write(CorrectedRecordsFile, TempRecord);
        Inc(I);
    end;

    CloseFile(RecordsFile);
end;

procedure DownloadRecordsFromFile;
var
    I, RecordsCount: Integer;
    NewRecord: THardwareRecord;
begin
    Reset(RecordsFile);
    RecordsCount := FileSize(RecordsFile);

    if RecordsCount = 0 then
        IsStringGridNotEmpty := False
    else
    begin
        I := 0;
        while I < RecordsCount do
        begin
            Read(RecordsFile, NewRecord);
            AddRecordToGrid(NewRecord);
            Inc(I);
        end;
    end;
    CloseFile(RecordsFile);
end;

function CheckRecord (TempRecord: THardwareRecord): Boolean;
var
    IsRecordIncorrect: Boolean;
begin
    with TempRecord do
    begin
        IsRecordIncorrect := (Price < 0) Or (Price > 999999999) Or (Warranty < 0) or (Warranty > 999) or (Length(Description) > 40) or (Length(HardwareName) > 17) or (Length(CompanyName) > 17);
    end;
    CheckRecord := Not IsRecordIncorrect;
end;

function CheckFileIn(Path: String): Boolean;
var
    IsFileCorrect: Boolean;
    I: Integer;
    TempRecord: THardwareRecord;
begin
    IsFileCorrect := True;
    AssignFile(RecordsFile, Path);
    try
        Reset(RecordsFile);
    except
        IsFileCorrect := False;
        MessageBox(MainForm.Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
    end;

    if IsFileCorrect then
    begin
        I := 0;
        while IsFileCorrect and (I < FileSize(RecordsFile)) do
        begin
            try
                Read(RecordsFile, TempRecord);
            except
                IsFileCorrect := False;
            end;
            if IsFileCorrect then
                IsFileCorrect := CheckRecord(TempRecord);
            Inc(I);
        end;
        CloseFile(RecordsFile);
    end;
    
    if not IsFileCorrect then
        MessageBox(MainForm.Handle, 'Файл поврежден!', 'Ошибка', MB_OK Or MB_ICONERROR); 

    CheckFileIn := IsFileCorrect;
end;

procedure ResetProgram;
begin
    ClearStringGrid;
    CloseFile(CorrectedRecordsFile);
    Rewrite(CorrectedRecordsFile);
end;

procedure TMainForm.OpenMenuItemClick(Sender: TObject);
var
    Path: String;
    IsFileCorrect: Boolean;
begin
    if OpenDialog.Execute then
    begin
        Path := OpenDialog.FileName;

        IsFileCorrect := CheckFileIn(Path);
        if IsFileCorrect then
        begin
            ResetProgram;
            DownloadRecordsFromFile;
            FillCorrectedRecordsFile;
            IsSomeChanges := False;
        end;
    end;
end;

procedure CreateEmptyCorrectedRecordsFile;
begin
    AssignFile (CorrectedRecordsFile, DefaultCorrectedRecordsFilePath);
    Rewrite(CorrectedRecordsFile);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
    CreateEmptyCorrectedRecordsFile;
    IsStringGridNotEmpty := False;
    IsSomeChanges := False;
end;

procedure TMainForm.InfoButtonClick(Sender: TObject);
begin
    InformationForm.ShowModal;
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    ManualForm.ShowModal;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if IsStringGridNotEmpty And IsSomeChanges then
        if MessageBox(Handle, 'Вы хотите сохранить файл данных?', 'Cохранить?', MB_YESNO Or MB_ICONQUESTION) = IDYES Then
        begin
            CanClose := CheckSaveFile;
            If CanClose then
                SaveDataFile;
        end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    With StringGrid Do
    Begin
        ColWidths[0] := 120;
        ColWidths[1] := 120;
        ColWidths[2] := 240;
        ColWidths[3] := 70;
        ColWidths[4] := 70;
        Cells[0,0] := 'Название устройства';
        Cells[1,0] := 'Фирма изготовитель';
        Cells[2,0] := 'Главная техническая характеристика';
        Cells[3,0] := 'Гарантия';
        Cells[4,0] := 'Цена (BYN)';

        DefaultCorrectedRecordsFilePath := GetCurrentDir + '\CorrectedFile.hdb';
    End;
end;

procedure TMainForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
    if IsStringGridNotEmpty And (Arow > 0) then
        case Acol of
            DelColomn:
                With StringGrid Do
                Begin
                    Canvas.Brush.Color := clGrayCarbon;
                    Canvas.FillRect(CellRect(Acol, Arow));
                    Canvas.TextOut(Rect.Left, Rect.Top, Cells[ACol, ARow]);
                End;
            EditColomn:
                With StringGrid Do
                Begin
                    Canvas.Brush.Color := clGrayCarbon;
                    Canvas.FillRect(CellRect(Acol, Arow));
                    Canvas.TextOut(Rect.Left, Rect.Top, Cells[ACol, ARow]);
                End;
        end;
end;

procedure TMainForm.StringGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    SelectedRectCol: Integer;
begin
    SelectedRectCol := StringGrid.Selection.Right;
    If (Key = kRIGHT) And (SelectedRectCol = DelColomn-1) Then
        Key := 0;
end;

end.
