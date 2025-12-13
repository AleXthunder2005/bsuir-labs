program Lab2;

Uses
    System.SysUtils;

Type
    TPointer = ^NumberList;
    NumberList = record
        Number: Integer;
        Name: String;
        SecondName: String;
        FatherName: String;
        NextPointer: TPointer;
    end;

Function ReadNum(): Integer;
Var
    N: Integer;
    IsCorrect: Boolean;
Begin
    Repeat
        IsCorrect := True;
        Try
            Readln(N);
        Except
            IsCorrect := False;
            Writeln('Некорректный ввод! Введите семизначный номер!');
        End;
        If (IsCorrect) And ((N > 9999999)Or (N < 1000000)) then
        Begin
            IsCorrect := False;
            Writeln('Некорректный ввод! Введите семизначный номер!');
        End;
        ReadNum := N;
    Until IsCorrect;
End;

Function ReadChoice(Min, Max: Integer): Integer;
Var
    N: Integer;
    IsCorrect: Boolean;
Begin
    Repeat
        IsCorrect := True;
        Try
            Readln(N);
        Except
            IsCorrect := False;
            Writeln('Некорректный ввод! Попробуйте еще раз!');
        End;
        If(IsCorrect) And ((N > Max) Or (N < Min)) then
        Begin
            IsCorrect := False;
            Writeln('Некорректный ввод! Попробуйте еще раз!');
        End;
        ReadChoice := N;
    Until IsCorrect;
End;



Procedure OutputNumberRecord(Header: TPointer; Number: Integer);
var
    IsFinded: Boolean;
    NextPointer: TPointer;
Begin
    IsFinded := False;
    NextPointer := Header^.NextPointer;
    While(NextPointer^.NextPointer <> nil) do
    Begin
        if NextPointer^.Number = Number then
        Begin
            Writeln(NextPointer^.SecondName);
            IsFinded := True;
        End;
        NextPointer := NextPointer^.NextPointer;
    End;

    //последний элемент списка, у него NextPointer = nil
    if NextPointer^.Number = Number then
    Begin
        Writeln(NextPointer^.SecondName);
        IsFinded := True;
    End;

    if Not IsFinded then
        Writeln('Совпадений не найдено!');
End;

Procedure OutputSecondNameRecord(Header: TPointer; SecondName: String);
var
    IsFinded: Boolean;
    NextPointer: TPointer;
Begin
    IsFinded := False;
    NextPointer := Header^.NextPointer;
    While(NextPointer^.NextPointer <> nil) do
    Begin
        if NextPointer^.SecondName = SecondName then
        Begin
            Writeln(NextPointer^.Number);
            IsFinded := True;
        End;
        NextPointer := NextPointer^.NextPointer;
    End;

    //последний элемент списка, у него NextPointer = nil
    if NextPointer^.SecondName = SecondName then
    Begin
        Writeln(NextPointer^.Number);
        IsFinded := True;
    End;

    if not IsFinded then
        Writeln('Совпадений не найдено!');
End;

Procedure CreateNewRecord(Pointer: TPointer; Name, SecondName, FatherName: String; Number: Integer);
Begin
    Pointer^.Name := Name;
    Pointer^.SecondName := SecondName;
    Pointer^.FatherName := FatherName;
    Pointer^.Number := Number;
End;

Procedure InsertRecordToList(Header: TPointer; Name, SecondName, FatherName: String; Number: Integer);
Var
    ListElementPointer, TempPointer: TPointer;
    IsInserted: Boolean;
Begin
    ListElementPointer := Header;
    IsInserted := False;

    .(*

     *)ile (ListElementPointer^.NextPointer <> nil) and not IsInserted do
    begin
        ListElementPointer := ListElementPointer^.NextPointer;
        if SecondName > ListElementPointer^.SecondName then
        begin
            TempPointer := ListElementPointer^.NextPointer;
            New(ListElementPointer);
            CreateNewRecord(ListElementPointer, Name, SecondName, FatherName, Number);
            ListElementPointer^.NextPointer := TempPointer;

            IsInserted := True;
        end;

    end;

    if not IsInserted then
    begin
        New(ListElementPointer^.NextPointer);
        ListElementPointer := ListElementPointer^.NextPointer;
        CreateNewRecord(ListElementPointer, Name, SecondName, FatherName, Number);
        ListElementPointer^.NextPointer := nil;
    end;
End;

procedure OutputRecord(ListElementPointer: TPointer);
begin
    Writeln(ListElementPointer^.SecondName + ' ' + ListElementPointer^.Name + ' ' + ListElementPointer^.FatherName + ' ' + IntToStr(ListElementPointer^.Number));
end;

Procedure OutputList (Header: TPointer);
Var
    ListElementPointer: TPointer;
begin
    ListElementPointer := Header;
    while ListElementPointer^.NextPointer <> nil do
    begin
        ListElementPointer := ListElementPointer^.NextPointer;
        OutputRecord(ListElementPointer);
    end;
end;

Var
    Number, Choice: Integer;
    Name, SecondName, FatherName: String;
    Header: TPointer;
begin
    New(Header);
    Header^.NextPointer := nil;

    Repeat
        Writeln('Добавить новую запись - 1, завершить ввод - 0:');
        Writeln('-----------------------------------------------------');
        Choice := ReadChoice(0, 1);

        if Choice <> 0 then
        Begin
            Write('Введите фамилию: ');
            Readln(SecondName);

            Write('Введите имя: ');
            Readln(Name);

            Write('Введите отчество: ');
            Readln(FatherName);

            Write('Введите семизначный номер телефона: ');
            Number := ReadNum();

            InsertRecordToList(Header, Name, SecondName, FatherName, Number);
        End;
        Writeln('-----------------------------------------------------');
    Until Choice = 0;

    OutputList(Header);

    Writeln('Выберите действие со списком:');
    Repeat
        Writeln('0 - выход, 1 - поиск по фамилии, 2 - поиск по номеру:');
        Writeln('-----------------------------------------------------');
        Choice := ReadChoice(0, 2);
        case Choice of
            1:
            Begin
                If Header^.NextPointer = nil then
                    Writeln('Список номеров пуст!')
                Else
                Begin
                    Write('Введите фамилию: ');
                    Readln(SecondName);
                    OutputSecondNameRecord(Header, SecondName);
                End;
            End;
            2:
            Begin
                If Header^.NextPointer = nil then
                    Writeln('Список номеров пуст!')
                Else
                Begin
                    Write('Введите номер: ');
                    Number := ReadNum();
                    OutputNumberRecord(Header, Number);
                End;
            End;
        end;
        Writeln('-----------------------------------------------------');
    Until Choice = 0;


end.
