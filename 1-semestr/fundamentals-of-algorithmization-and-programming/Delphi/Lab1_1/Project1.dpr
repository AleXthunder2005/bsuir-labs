Program Project1;

{$APPTYPE CONSOLE}
{$R *.res}

Uses
    System.SysUtils;

Const
    MAX_NUM = 1000;

Var
    A, B, C, Min, Max: Real;
    IsCorrect: Boolean;

Begin
    Writeln( 'Данная программа найдет наименьшее отношение двух чисел из трех.' );

    Repeat
        IsCorrect := True;

        Write('Введите натуральное число A < ', MAX_NUM, ': ' );
        Try
            Readln(A);
        Except
            Write('Некорректный ввод! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (A < 1) Then
        Begin
            Write('Число должно быть положительным! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (A > MAX_NUM - 1) Then
        Begin
            Write('Число должно быть меньше ', MAX_NUM, '! ');
            IsCorrect := False;
        End;

    Until (IsCorrect);

        Repeat
        IsCorrect := True;

        Write('Введите натуральное число B < ', MAX_NUM, ': ' );
        Try
            Readln(B);
        Except
            Write('Некорректный ввод! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (B < 1) Then
        Begin
            Write('Число должно быть положительным! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (B > MAX_NUM - 1) Then
        Begin
            Write('Число должно быть меньше ', MAX_NUM, '! ');
            IsCorrect := False;
        End;

    Until (IsCorrect);

        Repeat
        IsCorrect := True;

        Write('Введите натуральное число C < ', MAX_NUM, ': ' );
        Try
            Readln(C);
        Except
            Write('Некорректный ввод! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (C < 1) Then
        Begin
            Write('Число должно быть положительным! ');
            IsCorrect := False;
        End;

        If (IsCorrect) And (C > MAX_NUM - 1) Then
        Begin
            Write('Число должно быть меньше ', MAX_NUM, '! ');
            IsCorrect := False;
        End;

    Until (IsCorrect);

    Max := A;
    If B > Max Then
        Max := B;
    If C > Max Then
        Max := C;

    Min := A;
    If B < Min Then
        Min := B;
    If C < Min Then
        Min := C;

    Writeln( 'Наименьшее отношение чисел: ', Min / Max:10:4 );
    Readln;
End.

