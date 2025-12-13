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

Procedure FillMatrix();
Var
    TopCount, I, J: Word;
    Curr: PBaseTop;
    CurrTop: PTop;
Begin
    TopCount := GetTopCount();
    InitializeMatrix(TopCount);

    For I := Low(Matrix) To High(Matrix) Do
        For J := Low(Matrix) To High(Matrix) Do
            Matrix[I, J] := 0;

    Curr := BaseList^.Next;
    While Curr <> Nil Do
    Begin
        CurrTop := Curr^.NextTop^.NextTop;
        While CurrTop <> Nil Do
        Begin
            Matrix[Curr^.TopValue - 1, CurrTop^.Top - 1] := 1;
            CurrTop := CurrTop^.NextTop;
        End;
        Curr := Curr^.Next;
    End;
End;
end.
