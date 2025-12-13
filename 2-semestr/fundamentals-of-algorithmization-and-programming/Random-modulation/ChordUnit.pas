unit ChordUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    ChordImage: TImage;
    RunButton: TButton;
    AnswerLabel: TLabel;
    NumberLabel: TLabel;
    procedure RunButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
    Math;
const
    RADIUS = 200;
    MAX_RANGE = 350;//High(Integer);
var
    XCenter, YCenter: Word;
    ChordCount, LongChordCount: Integer;
    Side: Real;
{$R *.dfm}

procedure GetRandomCoordOutsideCircle(var XPoint: Real; var YPoint: Real);
var
    Coef: Integer;
begin
    repeat
        XPoint := Random(MAX_RANGE);
        YPoint := Random(MAX_RANGE);
    until Sqr(XPoint) + Sqr(YPoint) > Sqr(RADIUS);

    Coef := Random(2);
    if Coef = 1 then
        XPoint := XCenter - Abs(XPoint)
    else
        XPoint := XCenter + Abs(XPoint);

    Coef := Random(2);
    if Coef = 1 then
        YPoint := YCenter - Abs(YPoint)
    else
        YPoint := YCenter + Abs(YPoint);
end;

procedure GetRandomCoordInCircle(var XPoint: Real; var YPoint: Real);
var
    Coef: Integer;
begin
    repeat
        XPoint := Random(RADIUS);
        YPoint := Random(RADIUS);
    until Sqr(XPoint) + Sqr(YPoint) < Sqr(RADIUS);

    Coef := Random(2);
    if Coef = 1 then
        XPoint := XCenter - Abs(XPoint)
    else
        XPoint := XCenter + Abs(XPoint);

    Coef := Random(2);
    if Coef = 1 then
        YPoint := YCenter - Abs(YPoint)
    else
        YPoint := YCenter + Abs(YPoint);
end;

procedure GetRandomCoordOnCircumference (var XPoint: Real; var YPoint: Real);
var
    Coef: Integer;
begin
    Coef := Random(2);
    if Coef = 1 then
    begin
        XPoint := Random(RADIUS);
        YPoint := Trunc(Sqrt(Sqr(RADIUS) - Sqr(XPoint)));
    end
    else
    begin
        YPoint := Random(RADIUS);
        XPoint := Trunc(Sqrt(Sqr(RADIUS) - Sqr(YPoint)))
    end;

    Coef := Random(2);
    if Coef = 1 then
        XPoint := XCenter - Abs(XPoint)
    else
        XPoint := XCenter + Abs(XPoint);

    Coef := Random(2);
    if Coef = 1 then
        YPoint := YCenter - Abs(YPoint)
    else
        YPoint := YCenter + Abs(YPoint);
end;

procedure ConnectChord(X0, Y0: Real);
var
    XPoint1, YPoint1, XPoint2, YPoint2, Coef: Integer;
    XL, XR, YL, YR, TempX, TempY, K, X1, Y1, X2, Y2, B, A, C, ChordLength: Real;
    IsOnArc: Boolean;
begin
    try
        X0 := X0 - XCenter;
        Y0 := Y0 - YCenter;

        GetRandomCoordInCircle(TempX, TempY);

        TempX := TempX - XCenter;
        TempY := TempY - YCenter;

        K := (TempY - Y0)/(TempX - X0);
        B := Y0 - K*X0;
        A := 1 + K*K;

        XL := (-K*B - Sqrt(K*K*RADIUS*RADIUS - B*B + RADIUS*RADIUS)) / A;
        XR := (-K*B + Sqrt(K*K*RADIUS*RADIUS - B*B + RADIUS*RADIUS)) / A;

        YL := K*XL + B;
        YR := K*XR + B;

        ChordLength := Sqrt(Sqr(XL - XR) + Sqr(YL-YR));

        if X0 < XR then
        begin
            XPoint1 := Trunc (X0 + XCenter);
            YPoint1 := Trunc (Y0 + YCenter);
            XPoint2 := Trunc (XR + XCenter);
            YPoint2 := Trunc (YR + YCenter);
        end
        else
        begin
            XPoint1 := Trunc (X0 + XCenter);
            YPoint1 := Trunc (Y0 + YCenter);
            XPoint2 := Trunc (XL + XCenter);
            YPoint2 := Trunc (YL + YCenter);
        end;

        with MainForm.ChordImage.Canvas do
        begin
            Pen.Color := clBlue;
            MoveTo(XPoint1, YPoint1);
            LineTo(XPoint2, YPoint2);

            Pen.Color := clBlack;
            Ellipse(XPoint1-3, YPoint1-3, XPoint1+3, YPoint1+3);

            Pen.Color := clRed;
            Ellipse(Trunc(TempX + XCenter)-3, Trunc(TempY+YCenter)-3, Trunc(TempX+XCenter)+3, Trunc(TempY + YCenter)+3);
        end;

        if ChordLength > Side then
            Inc(LongChordCount);
        Inc(ChordCount);
    except
        exit;
    end;
end;

function CalculateAlpha(X, Y: Real): Real;
begin
    CalculateAlpha := 2 * Arcsin(RADIUS / Sqrt((Sqr(X - XCenter) + Sqr(Y - YCenter))));
end;

procedure DrawChord;
var
    XPoint, YPoint, XCyclePoint, YCyclePoint: Real;
begin
    with MainForm.ChordImage.Canvas do
    begin
        GetRandomCoordOutsideCircle(XPoint, YPoint);
        //Pen.Color := clBlack;
        //Ellipse(Trunc(XPoint)-2, Trunc(YPoint)-2, Trunc(XPoint)+2, Trunc(YPoint)+2);

        //GetRandomCoordInCircle(XCyclePoint, YCyclePoint);
        //MainForm.ChordImage.Canvas.Pen.Color := clBlack;
        //MainForm.ChordImage.Canvas.Ellipse(Trunc(XCyclePoint)-2, Trunc(YCyclePoint)-2, Trunc(XCyclePoint)+2, Trunc(YCyclePoint)+2);

        {with MainForm.ChordImage.Canvas do
        begin
            Pen.Color := clBlue;
            MoveTo(Trunc(XPoint), Trunc(YPoint));
            LineTo(Trunc(XCyclePoint), Trunc(YCyclePoint));
        end;}

        ConnectChord(XPoint, YPoint);
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    Randomize;
    XCenter := MainForm.ChordImage.Width Div 2;
    YCenter := MainForm.ChordImage.Height Div 2;

    ChordCount := 0;
    LongChordCount := 0;
    Side := RADIUS * Sqrt(3);
end;

procedure TMainForm.RunButtonClick(Sender: TObject);
var
    I: Integer;
begin
    with ChordImage do
    begin
        Picture := nil;
        Canvas.Pen.Color := clBlack;
        Canvas.Ellipse(XCenter - RADIUS, YCenter - RADIUS, XCenter + RADIUS, YCenter + RADIUS);
    end;
        I := 0;
        repeat
            DrawChord;
            Inc(I);
        until I = 1;

   NumberLabel.Caption := IntToStr(LongChordCount) + '/' + IntToStr(ChordCount) + '=' + FloatToStr(LongChordCount/ChordCount);
end;

end.
