unit IncidentListUnit;

interface
type
    PTop = ^TIncidentList;
    TIncidentList = record
        Top: Word;
        WayLength: Integer;
        NextTop: PTop;
    end;

    PBaseTop = ^TTopList;
    TTopList = record
        TopValue: Word;
        NextTop: PTop;
        Next: PBaseTop;
    end;
    procedure InitializeList();
    procedure BuildBaseTopList(TopCount: Word);
    procedure DisposeList();
    function GetTopCount(): Word;
    procedure AddTop(Dest, TopValue, LengthWay: Integer);
    function GetSecondaryListTopMaxCount(): Word;
    function GetSecondaryListElemCount(BaseTop: Word): Word;
    function GetTopByCoord(BaseTop, SecondaryTop: Word): PTop;
    procedure DeleteSelectedElem(SelectedBaseTop, SelectedTop: Word);
    function FindBaseTopByValue(Value: Word): PBaseTop;
var
    BaseList: PBaseTop;
    CommonBaseTopCount: Word;

implementation

procedure InitializeList();
begin
    New(BaseList);
    BaseList^.NextTop := nil;
    BaseList^.Next := nil;
end;

procedure BuildBaseTopList(TopCount: Word);
var
    Curr: PBaseTop;
    I: Word;
begin
    Curr := BaseList;
    I := 1;
    while I <= TopCount do
    begin
        New(Curr^.Next);
        Curr := Curr^.Next;

        New(Curr^.NextTop);
        Curr^.NextTop^.NextTop := nil;

        Curr^.TopValue := I;
        Inc(I);
    end;
    Curr^.Next := nil;
end;

procedure DisposeSecondaryList(Header: PTop);
var
    Curr, Temp: PTop;
begin
    Curr := Header^.NextTop;
    while Curr <> nil do
    begin
        Temp := Curr;
        Curr := Curr^.NextTop;
        Dispose(Temp);
    end;
    Header^.NextTop := nil;
end;

procedure DisposeList();
var
    Temp, Curr: PBaseTop;
begin
    Curr := BaseList^.Next;
    while Curr <> nil do
    begin
        Temp := Curr;
        Curr := Curr^.Next;
        DisposeSecondaryList(Temp^.NextTop);
        Dispose(Temp);
    end;
    BaseList^.Next := nil;
end;

function FindBaseTopByValue(Value: Word): PBaseTop;
var
    Curr: PBaseTop;
begin
    Curr := BaseList^.Next;
    while Curr^.TopValue <> Value do
        Curr := Curr^.Next;

    FindBaseTopByValue := Curr;
end;

function FindSecondaryTopByCoord(BaseTop: PBaseTop; Coord: Word): PTop;
var
    CurrTop: PTop;
    I: Word;
begin
    CurrTop := BaseTop^.NextTop^.NextTop;

    for I := 1 to Coord-1 do
         CurrTop := CurrTop^.NextTop;

    FindSecondaryTopByCoord := CurrTop;
end;

procedure InsertNewTop(Header: PTop; NewTopValue, LengthWay: Integer);
var
    Curr, Temp: PTop;
begin
    Curr := Header;
    while (Curr^.NextTop <> nil) and (NewTopValue > Curr^.NextTop.Top) do
        Curr := Curr^.NextTop;

    if (Curr^.NextTop <> nil) and (Curr^.NextTop.Top = NewTopValue) then
        Exit;

    New(Temp);
    Temp^.Top := NewTopValue;
    Temp^.WayLength := LengthWay;
    Temp^.NextTop := Curr^.NextTop;
    Curr^.NextTop := Temp;
end;

procedure AddTop(Dest, TopValue, LengthWay: Integer);
var
    Top: PBaseTop;
begin
    Top := FindBaseTopByValue(Dest);
    InsertNewTop(Top^.NextTop, TopValue, LengthWay);
end;

function GetTopCount(): Word;
var
    Curr: PBaseTop;
begin
    Curr := BaseList^.Next;
    while Curr^.Next <> nil do
        Curr := Curr^.Next;

    GetTopCount := Curr^.TopValue;
end;

function GetRowElemCount(Curr: PBaseTop): Word;
var
    CurrTop: PTop;
    I: Word;
begin
    I := 0;
    CurrTop := Curr^.NextTop^.NextTop;
    while CurrTop <> nil do
    begin
        Inc(I);
        CurrTop := CurrTop^.NextTop;
    end;

    GetRowElemCount := I;
end;

function GetSecondaryListTopMaxCount(): Word;
var
    Curr: PBaseTop;
    Max, TempMax: Word;
begin
    Max := 0;
    Curr := BaseList^.Next;
    while Curr <> nil do
    begin
        TempMax := GetRowElemCount(Curr);
        if Max < TempMax then
            Max := TempMax;
        Curr := Curr^.Next;
    end;

    GetSecondaryListTopMaxCount := Max;
end;

function GetSecondaryListElemCount(BaseTop: Word): Word;
var
    Curr: PBaseTop;
begin
    Curr := FindBaseTopByValue(BaseTop);
    GetSecondaryListElemCount := GetRowElemCount(Curr);
end;

function GetTopByCoord(BaseTop, SecondaryTop: Word): PTop;
var
    Curr: PBaseTop;
begin
    Curr := FindBaseTopByValue(BaseTop);
    GetTopByCoord := FindSecondaryTopByCoord(Curr, SecondaryTop);
end;

procedure DeleteSecondaryTop(CurrTop: PTop; Value: Word);
var
    Temp: PTop;
begin
    while CurrTop^.NextTop^.Top <> Value do
        CurrTop := CurrTop^.NextTop;

    Temp := CurrTop^.NextTop;
    CurrTop^.NextTop := Temp^.NextTop;
    Dispose(Temp);
end;

procedure DeleteSelectedElem(SelectedBaseTop, SelectedTop: Word);
var
    Curr: PBaseTop;
begin
    Curr := FindBaseTopByValue(SelectedBaseTop);
    DeleteSecondaryTop(Curr^.NextTop, SelectedTop);
end;
end.
