Program Lab2_1;

Uses
  System.SysUtils;

Var
    N, I, X, Y, Min, Max: Integer;
    IsCorrect, IsPointOnPolygon, IsPointOnLine, IsPointBetweenXCoord, IsPointBetweenYCoord, AreCoordinatesNotUnique: Boolean;
    ArrX, ArrY: Array Of Integer;
Const
    MIN_N = 3;
    MAX_N = 100;
    MIN_COORDINATE = -100;
    MAX_COORDINATE = 100;

Begin
    Writeln('Данная программа определит, находится ли точка с координатами X и Y на стороне многоугольника');
    Write('Введите количество вершин многоугольника N от ', MIN_N, ' до ', MAX_N, ': ');
    Repeat
        IsCorrect := True;
        Try
            Readln(N)
        Except
            Write('Некорректный ввод! Введите значение еще раз: ');
            IsCorrect := False;
        End;
        If (IsCorrect) And ((N < MIN_N) Or (N > MAX_N)) Then
        Begin
            Write('Недопустимое значение! Введите значение еще раз: ');
            IsCorrect := False;
        End;
    Until (IsCorrect);

    Writeln('Введите координаты точки X и Y');
    Write('Введите значение Х от ', MIN_COORDINATE, ' до ', MAX_COORDINATE, ': ');
    Repeat
        IsCorrect := True;
        Try
            Readln(X)
        Except
            Write('Некорректный ввод! Введите значение еще раз: ');
            IsCorrect := False;
        End;
        If (IsCorrect) And ((X < MIN_COORDINATE) Or (X > MAX_COORDINATE)) Then
        Begin
            Write('Недопустимое значение! Введите значение еще раз: ');
            IsCorrect := False;
        End;
    Until (IsCorrect);

    Write('Введите значение Y от ', MIN_COORDINATE, ' до ', MAX_COORDINATE, ': ');
    Repeat
        IsCorrect := True;
        Try
            Readln(Y)
        Except
            Write('Некорректный ввод! Введите значение еще раз: ');
            IsCorrect := False;
        End;
        If (IsCorrect) And ((Y < MIN_COORDINATE) Or (Y > MAX_COORDINATE)) Then
        Begin
            Write('Недопустимое значение! Введите значение еще раз: ');
            IsCorrect := False;
        End;
    Until (IsCorrect);

    SetLength(ArrX, N+1);
    SetLength(ArrY, N+1);

    Writeln('Последовательно введите координаты X и Y каждой вершины');
    Write('Введите значение Х от ', MIN_COORDINATE, ' до ', MAX_COORDINATE, ': ');
    Repeat
        IsCorrect := True;
        Try
            Readln(ArrX[0])
        Except
            Write('Некорректный ввод! Введите значение еще раз: ');
            IsCorrect := False;
        End;
        If (IsCorrect) And ((ArrX[0] < MIN_COORDINATE) Or (ArrX[0] > MAX_COORDINATE)) Then
        Begin
            Write('Недопустимое значение! Введите значение еще раз: ');
            IsCorrect := False;
        End;
    Until (IsCorrect);

    Write('Введите значение Y от ', MIN_COORDINATE, ' до ', MAX_COORDINATE, ': ');
    Repeat
        IsCorrect := True;
        Try
            Readln(ArrY[0])
        Except
            Write('Некорректный ввод! Введите значение еще раз: ');
            IsCorrect := False;
        End;
        If (IsCorrect) And ((ArrY[0] < MIN_COORDINATE) Or (ArrY[0] > MAX_COORDINATE)) Then
        Begin
            Write('Недопустимое значение! Введите значение еще раз: ');
            IsCorrect := False;
        End;
    Until (IsCorrect);

    N := N - 1;
    I := 1;
    Repeat
        Write('Введите значение Х от ', MIN_COORDINATE, ' до ', MAX_COORDINATE, ': ');
        Repeat
            IsCorrect := True;
            Try
                Readln(ArrX[I])
            Except
                Write('Некорректный ввод! Введите значение еще раз: ');
                IsCorrect := False;
            End;
            If (IsCorrect) And ((ArrX[I] < MIN_COORDINATE) Or (ArrX[I] > MAX_COORDINATE)) Then
            Begin
                Write('Недопустимое значение! Введите значение еще раз: ');
                IsCorrect := False;
            End;
        Until (IsCorrect);

        Write('Введите значение Y от ', MIN_COORDINATE, ' до ', MAX_COORDINATE, ': ');
        Repeat
            IsCorrect := True;
            Try
                Readln(ArrY[I])
            Except
                Write('Некорректный ввод! Введите значение еще раз: ');
                IsCorrect := False;
            End;
            If (IsCorrect) And ((ArrY[I] < MIN_COORDINATE) Or (ArrY[I] > MAX_COORDINATE)) Then
            Begin
                Write('Недопустимое значение! Введите значение еще раз: ');
                IsCorrect := False;
            End;
    Until (IsCorrect);

        AreCoordinatesNotUnique := ((ArrX[I] = ArrX[I-1]) And (ArrY[I] = ArrY[I-1]));
        If AreCoordinatesNotUnique Then
            Writeln('Были заданы координаты той же вершины! Введите координаты следующей!')
        Else
            Inc(I);
    Until(I > N);

    N := N + 1;
    ArrX[N] := ArrX[0];
    ArrY[N] := ArrY[0];

    I := 1;
    Repeat
        IsPointOnLine := ((Y - ArrY[I-1]) * (ArrX[I] - ArrX[I-1]) = (ArrY[I] - ArrY[I-1]) * (X - ArrX[I-1]));

        If ArrX[I-1] > ArrX[I] Then
        Begin
            Min := ArrX[I];
            Max := ArrX[I - 1];
        End
        Else
        Begin
            Min := ArrX[I - 1];
            Max := ArrX[I];
        End;

        IsPointBetweenXCoord := (X >= Min) And (X <= Max);

        If ArrY[I-1] > ArrY[I] Then
        Begin
            Min := ArrY[I];
            Max := ArrY[I - 1];
        End
        Else
        Begin
            Min := ArrY[I - 1];
            Max := ArrY[I];
        End;

        IsPointBetweenYCoord := (Y >= Min) And (Y <= Max);

        IsPointOnPolygon := (IsPointOnLine And IsPointBetweenXCoord And IsPointBetweenYCoord);
        Inc(I);
    Until((IsPointOnPolygon) Or (I > N));

    If IsPointOnPolygon Then
        Writeln('Точка находится на одной из сторон многоугольника')
    Else
        Writeln('Точка не находится ни на одной из сторон многоугольника');

    Readln;
End.
