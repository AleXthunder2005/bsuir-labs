unit InformationUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TInformationForm = class(TForm)
    StringGrid: TStringGrid;
    TitleLabel: TLabel;
    BackButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InformationForm: TInformationForm;

implementation

uses MainUnit;
{$R *.dfm}

type
    TArrOfRecord = Array Of THardwareRecord;

procedure TInformationForm.BackButtonClick(Sender: TObject);
begin
    InformationForm.Close;
end;

procedure TInformationForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
    I: Integer;
begin
    with StringGrid do
    begin
        for I := 1 to RowCount-1 do
        begin
            Cells[0,I] := '';
            Cells[1,I] := '';
        end;
    end;
end;

procedure TInformationForm.FormCreate(Sender: TObject);
begin
    With StringGrid Do
    Begin
        ColWidths[0] := 210;
        ColWidths[1] := 80;

        Cells[0,0] := 'Фирма изготовитель';
        Cells[1,0] := 'Цена (BYN)';
    End;
end;

procedure OutputRecordsArr(RecordsArr: TArrOfRecord);
var
    I: Integer;
begin
    with InformationForm.StringGrid do
    begin
        For I := 0 To High(RecordsArr) Do
        Begin
            Cells[0, I+1] := RecordsArr[I].CompanyName;
            Cells[1, I+1] := FloatToStr(RecordsArr[I].Price);
        End;
    end;
end;

function SortArrayOfRecords(RecordsArr: TArrOfRecord): TArrOfRecord;
Var
    I, K, IMin: Integer;
    Buf: THardwareRecord;
Begin
    For K := 0 To High(RecordsArr)-1 Do
    Begin
        IMin := K;
        For I := K + 1 To High(RecordsArr) Do
        Begin
            If RecordsArr[I].Price < RecordsArr[IMin].Price Then
                IMin := I;
        End;

        Buf := RecordsArr[IMin];
        RecordsArr[IMin] := RecordsArr[K];
        RecordsArr[K] := Buf;
    End;

    SortArrayOfRecords := RecordsArr;
End;


function CreateArrayOfRecords(RowCount: Integer): TArrOfRecord;
var
    RecordsArr: TArrOfRecord;
    TempRecord: THardwareRecord;
    I: Integer;
begin
    SetLength(RecordsArr, RowCount-1);
    Seek(CorrectedRecordsFile, 0);

    for I := 0 to High(RecordsArr) do
    begin
        Read(CorrectedRecordsFile, TempRecord);
        RecordsArr[I] := TempRecord;
    end;

    CreateArrayOfRecords := RecordsArr;
end;

procedure TInformationForm.FormShow(Sender: TObject);
var
    RowCount: Integer;
    RecordsArr: TArrOfRecord;
begin
    RowCount := MainForm.StringGrid.RowCount;

    InformationForm.StringGrid.RowCount := RowCount;
    if IsStringGridNotEmpty then
    begin
        RecordsArr := CreateArrayOfRecords(RowCount);
        RecordsArr := SortArrayOfRecords(RecordsArr);
        OutputRecordsArr(RecordsArr);
    end;
end;

end.
