library ListDLL;

uses
  System.SysUtils,
  System.Classes;

type
    TElemPointer = ^TElem;
    TElem = record
        Value: Integer;
        Next: TElemPointer;
    end;

{$R *.res}

procedure InsertElement(Head: TElemPointer; NewValue: Integer); stdcall;
var
    Curr, Temp: TElemPointer;
begin
    Curr := Head;
    while (Curr^.Next <> nil) and (Curr^.Next^.Value <= NewValue) do
        Curr := Curr^.Next;

    New(Temp);
    Temp^.Next := Curr^.Next;
    Curr^.Next := Temp;
    Temp^.Value := NewValue;
end;

procedure InsertElementForMerge(var Curr: TElemPointer; NewValue: Integer); stdcall;
var
    Temp: TElemPointer;
begin
    while (Curr^.Next <> nil) and (Curr^.Next^.Value <= NewValue) do
        Curr := Curr^.Next;

    if Curr^.Value <> NewValue then
    begin
        New(Temp);
        Temp^.Next := Curr^.Next;
        Curr^.Next := Temp;

        Temp^.Value := NewValue;
    end;
end;

function InitializeList(): TElemPointer; stdcall;
var
    Header: TElemPointer;
begin
    New(Header);
    Header^.Next := nil;
    Header^.Value := High(Integer);

    InitializeList := Header;
end;

function MergeLists(FirstHeader, SecondHeader: TElemPointer): TElemPointer; stdcall;
var
    Temp, Curr, ResultHeader: TElemPointer;
begin
    ResultHeader := InitializeList();

    Temp := FirstHeader;
    Curr := ResultHeader;
    while Temp^.Next <> nil do
    begin
        Temp := Temp^.Next;
        InsertElementForMerge(Curr, Temp^.Value);
    end;

    Temp := SecondHeader;
    Curr := ResultHeader;
    while Temp^.Next <> nil do
    begin
        Temp := Temp^.Next;
        InsertElementForMerge(Curr, Temp^.Value);
    end;

    MergeLists := ResultHeader;
end;

procedure DisposeList (Header: TElemPointer); stdcall;
var
    Curr, Temp: TElemPointer;
begin
    if Header^.Next <> nil then
    begin
        Curr := Header^.Next;

        while Curr^.Next <> nil do
        begin
            Temp := Curr^.Next;
            Dispose(Curr);
            Curr := Temp;
        end;
        Dispose(Curr);
        Header^.Next := nil;
    end;
end;

procedure OutputListToTextFile (Header: TElemPointer; var FileOut: TextFile); stdcall;
var
    Curr: TElemPointer;
begin
    Curr := Header;

    Rewrite(FileOut);
    while Curr^.Next <> nil do
    begin
        Curr := Curr^.Next;
        Writeln(FileOut, Curr^.Value);
    end;
    CloseFile(FileOut);
end;

exports
    InsertElement,
    InsertElementForMerge,
    InitializeList,
    MergeLists,
    DisposeList,
    OutputListToTextFile;
begin

end.
