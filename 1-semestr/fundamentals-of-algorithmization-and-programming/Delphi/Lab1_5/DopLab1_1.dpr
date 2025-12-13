Program DopLab1_1;

{$APPTYPE CONSOLE}
{$R *.res}

Uses
    System.SysUtils;
Var
    K, M, N, A, B, Lcm, Temp: Integer;
    IsCorrect: Boolean;

Begin
    Writeln('Данная программа вычислит НОК чисел K, M и N!');

    Repeat
        IsCorrect := True;

        Write('Введите натуральное число K < 1000: ');
        Try
            Readln(K);
        Except
            Write('Некорректный ввод! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (K < 1) Then
        Begin
            Write('Число должно быть положительным! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (K > 999) Then
        Begin
            Write('Число должно быть меньше 1000! ');
            IsCorrect := False;
        End;

    Until (IsCorrect);

        Repeat
        IsCorrect := True;

        Write('Введите натуральное число M < 1000: ');
        Try
            Readln(M);
        Except
            Write('Некорректный ввод! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (M < 1) Then
        Begin
            Write('Число должно быть положительным! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (M > 999) Then
        Begin
            Write('Число должно быть меньше 1000! ');
            IsCorrect := False;
        End;

    Until (IsCorrect);

        Repeat
        IsCorrect := True;

        Write('Введите натуральное число N < 1000: ');
        Try
            Readln(N);
        Except
            Write('Некорректный ввод! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (N < 1) Then
        Begin
            Write('Число должно быть положительным! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (N > 999) Then
        Begin
            Write('Число должно быть меньше 1000! ');
            IsCorrect := False;
        End;

    Until (IsCorrect);

    A := K;
    B := M;

    Repeat
        Temp := B;
        B := A Mod B;
        A := Temp;
    Until (B = 0);

    Lcm := K * M Div A;
    A := Lcm;
    B := N;

    Repeat
        Temp := B;
        B := A Mod B;
        A := Temp;
    Until (B = 0);

    Lcm := N * Lcm Div A ;

    Writeln('Наименьшее общее кратное чисел равно: ', Lcm );
    Readln;
End.
