Program Lab2_3;

Uses
    System.SysUtils;

Type
    TMatrix = Array of Array of Integer;

Var
    N: Integer;
    Matrix: TMatrix;

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
        If (IsCorrect) And ((Num < Min) Or (Num > Max)) Then
        Begin
            Write('Недопустимое значение! Введите значение еще раз: ');
            IsCorrect := False;
        End;
    Until (IsCorrect);
    GetNum := Num;
End;

Function CheckFile(Path: String; Var InputInt: Integer): Boolean;
Var
    IsFileCorrect: Boolean;
    InputFile: TextFile;

Const
    MIN_N = 1;
    MAX_N = 10;

Begin
    IsFileCorrect := True;
    If FileExists(Path) Then
    Begin
        AssignFile(InputFile, Path);
        Try
            Reset(InputFile);
        Except
            Writeln('Не удалось открыть файл!');
            IsFileCorrect := False;
        End;
         If IsFileCorrect Then
        Begin
            Try
                Read(InputFile, InputInt);
            Except
                Writeln('Данные в файле представлены в неправильном формате!');
                IsFileCorrect := False;
            End;
        End;

        If IsFileCorrect And Not(EoF(InputFile)) Then
        Begin
            Writeln('Данные в файле представлены в неправильном формате!');
            IsFileCorrect := False;
        End;

        If IsFileCorrect And ((InputInt < MIN_N) Or (InputInt > MAX_N)) Then
        Begin
            Writeln('Значение выходит за возможные пределы!');
            IsFileCorrect := False;
        End;
        CloseFile(InputFile);
    End
    Else
    Begin
        Writeln('Файла по данному пути не существует!');
        IsFileCorrect := False;
    End;
    CheckFile := IsFileCorrect;
End;


Function InputN(): Integer;
Var
    Choice, Num: Integer;
    PathFile: String;
    IsInputFromFileSuccessfully: Boolean;

Const
    MIN_N = 1;
    MAX_N = 10;
Begin
    Write('Выберите вариант ввода:', #10, '1. Ввод из консоли', #10, '2. Ввод из файла', #10, 'Использовать вариант: ');
    Choice := GetNum(1,2);

    If Choice = 1 Then
    Begin
        Writeln('Введите порядок матрицы N от ', MIN_N, ' до ', MAX_N, ': ');
        Num := GetNum(MIN_N, MAX_N);
    End
    Else
    Begin
        Writeln('Данные в файле должны содержать натуральное число - порядок матрицы N от ', MIN_N, ' до ', MAX_N, ': ');
        Repeat
            Write('Введите путь к файлу с его раширением: ');
            Readln(PathFile);
            IsInputFromFileSuccessfully := CheckFile(PathFile, Num);
        Until IsInputFromFileSuccessfully;
    End;
    InputN := Num;
End;

Procedure FillMatrix(Var Matrix: TMatrix);
Var
    I, J, Counter: Integer;
Begin

    I := 0;
    Counter := 1;

    Repeat
        If I Mod 2 = 0 Then
        Begin
            For J := 0 To High(Matrix[I]) Do
            Begin
                Matrix[I][J] := Counter;
                Inc(Counter);
            End;
        End
        Else
        Begin
            For J := High(Matrix[I]) DownTo 0 Do
            Begin
                Matrix[I][J] := Counter;
                Inc(Counter);
            End;
        End;
        Inc(I);
    Until (I > High(Matrix));
End;

Procedure OutputMatrix (Var Matrix: TMatrix);
Var
    I, J, Choice: Integer;
    OutputFile: TextFile;
    Path: String;
    IsPathCorrect: Boolean;
Begin
    Write('Выберите вариант вывода:', #10, '1. Вывод в консоль', #10, '2. Вывод в файл', #10, 'Использовать вариант: ');
    Choice := GetNum(1,2);

    If Choice = 1 Then
    Begin
        Writeln('Результат:');
        For I := 0 To High(Matrix) Do
        Begin
            For J := 0 To High(Matrix[I]) Do
            Begin
                Write(Matrix[I][J]:5);
            End;
            Writeln(#10);
        End;
    End
    Else
    Begin
    Writeln('Для вывода введите путь к файлу и его имя (например, F:\Projects\Matrix\Имя файла.txt). Если файл отсутствует то он будет создан автоматически по указанному пути или в корневой папке программы (по умолчанию)');
        Repeat
            IsPathCorrect := True;
            Write('Введите путь: ');
            Readln(Path);
            If Path = '' Then
                IsPathCorrect := false
            Else
            Begin
                AssignFile(OutputFile, Path);
                Try
                    Rewrite(OutputFile);
                Except
                    Writeln('Не удалось вывести в Файл');
                    IsPathCorrect := False;
                End;
            End;
        Until IsPathCorrect;

        For I := 0 To High(Matrix) Do
        Begin
            For J := 0 To High(Matrix[I]) Do
            Begin
                Write(OutputFile, Matrix[I][J]:5);
            End;
            Writeln(OutputFile, #10);
        End;
        CloseFile(OutputFile);
        Writeln('Вывод данных...  успешно!');
    End;
End;

Begin
Writeln('Данная программа заполнит матрицу чисел "змейкой"');
N := InputN;
SetLength(Matrix, N, N);
FillMatrix(Matrix);
OutputMatrix(Matrix);
Readln;
End.
