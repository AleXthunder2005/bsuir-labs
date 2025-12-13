unit GraphUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus;

type
  TGraphForm = class(TForm)
    UpPanel: TPanel;
    TitleLabel: TLabel;
    DownPanel: TPanel;
    SourceLabel: TLabel;
    ExitButton: TButton;
    FindButton: TButton;
    DestEdit: TEdit;
    ScrollBox: TScrollBox;
    MainImage: TImage;
    SourceEdit: TEdit;
    DestLabel: TLabel;
    CopyPastePopupMenu: TPopupMenu;
    CopyButton: TMenuItem;
    PasteButton: TMenuItem;
    CutButton: TMenuItem;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GraphForm: TGraphForm;

implementation
uses
    GraphImplementUnit, IncidentListUnit, Math, Clipbrd;
type
    TDistanceArr = array of Integer;

    TEdge = record
        Source, Destination, Weight: Integer;
    end;
    TEdges = Array of TEdge;
var
    R: Integer;

const
    VERTEX_RAD = 15;
    TEXT_PAD = 7;
    PAD = 60;

    kBACKSPACE = #8;
    kINSERT = 45;
    kENTER = 13;
    kDOWN = 40;
    kUP = 38;
    kRIGHT = 39;
    kLEFT = 37;
    kESC = 27;
{$R *.dfm}

procedure TGraphForm.ExitButtonClick(Sender: TObject);
begin
    GraphForm.Close;
end;

procedure EditImageSize();
var
    Size: Integer;
begin
    Size := 2*R + 2*PAD;
    with GraphForm.MainImage do
    begin
        if (Size > ClientWidth) or (Size > ClientHeight)then
        begin
            Align := alNone;
            Width := Size;
            Height := Size;
        end
        else
            Align := alClient;
    end;
end;

procedure OutputGraph;
var
    XC, YC, I, X0, Y0, X1, Y1, XSign, YSign, Coef: Integer;
    Curr: PBaseTop;
    CurrTop: PTop;
    Pt: TPoint;
    Angle: Single;
const
    LOOP_RAD = VERTEX_RAD-3;
    SHIFT = 20;
    ARROW_END = 7;
    AR_SHIFT = 6;
    AR_TEXT_PAD = 20;
begin
    with GraphForm.MainImage do
    begin
        Picture := nil;

        XC := R + PAD;
        YC := R + PAD;

        EditImageSize();
        with Canvas do
        begin
            Curr := BaseList^.Next;
            while Curr <> nil do
            begin
                CurrTop := Curr^.NextTop^.NextTop;
                while CurrTop <> nil do
                begin
                    if Curr^.TopValue = CurrTop^.Top then
                    begin
                        Brush.Color :=  clBtnHighlight;
                        Pt := Coord[Curr^.TopValue-1];
                        X0 := Pt.X + XC - LOOP_RAD;
                        Y0 := Pt.Y + YC - LOOP_RAD - SHIFT;
                        Ellipse(X0, Y0, X0 + 2 * LOOP_RAD, Y0 + 2 * LOOP_RAD);
                        Brush.Color :=  clBtnHighLight;
                    end
                    else
                    begin
                        Pt := Coord[Curr^.TopValue-1];
                        X0 := Pt.X + XC;
                        Y0 := Pt.Y + YC;

                        X1 := Coord[CurrTop^.Top-1].X + XC;
                        Y1 := Coord[CurrTop^.Top-1].Y + YC;

                        MoveTo(X0, Y0);
                        LineTo(X1, Y1);

                        Font.Name := 'Tahoma';
                        Font.Size := 8;

                        if (X1-X0) <= 0 then
                            XSign := 1
                        else
                            XSign := -1;

                        if (Y1-Y0) <= 0 then
                            YSign := 1
                        else
                            YSign := -1;

                        if X1 - X0 = 0 then
                            Inc(X1);

                        Angle := Abs(ArcTan((Y1 - Y0) / (X1 - X0)));
                        X0 := Round(X1 + XSign * 2.5 * VERTEX_RAD * Cos(Angle));
                        Y0 := Round(Y1 + YSign * 2.5 * VERTEX_RAD * Sin(Angle));
                        TextOut(X0, Y0-TEXT_PAD, IntToStr(CurrTop^.WayLength));

                        X1 := Round(X1 + XSign * VERTEX_RAD * Cos(Angle));
                        Y1 := Round(Y1 + YSign * VERTEX_RAD * Sin(Angle));
                        MoveTo(X1, Y1);
                        LineTo(Round(X1 + XSign * 10 * Cos(Angle - PI / 6)), Round(Y1 + YSign * 10 * Sin(Angle - PI / 6)));
                        MoveTo(X1, Y1);
                        LineTo(Round(X1 + XSign * 10 * Cos(Angle + PI / 6)), Round(Y1 + YSign * 10 * Sin(Angle + PI / 6)));
                    end;
                    CurrTop := CurrTop^.NextTop;
                end;
                Curr := Curr^.Next;
            end;
            Font.Name := 'System';
            Font.Size := 10;
            Brush.Color :=  TColor($0093DAFF);
            for I := Low(Coord) to High(Coord) do
            begin
                X0 := Coord[I].X - VERTEX_RAD + XC;
                Y0 := Coord[I].Y - VERTEX_RAD + YC;
                Ellipse(X0, Y0, X0 + 2 * VERTEX_RAD, Y0 + 2 * VERTEX_RAD);
                TextOut(X0 + TEXT_PAD, Y0 + TEXT_PAD, IntToStr(I+1));
            end;
        end;
    end;
end;

function GetEdgeCount(): Word;
var
    Curr: PBaseTop;
    CurrTop: PTop;
    EdgeCount: Word;
begin
    EdgeCount := 0;
    Curr := BaseList^.Next;
    while Curr <> nil do
    begin
        CurrTop := Curr^.NextTop^.NextTop;
        while CurrTop <> nil do
        begin
            Inc(EdgeCount);
            CurrTop := CurrTop^.NextTop;
        end;
        Curr := Curr^.Next;
    end;
    GetEdgeCount := EdgeCount;
end;

procedure FillEdges(Edges: TEdges);
var
    Curr: PBaseTop;
    CurrTop: PTop;
    Temp: TEdge;
    I: Word;
begin
    I := 0;
    Curr := BaseList^.Next;
    while Curr <> nil do
    begin
        CurrTop := Curr^.NextTop^.NextTop;
        while CurrTop <> nil do
        begin
            Temp.Source := Curr^.TopValue;
            Temp.Destination := CurrTop^.Top;
            Temp.Weight := CurrTop^.WayLength;
            Edges[I] := Temp;
            Inc(I);
            CurrTop := CurrTop^.NextTop;
        end;
        Curr := Curr^.Next;
    end;
end;

Procedure TGraphForm.FindButtonClick(Sender: TObject);
Var
    DestTop, SrcTop, I, J, EdgeCount: Word;
    Dist: TDistanceArr;
    Edges: TEdges;
Begin
    SrcTop := StrToInt(SourceEdit.Text);
    DestTop := StrToInt(DestEdit.Text);
    SetLength(Dist, CommonBaseTopCount);

    For I := Low(Dist) To High(Dist) Do
        Dist[I] := High(Integer);

    Dist[SrcTop-1] := 0;

    EdgeCount := GetEdgeCount;
    SetLength(Edges, EdgeCount);
    FillEdges(Edges);

    For I := 0 To CommonBaseTopCount - 2 Do
        For J := 0 To EdgeCount-1 Do
            If (Dist[Edges[J].Source-1] <> High(Integer)) And (Dist[Edges[J].Source-1] + Edges[J].Weight < Dist[Edges[J].Destination-1]) Then
                Dist[Edges[J].Destination-1] := Dist[Edges[J].Source-1] + Edges[J].Weight;

    If Dist[DestTop-1] = High(Integer) Then
        MessageBox(Handle, 'Между городами нет пути!', 'Длина кратчайшего пути', MB_OK Or MB_ICONINFORMATION)
    Else
        MessageBox(Handle, PChar('Длина кратчайшего пути из города ' + IntToStr(SrcTop) + ' в город ' + IntToStr(DestTop) +  ' равна ' + IntToStr(Dist[DestTop-1])+ '.'), 'Длина кратчайшего пути', MB_OK Or MB_ICONINFORMATION);
End;


procedure EditButtonEnabled();
begin
    with GraphForm do
        FindButton.Enabled := (SourceEdit.Text <> '') and (DestEdit.Text <> '');
end;

procedure TGraphForm.FormShow(Sender: TObject);
begin
    SourceEdit.Text := '';
    DestEdit.Text := '';
    ActiveControl := SourceEdit;
    InitializeCoord();
    R := Round(150 * Length(Coord)/20*2);
    FillCoord(R);
    OutputGraph;
end;

procedure TGraphForm.PasteButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).PasteFromClipboard;
end;

procedure TGraphForm.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case key of
        kRIGHT, kDOWN:
        begin
            SelectNext(ActiveControl, True, True);
            with TEdit(ActiveControl) do
                SelStart := Length(Text);
        end;
        kLEFT, kUP:
        begin
            SelectNext(ActiveControl, False, True);
            with TEdit(ActiveControl) do
                SelStart := Length(Text);
        end;
        kINSERT:
            Key := 0;
        kENTER: if FindButton.Enabled then FindButton.Click;
        kESC: Close;
    end;
end;

procedure TGraphForm.EditKeyPress(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9', kBACKSPACE]) then
        Key := #0;
end;

procedure TGraphForm.CopyButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CopyToClipboard;
end;

procedure TGraphForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    IValue: Integer;
    Buffer: String;
    IsCorrect: Boolean;
begin
    Buffer := Clipboard.AsText;
    IsCorrect := TryStrToInt(Buffer, IValue);
    PasteButton.Enabled := IsCorrect;
end;

procedure TGraphForm.CutButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CutToClipboard;
end;

procedure TGraphForm.EditChange(Sender: TObject);
var
    TempStr:String;
    IValue, CursPos: Integer;
begin
    with Sender As TEdit do
    Begin
       if Text = '0' then
            Text := ''
        else
            if (Length(Text) > 0) then
            begin
                CursPos := SelStart;
                TempStr := Text;

                if not TryStrToInt(TempStr, IValue) or (IValue < 1) or (IValue > CommonBaseTopCount) then
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
        EditButtonEnabled;
    End;
end;

end.
