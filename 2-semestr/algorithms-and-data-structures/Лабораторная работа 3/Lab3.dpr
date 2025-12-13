program Lab3;

uses
  System.SysUtils;

type
    PStackElem = ^StackElem;
    StackElem = record
        Value: AnsiChar;
        Next: PStackElem;
    end;
    TPriorityArray = array [AnsiChar] of Byte;
function CreateStack(): PStackElem;
begin
    CreateStack := nil;
end;

procedure PushElem (var Top: PStackElem; NewValue: AnsiChar);
var
    OldTop: PStackElem;
begin
    OldTop := Top;
    New(Top);
    Top^.Next := OldTop;
    Top^.Value := NewValue;
end;

function PopElem (var Top: PStackElem): AnsiChar;
var
    Temp: PStackElem;
begin
    PopElem := Top^.Value;
    Temp := Top;
    Top := Top^.Next;
    Dispose(Temp);
end;

function InputStr(): AnsiString;
const
    AVAILABLE_SYMBOLS = '+-*/^()0123456789abcdefghijklmnopqrstuvwxyz';
var
    I: Integer;
    IsCorrect: Boolean;
    InputLine: AnsiString;
begin
    repeat
        Writeln('Ввведите математическое выражение без пробелов:');
        Readln(InputLine);
        I := Low(InputLine);
        IsCorrect := True;
        while (I <= High(InputLine)) and IsCorrect do
        begin
            IsCorrect := Pos(InputLine[I], AVAILABLE_SYMBOLS) <> 0;
            Inc(I);
        end;
    until IsCorrect;
    InputStr := InputLine;
end;

function FillStackPriorityArray(): TPriorityArray;
var
    Arr: TPriorityArray;
    C: AnsiChar;
begin
    Arr['+'] := 2;
    Arr['-'] := 2;
    Arr['*'] := 4;
    Arr['/'] := 4;
    Arr['^'] := 5;
    Arr['('] := 0;
    //Arr[')'] :=
    for C := '0' to '9' do
        Arr[C] := 8;
    for C := 'a' to 'z' do
        Arr[C] := 8;

    FillStackPriorityArray := Arr;
end;

function FillRelativePriorityArray(): TPriorityArray;
var
    Arr: TPriorityArray;
    C: AnsiChar;
begin
    Arr['+'] := 1;
    Arr['-'] := 1;
    Arr['*'] := 3;
    Arr['/'] := 3;
    Arr['^'] := 6;
    Arr['('] := 9;
    Arr[')'] := 0;
    for C := '0' to '9' do
        Arr[C] := 7;
    for C := 'a' to 'z' do
        Arr[C] := 7;

    FillRelativePriorityArray := Arr;
end;

procedure OutputStack(Top: PStackElem);
begin
    if Top <> nil then
    begin
        OutputStack(Top^.Next);
        Write(Top^.Value);
    end;
end;

procedure OutputInfo (Stack: PStackElem; CurrCh: AnsiChar; OutputLine: AnsiString);
begin
    Write('  ' + CurrCh + '               ');
    OutputStack(Stack);
    Write('          ');
    Writeln(OutputLine);
end;

function CalculateRang(Str: AnsiString): Integer;
var
    I, Rang: Integer;
begin
    Rang := 0;
    for I := Low(Str) to High(Str) do
        case Str[I] of
            '-','+','*','/','^': Dec(Rang)
        else
            Inc(Rang);
        end;
    CalculateRang := Rang;
end;

var
    InputLine, OutputLine: AnsiString;
    I: Integer;
    Stack: PStackElem;
    StackPriority, RelativePriority: TPriorityArray;
    Ch, StackCh: AnsiChar;

begin
    Writeln('Программа преобразует математическое выражение в выражение, записанное с помощью обратной польской нотации');
    InputLine := InputStr();
    Writeln('Символ            Стек            Выходная строка');

    Stack := CreateStack();
    RelativePriority := FillRelativePriorityArray();
    StackPriority := FillStackPriorityArray();
    OutputLine := '';

    for I := Low(InputLine) to High(InputLine) Do
    begin
        Ch := InputLine[I];
        if Stack = nil then
            PushElem(Stack, Ch)
        else
        begin
            if RelativePriority[Ch] > StackPriority[Stack^.Value] then
                PushElem(Stack, Ch)
            else
            begin
                if Ch = ')' then
                begin
                    repeat
                        StackCh := PopElem(Stack);
                        if StackCh <> '(' then
                            OutputLine := OutputLine + StackCh;
                    until (StackCh = '(') or (Stack = nil);
                end
                else
                begin
                    repeat
                        StackCh := PopElem(Stack);
                        if StackCh <> '(' then
                            OutputLine := OutputLine + StackCh;
                    until (Stack = nil) or (RelativePriority[Ch] > StackPriority[Stack^.Value]);
                    PushElem(Stack, Ch);
                end;
            end;
        end;

        OutputInfo(Stack, Ch, OutputLine);
    end;

    while Stack <> nil do
        OutputLine := OutputLine + PopElem(Stack);

    OutputInfo(Stack, ' ', OutputLine);     

    Writeln('Полученное выражение:');
    Writeln(OutputLine);

    Writeln('Ранг:');
    Writeln(CalculateRang(OutputLine));
    
    Readln;
end.
