unit GraphImplementUnit;

interface
uses
    System.Types;
type
    TCoordArr = array of TPoint;
    procedure FillCoord(R: Integer);
    procedure InitializeCoord;

var
    Coord: TCoordArr;

implementation
uses
    IncidentListUnit;

procedure InitializeCoord;
begin
    SetLength(Coord, CommonBaseTopCount);
end;

procedure FillCoord(R: Integer);
var
    I, X, Y: Integer;
    Angel, Delta: Real;
begin
    Delta := 2*PI/Length(Coord);
    Angel := PI;
    for I := Low(Coord) to High(Coord) do
    begin
        X := Round(R * Cos(Angel + I*Delta));
        Y := Round(R * Sin(Angel + I*Delta));
        Coord[I] := TPoint.Create(X, Y);
    end;
end;

end.
