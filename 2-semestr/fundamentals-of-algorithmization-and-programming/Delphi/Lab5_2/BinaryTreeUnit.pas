unit BinaryTreeUnit;

interface
type
    TPointer = ^Elem;
    Elem = record
        Value: Integer;
        NextLeft, NextRight: TPointer;
    end;
    PNodeList = ^NodeList;
    NodeList = record
        Value: Integer;
        Next: PNodeList;
    end;

function CreateEmptyTree(): TPointer;
procedure AddElemToTree(const N: Integer; Var TreeStart: TPointer);
procedure DeleteElemInTree(Const N: Integer; Var TreeStart: TPointer);
procedure EditTree(var TreeStart: TPointer);
procedure ClearTree(var TreeStart: TPointer);
function FindMaxDepth(TreeStart: TPointer): Integer;
function FindMinDepth(TreeStart: TPointer): Integer;
function CalculateTreeCoef (TreeStart: TPointer): Integer;
implementation

var
    ListLastElem, ListCentralVertex: PNodeList;

function CreateEmptyTree(): TPointer;
begin
    CreateEmptyTree := nil;
end;

procedure ClearTree(var TreeStart: TPointer);
begin
    if TreeStart <> nil then
    begin
        if (TreeStart^.NextLeft = nil) and (TreeStart^.NextRight = nil) then
        begin
            Dispose(TreeStart);
            TreeStart := nil;
        end
        else if TreeStart^.NextLeft <> nil then
            ClearTree(TreeStart^.NextLeft)
        else if TreeStart^.NextRight <> nil then
            ClearTree(TreeStart^.NextRight)
        else
        begin
            ClearTree(TreeStart^.NextLeft);
            ClearTree(TreeStart^.NextRight);
        end;
    end;
end;

procedure AddElemToTree(const N: Integer; Var TreeStart: TPointer);
begin
    if TreeStart <> nil then
    begin
        if TreeStart^.Value > N then
            AddElemToTree(N, TreeStart^.NextLeft)
        else
            if TreeStart^.Value < N then
                AddElemToTree(N, TreeStart^.NextRight);
    end
    else
    begin
        New(TreeStart);
        TreeStart^.Value := N;
        TreeStart^.NextRight := nil;
        TreeStart^.NextLeft := nil;
    end;
end;

procedure FindMinElemInRightSubtree(var StartSubtree: TPointer);
begin
    while StartSubtree^.NextLeft <> nil do
        StartSubtree := StartSubtree^.NextLeft;
end;

procedure DeleteElemInTree(const N: Integer; var TreeStart: TPointer);
var
    Temp: TPointer;
begin
    if TreeStart <> nil then
    begin
        if TreeStart^.Value = N then
        begin
            Temp := TreeStart;
            if TreeStart^.NextRight <> nil then
            begin
                if TreeStart^.NextLeft = nil then
                begin
                    TreeStart := TreeStart^.NextRight;
                    Dispose(Temp);
                end
                else
                begin
                    Temp := TreeStart^.NextRight;
                    FindMinElemInRightSubtree(Temp);
                    TreeStart^.Value := Temp^.Value;
                    DeleteElemInTree (Temp^.Value, TreeStart^.NextRight);
                end;
            end
            else
                if TreeStart^.NextLeft <> nil then
                begin
                    TreeStart := TreeStart^.NextLeft;
                    Dispose(Temp);
                end
                else
                begin
                    TreeStart := nil;
                    Dispose(Temp);
                end;
        end
        else
        begin
            if TreeStart^.Value > N then
                DeleteElemInTree(N, TreeStart^.NextLeft)
            else
                DeleteElemInTree(N, TreeStart^.NextRight);
        end;
    end;
end;

function GetMin (A, B: Integer): Integer;
begin
    if A < B then
        GetMin := A
    else
        GetMin := B;
end;

function GetMax (A, B: Integer): Integer;
begin
    if A > B then
        GetMax := A
    else
        GetMax := B;
end;

function FindMinDepth(TreeStart: TPointer): Integer;
var
    MinDepth: Integer;
begin
    if TreeStart = nil then
        MinDepth := 0
    else if (TreeStart^.NextLeft = nil) and (TreeStart^.NextRight = nil) then
        MinDepth := 1
    else if TreeStart^.NextLeft = nil then
        MinDepth := 1 + FindMinDepth(TreeStart^.NextRight)
    else if TreeStart^.NextRight = nil then
        MinDepth := 1 + FindMinDepth(TreeStart^.NextLeft)
    else
        MinDepth := 1 + GetMin(FindMinDepth(TreeStart^.NextLeft), FindMinDepth(TreeStart^.NextRight));

    FindMinDepth := MinDepth;
end;

function FindMaxDepth(TreeStart: TPointer): Integer;
var
    MaxDepth, MaxR, MaxL: Integer;
begin
    if TreeStart = nil then
        MaxDepth := 0
    else
    begin
        MaxR := 1 + FindMaxDepth(TreeStart^.NextRight);
        MaxL := 1 + FindMaxDepth(TreeStart^.NextLeft);

        MaxDepth := GetMax(MaxL, MaxR);
    end;
    FindMaxDepth := MaxDepth;
end;

procedure AddNodeToList(const Value: Integer; Header: PNodeList);
begin
    while Header^.Next <> nil do
        Header := Header^.Next;

    New(Header^.Next);
    Header := Header^.Next;
    Header^.Value := Value;
    Header^.Next := nil;
end;

procedure GetLeafsValue(TreeStart: TPointer; Depth: Integer);
begin
    if TreeStart <> nil then
    begin
        if (Depth = 1) and (TreeStart^.NextLeft = nil) and (TreeStart^.NextRight = nil) then
        begin
            AddNodeToList(TreeStart^.Value, ListLastElem);
        end
        else
        begin
            GetLeafsValue(TreeStart^.NextLeft, Depth - 1);
            GetLeafsValue(TreeStart^.NextRight, Depth - 1);
        end;
    end;
end;

function IsValueInList (const Value: Integer; Header: PNodeList): Boolean;
var
    IsElemInList: Boolean;
begin
    IsElemInList := False;
    while (Header^.Next <> nil) and not IsElemInList do
    begin
        if Value = Header^.Next^.Value then
            IsElemInList := True;

        Header := Header^.Next;
    end;

    IsValueInList := IsElemInList;
end;

procedure GetCentraVertexes(TreeStart: TPointer; Depth: Integer; const LeafValue: Integer);
begin
    if TreeStart <> nil then
    begin
        if Depth = 1 then
        begin
            if not IsValueInList(TreeStart^.Value, ListCentralVertex) then
                AddNodeToList(TreeStart^.Value, ListCentralVertex);
        end
        else
        begin
            if LeafValue < TreeStart^.Value then
                GetCentraVertexes(TreeStart^.NextLeft, Depth - 1, LeafValue)
            else
                GetCentraVertexes(TreeStart^.NextRight, Depth - 1, LeafValue);
        end;
    end;
end;

procedure DisposeList(Header: PNodeList);
var
    Temp: PNodeList;
begin
    while Header <> nil do
    begin
        Temp := Header;
        Header := Header^.Next;
        Dispose(Temp);
    end;
end;

procedure EditTree(var TreeStart: TPointer);
var
    MinDepth: Integer;
    TempListPointer: PNodeList;
begin
    MinDepth := FindMinDepth(TreeStart);
    if Odd(MinDepth) then
    begin
        New(ListLastElem);
        ListLastElem^.Next := nil;

        GetLeafsValue(TreeStart, MinDepth);

        New(ListCentralVertex);
        ListCentralVertex^.Next := nil;

        TempListPointer := ListLastElem^.Next;
        repeat
            GetCentraVertexes(TreeStart, (MinDepth + 1) div 2, TempListPointer^.Value);
            TempListPointer := TempListPointer^.Next;
        until TempListPointer = nil;

        TempListPointer := ListCentralVertex^.Next;
        repeat
            DeleteElemInTree(TempListPointer^.Value, TreeStart);
            TempListPointer := TempListPointer^.Next;
        until TempListPointer = nil;

        DisposeList(ListLastElem);
        DisposeList(ListCentralVertex)
    end;
end;

function CountSoloElem(TreeStart: TPointer): Integer;
var
    CountL, CountR: Integer;
begin
    if TreeStart = Nil then
        CountSoloElem := 0
    Else
    Begin
        if (TreeStart^.NextLeft <> nil) and (TreeStart^.NextRight = nil) then
            CountSoloElem := CountSoloElem(TreeStart^.NextLeft) + 1
        Else if (TreeStart^.NextRight <> nil) and (TreeStart^.NextLeft = nil) then
            CountSoloElem := CountSoloElem(TreeStart^.NextRight) + 1
        Else
        Begin
            CountL := CountSoloElem(TreeStart^.NextLeft);
            CountR := CountSoloElem(TreeStart^.NextRight);
            if CountL > CountR then
                CountSoloElem := CountL
            Else
                CountSoloElem := CountR;
        End;
    End;
end;

function PowerNum (Num, Pow: Integer): Integer;
var
    I, Sum: Integer;
begin
    Sum := 1;
    for I := Pow downto 1 do
        Sum := Sum * Num;

    PowerNum := Sum;
end;

function CalculateTreeCoef (TreeStart: TPointer): Integer;
begin
    CalculateTreeCoef := PowerNum(2, FindMaxDepth(TreeStart) - CountSoloElem(TreeStart))
end;

end.
