Program Lab1_2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

Type
    TPointer = ^TListElement;
    TListElement = Record
        Data : Integer;
        Lnext : TPointer;

    End;

Function GetInt(Min, Max : Integer): Integer;
Var
    IsCorrect : Boolean;
    N : Integer;
Begin
    Repeat
        IsCorrect := True;
        Try
            Readln(N);
        Except
            IsCorrect := False;
            Writeln('Вы ввели некорректные данные. Попробуйте снова.');
        End;

        If IsCorrect And ((N > Max) Or (N < Min)) Then
        Begin
            IsCorrect := False;
            Writeln('Введено значение не входящее в диапазон допустимых значений');
        End;

    Until IsCorrect;

    GetInt := N;

End;


procedure Make(N : Integer; Var First : TPointer);
Var
    I : Integer;
    Temp : TPointer;
Begin
    New(First);
    Temp := First;
    First^.Data := 1;
    new(First^.Lnext);
    First := First^.Lnext;
    for I := 2 to N do
    Begin
      New(First^.Lnext);
      First^.Data := I;
      if (I = N) then
          First^.Lnext := Temp
      else
          First := First^.Lnext;
    End;
End;

procedure OutExcel(N, K : Integer);
Var
    Count : TPointer;
    Meter : Integer;
begin
    New(Count);
    Make(N, Count);
    Meter := 1;
    Write(N, ':', ' ');
    while(Count^.Lnext <> Count) do
    begin
        if (Meter = k) then
        begin
            Write(Count^.Lnext.Data,' ');
            Count^.Lnext := Count^.Lnext^.Lnext;
            Meter := 0;
        end
        else
        Count := Count^.Lnext;
        Inc(Meter);

    end;
    Write(' ', '|');
    Writeln(Count^.Data);
end;


var
    I, K : Integer;
begin
    Writeln('Программа "Считалочка"');
    Writeln('Программа выведет порядок удаления игроков из круга при количестве игроков от 1 до 64, удаляя при этом K-того игрока');
    Write('Введите число K: ');
    K := GetInt(1,64);
    writeln(1, ':', ' ',' ','|',1);
    for I := 2 to 64 do
        OutExcel(I, K);
    Readln;


end.
