unit MatrixImplemetUnit;

interface
type
    TMatrix = array of array of Word;
    procedure FillMatrix();

var
    Matrix: TMatrix;

implementation
uses
    IncidentListUnit;

procedure InitializeMatrix(TopCount: Word);
begin
    SetLength(Matrix, TopCount, TopCount);
end;

procedure FillMatrix();
var
    TopCount, I, J: Word;
    Curr: PBaseTop;
    CurrTop: PTop;
begin
    TopCount := GetTopCount();
    InitializeMatrix(TopCount);

    for I := Low(Matrix) to High(Matrix) do
        for J := Low(Matrix) to High(Matrix) do
            Matrix[I, J] := 0;

    Curr := BaseList^.Next;
    while Curr <> nil do
    begin
        CurrTop := Curr^.NextTop^.NextTop;
        while CurrTop <> nil do
        begin
            Matrix[Curr^.TopValue - 1, CurrTop^.Top - 1] := 1;
            CurrTop := CurrTop^.NextTop;
        end;
        Curr := Curr^.Next;
    end;
end;
end.
