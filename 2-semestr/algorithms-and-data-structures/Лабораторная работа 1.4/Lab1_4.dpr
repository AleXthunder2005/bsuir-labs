program Lab1_4;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
    TPt = ^TListEl;
    TListEl = Record
        PhoneNum: String;
        Prev: TPt;
        Next: TPt;
    End;
    TSinglPt = ^TSinglListEl;
    TSinglListEl = record
        PhoneNum: String;
        Next: TSinglPt;
    end;

function InputPhoneNum(): String;
var
    InputStr: String;
    PhoneNum: Integer;
    IsCorrect: Boolean;
begin
    repeat
        Readln(InputStr);
        IsCorrect := True;
        if InputStr <> '-' then
            begin
            try
                PhoneNum := StrToInt(InputStr);
            except
                Writeln('Ошибка ввода! Введите семизначный или трехзначный номер.');
                IsCorrect := False;
            end;
            if IsCorrect and ((Length(InputStr) <> 7) and (Length(InputStr) <> 3) or (StrToInt(InputStr) <= 0) or (InputStr[1] = '+') or (InputStr[1] = '$') or (Copy(InputStr, 1, 2) = '0x')) then
            begin
                Writeln('Ошибка ввода! Введите семизначный или трехзначный номер.');
                IsCorrect := False;
            end;
        end;
    until IsCorrect;
    Result := InputStr;
end;

procedure InsertInList(PhoneNum: String; X: TSinglPt);
var
    Temp: TSinglPt;
    IsInsert: Boolean;
begin
    IsInsert := False;
    while Not IsInsert do
    begin
        if (X^.Next = nil) or (StrToInt(PhoneNum) < StrToInt(X^.Next^.PhoneNum)) then
        begin
            Temp := X^.Next;
            New(X^.Next);
            X := X^.Next;
            X^.PhoneNum := PhoneNum;
            X^.Next := Temp;
            IsInsert := True;
        end
        else
            X := X^.Next;
    end;
end;

function MakeSinglList(X: TPt): TSinglPt;
var
    FirstListEl: TSinglPt;
begin
    New(FirstListEl);
    FirstListEl^.Next := nil;
    while X <> nil do
    begin
        if Length(X^.PhoneNum) = 7 then
            InsertInList(X^.PhoneNum, FirstListEl);
        X := X^.Prev;
    end;
    Result := FirstListEl;
end;

procedure PrintList(LastEl: TPt);
begin
    while LastEl <> nil do
    begin
        Write(LastEl^.PhoneNum, ' ');
        LastEl := LastEl^.Prev;
    end;
    Writeln;
end;

procedure PrintSinglList(X: TSinglPt);
begin
    X := X^.Next;
    while X <> nil do
    begin
        Write(X^.PhoneNum, ' ');
        X := X^.Next;
    end;
    Writeln;
end;

procedure MakeList(var X: TPt);
var
    NextNum: String;
    Y: TPt;
begin
    New(X);
    X^.Prev := nil;
    NextNum := InputPhoneNum();
    while NextNum <> '-' do
    begin
        Y := X;
        Y^.PhoneNum := NextNum;
        NextNum := InputPhoneNum();
        if NextNum <> '-' then
        begin
            New(X);
            Y^.Next := X;
            X^.Prev := Y;
        end
        else
            Y^.Next := nil;
    end;
end;

var
    LastListEl: TPt;
    SinglList: TSinglPt;
begin
    Writeln('Данная программа осуществляет:');
    Writeln('1) Создание двунаправленого списка семизначных номеров абонентов и трехзначных номеров спецслужб');
    Writeln('2) Вывод списка в обратном порядке');
    Writeln('3) Вывод номеров абонентов в порядке возрастания');
    Writeln('Вводите 7-значные или 3-значные номера номера телефонов (чтобы окончить ввод, введите "-"):');
    MakeList(LastListEl);
    Writeln('Введенные номера (в обратном порядке):');
    PrintList(LastListEl);
    Writeln;
    Writeln('Введенные номера абонентов (в порядке возрастания):');
    SinglList := MakeSinglList(LastListEl);
    PrintSinglList(SinglList);
    Readln;
end.
