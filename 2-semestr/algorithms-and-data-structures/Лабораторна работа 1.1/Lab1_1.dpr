program Lab1_1;

Type
    TPointer = ^TListElement;
    TListElement = record
        Power: Integer;
        Coef: Integer;
        NextElementPointer: TPointer;
    end;

Var
    Choice, PolynomMeaning, X: Integer;
    P, Q, R: TPointer;
    IsEquality: Boolean;

Const
    MIN_NUM = -2000000000;
    MAX_NUM = 2000000000;

Function PowerNum(X, Pow: Integer): Integer;
Var
    I, ResultNum: Integer;
Begin
    ResultNum := 1;
    For I := 1 To Pow Do
        ResultNum := ResultNum * X;

    PowerNum := ResultNum;
End;

Function ReadNum (Min: Integer; Max: Integer): Integer;
Var
    Str: String;
    ResultNum, CheckNum, Code: Integer;
    IsCorrect: Boolean;
Begin
    Repeat
        Readln(Str);
        Val(Str, CheckNum, Code);
        If(Code = 0) And (CheckNum >= Min) And (CheckNum <= Max) Then
        Begin
            ResultNum := CheckNum;
            IsCorrect := True;
        End
        Else
        Begin
            Writeln('Некорректный ввод! Попробуйте еще раз!');
            IsCorrect := False;
        End;
    Until IsCorrect;
    ReadNum := ResultNum;
End;

Procedure DisposeList(HeaderPointer: TPointer);
Var
    Pointer, TempPointer: TPointer;
Begin
    Pointer := HeaderPointer;
    While(Pointer^.NextElementPointer <> nil) Do
    Begin
        TempPointer := Pointer^.NextElementPointer;
        Dispose(Pointer);
        Pointer := TempPointer;
    End;
End;

Procedure InputPolynom(HeaderPointer: TPointer);
Var
    N, I, A: Integer;
    Pointer: TPointer;
Begin
    Write('Введите степень N многочлена: ');
    N := ReadNum(1, MAX_NUM);
    I := N;

    Pointer := HeaderPointer;

    //Для первого:
    Repeat
        Write('Введите коэффициент многочлена при степени Х равной ', N, ': ');
        A := ReadNum(MIN_NUM, MAX_NUM);
        If A = 0 Then
            Writeln('Старший коэффициент не может быть нулевым!');
    Until A <> 0;

    New(Pointer^.NextElementPointer);
    Pointer := Pointer^.NextElementPointer;
    Pointer^.Power := I;
    Pointer^.Coef := A;

    //Для остальных
    For I := N-1 DownTo 0 Do
    Begin
        Write('Введите коэффициент многочлена при степени Х равной ', I, ': ');
        A := ReadNum(MIN_NUM, MAX_NUM);
        If A <> 0 Then
        Begin
            New(Pointer^.NextElementPointer);
            Pointer := Pointer^.NextElementPointer;
            Pointer^.Power := I;
            Pointer^.Coef := A;
        End;
    End;
    Pointer^.NextElementPointer := nil;
End;

Procedure OutputPolynom(HeaderPointer: TPointer);
Var
    Pointer: TPointer;
Begin
    Pointer := HeaderPointer;
    if Pointer^.NextElementPointer = nil then
        Writeln('0')
    Else
        While(Pointer^.NextElementPointer <> nil) Do
        Begin
            Pointer := Pointer^.NextElementPointer;

            case Pointer^.Power of
                0: Write(Pointer^.Coef);
                1: If Pointer^.Coef = 1 then
                        Write('X')
                    Else
                        Write (Pointer^.Coef, 'X');
            else
                if Pointer^.Coef = 1 then
                    Write('X^', Pointer^.Power)
                Else
                    Write(Pointer^.Coef, 'X^', Pointer^.Power);
            end;

            if (Pointer^.NextElementPointer <> Nil) then
                Write(' + ');
        End;
    Writeln;
End;

Function Equality (PHeaderPointer,QHeaderPointer: TPointer): Boolean;
Var
    PPointer, QPointer: TPointer;
    IsEquality: Boolean;
Begin
    IsEquality := True;

    PPointer := PHeaderPointer;
    QPointer := QHeaderPointer;

    While (PPointer^.NextElementPointer <> Nil) And (QPointer^.NextElementPointer <> Nil)  Do
    Begin
        PPointer := PPointer^.NextElementPointer;
        QPointer := QPointer^.NextElementPointer;
        If(PPointer^.Power <> QPointer^.Power) Or (PPointer^.Coef <> QPointer^.Coef) Then
            IsEquality := False;
    End;
    If (PPointer^.NextElementPointer <> Nil) Or (QPointer^.NextElementPointer <> Nil) then
        IsEquality := False;

    Equality := IsEquality;
End;

Function Meaning (PHeaderPointer: TPointer; X: Integer): Integer;
Var
    PPointer: TPointer;
    Sum: Integer;
Begin
    PPointer := PHeaderPointer;
    Sum := 0;
    While PPointer^.NextElementPointer <> Nil Do
    Begin
        PPointer := PPointer^.NextElementPointer;
        Sum := Sum + PowerNum(X, PPointer^.Power) * PPointer^.Coef;
    End;
    Meaning := Sum;

End;

Procedure Add (PHeaderPointer, QHeaderPointer, RHeaderPointer: TPointer);
Var
    PPointer, QPointer, RPointer: TPointer;
    I, PowP, PowQ, N, A, PowR: Integer;
Begin
    PPointer := PHeaderPointer;
    QPointer := QHeaderPointer;
    RPointer := RHeaderPointer;

    PowP := PPointer^.NextElementPointer^.Power;
    PowQ := QPointer^.NextElementPointer^.Power;
    If PowP > PowQ then
        N := PowP
    Else
        N := PowQ;

    PPointer := PPointer^.NextElementPointer;
    QPointer := QPointer^.NextElementPointer;

    For I := N DownTo 0 do
    Begin
        A := 0;
        PowR := -1;
        If PPointer^.Power = I then
        Begin
            PowR := I;
            A := A + PPointer^.Coef;
            If(PPointer^.NextElementPointer <> Nil) Then
                PPointer := PPointer^.NextElementPointer;
        End;

        If QPointer^.Power = I then
        Begin
            PowR := I;
            A := A + QPointer^.Coef;
            If(QPointer^.NextElementPointer <> Nil) Then
                QPointer := QPointer^.NextElementPointer;
        End;

        If (A <> 0) And (PowR <> -1) Then
        Begin
            New(RPointer^.NextElementPointer);
            RPointer := RPointer^.NextElementPointer;
            RPointer^.Power := PowR;
            RPointer^.Coef := A;
        End;
    End;
End;


Begin
    Writeln('Данная программа предлагает:');
    Writeln('1) Сравнить многочлены степени N на равенство между собой.');
    Writeln('2) Вычислить значение многочлена при аргументе X.');
    Writeln('3) Сложить два многочлена.');
    Writeln('Введите 0 если хотите выйти.');
    Writeln;

    Repeat
        Writeln('Выберите желаемое действие! Введите 0, 1, 2 или 3.');
        Choice := ReadNum(0,3);
        Case Choice of
            1:
            Begin
                Writeln;
                Writeln('Введите многочлен P');
                New(P);
                InputPolynom(P);

                Writeln;
                Writeln('Введите многочлен Q');
                New(Q);
                InputPolynom(Q);

                Writeln;
                Writeln('Введенные многочлены:');
                OutputPolynom(P);
                OutputPolynom(Q);
                IsEquality := Equality(P, Q);
                If IsEquality then
                    Writeln('Многочлены эквивалентны!')
                Else
                    Writeln('Многочлены НЕ эквивалентны!');

                DisposeList(P);
                DisposeList(Q);
            End;
            2:
            Begin
                Writeln;
                Writeln('Введите многочлен P');
                New(P);
                InputPolynom(P);

                Writeln;
                Write('Введите Х: ');
                X := ReadNum(MIN_NUM, MAX_NUM);
                PolynomMeaning := Meaning(P, X);

                Writeln;
                Writeln('Введенный многочлен:');
                OutputPolynom(P);
                Writeln('Значение многочлена при Х = ', X, ' равно ', PolynomMeaning);

                DisposeList(P);
            End;
            3:
            Begin
                Writeln;
                Writeln('Введите многочлен P');
                New(P);
                InputPolynom(P);

                Writeln;
                Writeln('Введите многочлен Q');
                New(Q);
                InputPolynom(Q);
                New(R);
                Add(P, Q, R);

                Writeln;
                Writeln('Введенные многочлены:');
                OutputPolynom(P);
                OutputPolynom(Q);

                Writeln;
                Writeln('Результат сложения многочленов:');
                OutputPolynom(R);

                DisposeList(P);
                DisposeList(Q);
                DisposeList(R);
            End;
        End;
        Writeln('-------------------------------------------------------------');
    Until Choice = 0;
end.
