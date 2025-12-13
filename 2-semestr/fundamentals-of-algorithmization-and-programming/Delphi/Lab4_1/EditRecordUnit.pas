unit EditRecordUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Clipbrd;

type
  TEditRecordForm = class(TForm)
    HardwareNameLabel: TLabel;
    TitleLabel: TLabel;
    CompanyNameLabel: TLabel;
    DescriptionLabel: TLabel;
    WarrantyLabel: TLabel;
    PriceLabel: TLabel;
    HardwareNameEdit: TEdit;
    CompanyNameEdit: TEdit;
    DescriptionEdit: TEdit;
    WarrantyEdit: TEdit;
    EditButton: TButton;
    CancelButton: TButton;
    PriceEdit: TEdit;
    CopyPastePopupMenu: TPopupMenu;
    CopyButton: TMenuItem;
    PasteButton: TMenuItem;
    CutButton: TMenuItem;
    procedure CancelButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure StrEditChange(Sender: TObject);
    procedure WarrantyEditChange(Sender: TObject);
    procedure PriceEditChange(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditDblClick(Sender: TObject);
    procedure WarrantyEditKeyPress(Sender: TObject; var Key: Char);
    procedure PriceEditKeyPress(Sender: TObject; var Key: Char);
    procedure StrEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditRecordForm: TEditRecordForm;
  CurrRow: Integer;

const
    kBACKSPACE = #8;
    kMINUS = #45;
    kCOMMA = #44;
    kDOWN = 40;
    kUP = 38;
    kENTER = 13;
    kINSERT = 45;


implementation

uses
    MainUnit;

{$R *.dfm}

procedure TEditRecordForm.CancelButtonClick(Sender: TObject);
begin
    EditRecordForm.Close;
end;

Function CreateNewRecord: THardwareRecord;
Var
    NewHardwareRecord: THardwareRecord;
Begin
    With NewHardwareRecord, EditRecordForm Do
    Begin
        HardwareName := HardwareNameEdit.Text;
        CompanyName := CompanyNameEdit.Text;
        Description := DescriptionEdit.Text;
        Warranty := StrToInt(WarrantyEdit.Text);
        Price := Int(StrToFloat(PriceEdit.Text) * 100) / 100;
    End;
    CreateNewRecord := NewHardwareRecord;
End;

procedure TEditRecordForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    IValue: Integer;
    FlValue: Single;
    Buffer: String;
begin
    Buffer := Clipboard.AsText;
    PasteButton.Enabled := True;

    if ActiveControl.Name = 'WarrantyEdit' then
        PasteButton.Enabled := TryStrToInt(Buffer, IValue)
    else
        if ActiveControl.Name = 'PriceEdit' then
            PasteButton.Enabled := TryStrToFloat(Buffer, FlValue);
end;

Procedure ReplaceRecordInGrid(NewHardwareRecord: THardwareRecord);
Begin
    With MainForm.StringGrid, NewHardwareRecord Do
    Begin
        Cells[0, CurrRow] := HardwareName;
        Cells[1, CurrRow] := CompanyName;
        Cells[2, CurrRow] := Description;
        Cells[3, CurrRow] := IntToStr(Warranty) + ' мес';
        Cells[4, CurrRow] := FloatToStr(Price);
    End;

    IsSomeChanges := True;
End;

procedure ReplaceRecordInCorrectedFile(NewHardwareRecord: THardwareRecord);
var
    RecordsNum: Integer;
begin
    RecordsNum := CurrRow-1;
    Seek(CorrectedRecordsFile, RecordsNum);
    Write(CorrectedRecordsFile, NewHardwareRecord);
    Seek(CorrectedRecordsFile, FileSize(CorrectedRecordsFile));
end;


procedure TEditRecordForm.EditButtonClick(Sender: TObject);
Var
    NewHardwareRecord: THardwareRecord;
begin
    NewHardwareRecord := CreateNewRecord();
    ReplaceRecordInGrid(NewHardwareRecord);
    ReplaceRecordInCorrectedFile(NewHardwareRecord);
    EditRecordForm.Close;
end;

procedure TEditRecordForm.PasteButtonClick(Sender: TObject);
var
    CursPos: Byte;
    TempStr: String;
    ActiveEdit: TEdit;
    IValue: Integer;
    FlValue: Single;
begin
    ActiveEdit := TEdit(ActiveControl);
    with ActiveEdit do
    begin
        CursPos := SelStart;
        TempStr := Text;

        PasteFromClipboard;

        if ActiveControl.Name = 'WarrantyEdit' then
        begin
            if not TryStrToInt(Text, IValue) or (IValue < 0) then
            begin
                Text := TempStr;
                SelStart := CursPos;
            end;
        end
        else
            if ActiveControl.Name = 'PriceEdit' then
            begin
                if not TryStrToFloat(Text, FlValue) or (FlValue < 0) then
                begin
                    Text := TempStr;
                    SelStart := CursPos;
                end
            end;
    End;
end;

procedure TEditRecordForm.CopyButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CopyToClipboard;
end;

procedure TEditRecordForm.CutButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CutToClipboard;
end;

Function CheckPriceEdit():Boolean;
var
    IsEditCorrect: Boolean;
    FlValue: Single;
Begin
    with EditRecordForm.PriceEdit do
    begin
        IsEditCorrect := (Text <> '') And (TryStrToFloat(Text, FlValue) And (Text[1] <> ',') And (Text[High(Text)] <> ','));
    end;
    CheckPriceEdit := IsEditCorrect;
End;

Procedure EditEditButtonEnabled;
var
    IsRecordCorrect: Boolean;
Begin
    with EditRecordForm do
    begin
        IsRecordCorrect := (HardwareNameEdit.Text <> '') And (CompanyNameEdit.Text <> '') And (DescriptionEdit.Text <> '') And (WarrantyEdit.Text <> '') And CheckPriceEdit;
        EditRecordForm.EditButton.Enabled := IsRecordCorrect;
    end;
End;

procedure TEditRecordForm.StrEditChange(Sender: TObject);
begin
    EditEditButtonEnabled;
end;

procedure TEditRecordForm.WarrantyEditChange(Sender: TObject);
var
    CursPos: Byte;
    TempStr: String;
    IValue: Integer;
begin
    with WarrantyEdit do
    begin
        CursPos := SelStart;
        TempStr := Text;

        if not TryStrToInt(TempStr, IValue) or (IValue < 0) then
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

    EditEditButtonEnabled;
end;

procedure TEditRecordForm.PriceEditChange(Sender: TObject);
var
    TempStr: String;
    CursPos: Byte;
begin
    with PriceEdit do
    begin
        TempStr := Text;
        CursPos := SelStart;

        if (length(TempStr)>1) And (TempStr[1] = '0') And (TempStr[2] = '0') then
        begin
            Delete(TempStr, 2, 1);
            Text := TempStr;
            SelStart := CursPos-1;
        end;
    end;

    EditEditButtonEnabled;
end;

procedure TEditRecordForm.EditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Begin
    case key of
        kENTER, kDOWN:
        begin
            SelectNext(ActiveControl, True, True);
            with TEdit(ActiveControl) do
                SelStart := Length(Text);
        end;
        kUP:
        begin
            SelectNext(ActiveControl, False, True);
            with TEdit(ActiveControl) do
                SelStart := Length(Text);
        end;
        kINSERT:
            Key := 0;
    end;
End;

procedure TEditRecordForm.FormShow(Sender: TObject);
var
    WarrantyStr: String;
    Row: Integer;
begin
    Row := CurrRow;

    HardwareNameEdit.Text := MainForm.StringGrid.Cells[0, Row];
    CompanyNameEdit.Text := MainForm.StringGrid.Cells[1, Row];
    DescriptionEdit.Text := MainForm.StringGrid.Cells[2, Row];

    WarrantyStr := MainForm.StringGrid.Cells[3, Row];
    WarrantyEdit.Text := Copy(WarrantyStr, 1, Length(WarrantyStr) - 4);

    PriceEdit.Text := MainForm.StringGrid.Cells[4, Row];

    ActiveControl := CancelButton;
end;

procedure TEditRecordForm.EditDblClick(Sender: TObject);
begin
    TEdit(Sender).Text := '';
end;

procedure TEditRecordForm.StrEditKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = #13 then
        Key := #0;
end;

procedure TEditRecordForm.WarrantyEditKeyPress(Sender: TObject; var Key: Char);
begin
    if Not (Key in ['0'..'9', kBACKSPACE]) then
        Key := #0;
end;

procedure TEditRecordForm.PriceEditKeyPress(Sender: TObject; var Key: Char);
begin
    if Not (Key in ['0'..'9', kBACKSPACE, kCOMMA]) then
        Key := #0;
end;
end.
