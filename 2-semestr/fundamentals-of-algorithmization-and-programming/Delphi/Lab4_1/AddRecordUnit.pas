unit AddRecordUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.Menus, Clipbrd;

type
  TAddRecordForm = class(TForm)
    HardwareNameEdit: TEdit;
    CompanyNameEdit: TEdit;
    DescriptionEdit: TEdit;
    WarrantyEdit: TEdit;
    HardwareNameLabel: TLabel;
    TitleLabel: TLabel;
    CompanyNameLabel: TLabel;
    DescriptionLabel: TLabel;
    WarrantyLabel: TLabel;
    PriceLabel: TLabel;
    AddButton: TButton;
    CancelButton: TButton;
    PriceEdit: TEdit;
    CopyPastePopupMenu: TPopupMenu;
    CopyButton: TMenuItem;
    PasteButton: TMenuItem;
    CutButton: TMenuItem;
    procedure CancelButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure StrEditChange(Sender: TObject);
    procedure WarrantyEditChange(Sender: TObject);
    procedure PriceEditChange(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WarrantyEditKeyPress(Sender: TObject; var Key: Char);
    procedure PriceEditKeyPress(Sender: TObject; var Key: Char);
    procedure EditDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StrEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddRecordForm: TAddRecordForm;

const
    kBACKSPACE = #8;
    kMINUS = #45;
    kCOMMA = #44;
    kDOWN = 40;
    kUP = 38;
    kENTER = 13;
    kINSERT = 45;

implementation
uses MainUnit;
    {$R *.dfm}

procedure ClearAddRecordForm;
begin
    With AddRecordForm Do
    Begin
        HardwareNameEdit.Text := '';
        CompanyNameEdit.Text := '';
        DescriptionEdit.Text := '';
        WarrantyEdit.Text := '';
        PriceEdit.Text := '';
    End;
end;

Function CreateNewRecord: THardwareRecord;
Var
    NewHardwareRecord: THardwareRecord;
Begin
    With NewHardwareRecord, AddRecordForm Do
    Begin
        HardwareName := HardwareNameEdit.Text;
        CompanyName := CompanyNameEdit.Text;
        Description := DescriptionEdit.Text;
        Warranty := StrToInt(WarrantyEdit.Text);
        Price := Int(StrToFloat(PriceEdit.Text) * 100) / 100;
    End;
    CreateNewRecord := NewHardwareRecord;
End;

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
    IsSomeChanges := True;
End;

procedure AddRecordToCorrectedRecordsFile(NewHardwareRecord: THardwareRecord);
begin
    Seek(CorrectedRecordsFile, FileSize(CorrectedRecordsFile));
    Write(CorrectedRecordsFile, NewHardwareRecord);
end;

procedure TAddRecordForm.AddButtonClick(Sender: TObject);
Var
    NewHardwareRecord: THardwareRecord;
begin
    NewHardwareRecord := CreateNewRecord();
    AddRecordToGrid(NewHardwareRecord);
    AddRecordToCorrectedRecordsFile(NewHardwareRecord);
    AddRecordForm.Close;
end;

procedure TAddRecordForm.CancelButtonClick(Sender: TObject);
begin
    AddRecordForm.Close;
end;

procedure TAddRecordForm.CopyButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CopyToClipboard;
end;

procedure TAddRecordForm.CopyPastePopupMenuPopup(Sender: TObject);
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

procedure TAddRecordForm.CutButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CutToClipboard;
end;

Function CheckPriceEdit():Boolean;
var
    IsEditCorrect: Boolean;
    FlValue: Single;
Begin
    with AddRecordForm.PriceEdit do
    begin
        IsEditCorrect := (Text <> '') And (TryStrToFloat(Text, FlValue) And (Text[1] <> ',') And (Text[High(Text)] <> ','));
    end;
    CheckPriceEdit := IsEditCorrect;
End;

Procedure EditAddButtonEnabled;
var
    IsRecordCorrect: Boolean;
Begin
    with AddRecordForm do
    begin
        IsRecordCorrect := (HardwareNameEdit.Text <> '') And (CompanyNameEdit.Text <> '') And (DescriptionEdit.Text <> '') And (WarrantyEdit.Text <> '') And CheckPriceEdit;
        AddRecordForm.AddButton.Enabled := IsRecordCorrect;
    end;
End;

procedure TAddRecordForm.StrEditChange(Sender: TObject);
begin
    EditAddButtonEnabled;
end;

procedure TAddRecordForm.WarrantyEditChange(Sender: TObject);
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

    EditAddButtonEnabled;
end;

procedure TAddRecordForm.PriceEditChange(Sender: TObject);
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

    EditAddButtonEnabled;
end;

procedure TAddRecordForm.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TAddRecordForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    ClearAddRecordForm;
    ActiveControl := HardwareNameEdit;
end;

procedure TAddRecordForm.StrEditKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = #13 then
        Key := #0;
end;

procedure TAddRecordForm.EditDblClick(Sender: TObject);
begin
    TEdit(Sender).Text := '';
end;

procedure TAddRecordForm.WarrantyEditKeyPress(Sender: TObject; var Key: Char);
begin
    if Not (Key in ['0'..'9', kBACKSPACE]) then
        Key := #0;
end;

procedure TAddRecordForm.PriceEditKeyPress(Sender: TObject; var Key: Char);
begin
    if Not (Key in ['0'..'9', kBACKSPACE, kCOMMA]) then
        Key := #0;
end;

procedure TAddRecordForm.PasteButtonClick(Sender: TObject);
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

end.
