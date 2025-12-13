Program Lab2_2;
Uses
  System.SysUtils;

Const
    MAX_P = 10000;
    Min_P = 2;

Var
    P,PrimeDivisor: Integer;

Function GetNum(Min, Max: Integer): Integer;
Var
    Num: Integer;
    IsCorrect: Boolean;
Begin
    Repeat
        IsCorrect := True;
        Try
            Readln(Num)
        Except
            Write('Некорректный ввод! Введите значение еще раз: ');
            IsCorrect := False;
        End;
        If (IsCorrect) And ((Num < Min_P) Or (Num > Max)) Then
        Begin
            Write('Недопустимое значение! Введите значение еще раз: ');
            IsCorrect := False;
        End;
    Until (IsCorrect);
    GetNum := Num;
End;

Function GetPrimeDivisor(Num: Integer): Integer;
Var
    I: Integer;
    NumRoot: Real;
Begin
    NumRoot := Sqrt(Num);
    I := 1;
    Repeat
        Inc(I);
    Until ((Num Mod I = 0) Or (I > NumRoot));
    GetPrimeDivisor := I;
    If I > NumRoot Then
        GetPrimeDivisor := Num;
End;

Begin
    Writeln('Данная программа найдет все простые делители натурального числа P');

    Write('Введите натуральное число Р от ', Min_P, ' до ', MAX_P, ': ');
    P := GetNum(Min_P, MAX_P);

    Repeat
        PrimeDivisor := GetPrimeDivisor(P);
        Write(PrimeDivisor, ' ');
        P := P Div PrimeDivisor;
    Until P = 1;

    Readln;
End.
