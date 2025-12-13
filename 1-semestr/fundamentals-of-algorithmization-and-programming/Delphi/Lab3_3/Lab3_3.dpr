Program Lab3_3;

Uses
    System.SysUtils;

Type
    TArr = Array of Integer;

Const
    MIN_ARR_LENGTH = 1;
    MAX_ARR_LENGTH = 10;
    MIN_ARR_VALUE = -1000;
    MAX_ARR_VALUE = 1000;

Var
    NumArr: TArr;

Procedure PrintCondition();
Begin
   Writeln('Данная программа сортирует массив методом простых вставок.', #10, 'Диапазон значений для длины массива - от ', MIN_ARR_LENGTH, ' до ', MAX_ARR_LENGTH, '.', #10, 'Диапазон значений для элементов массива - от ', MIN_ARR_VALUE, ' до ', MAX_ARR_VALUE, '.');
End;

Function ReadNum(Min, Max: Integer): Integer;
Var
    Num: Integer;
    IsCorrect: Boolean;
Begin
    Repeat
        IsCorrect := True;
        Try
            Readln(Num);
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
    ReadNum := Num;
End;

Function InputArrFromConsole(): TArr;
Var
    IsCorrect: Boolean;
    I, Len, Buf: Integer;
    Arr: TArr;
Begin
    Write('Введите количество элементов массива: ');
    Len := ReadNum(MIN_ARR_LENGTH, MAX_ARR_LENGTH);
    SetLength(Arr, Len);

    For I := 0 To High(Arr) Do
    Begin
        Write('Введите элемент массива № ', I + 1, ': ');
        Buf := ReadNum(MIN_ARR_VALUE, MAX_ARR_VALUE);
        Arr[I] := Buf;
    End;
    InputArrFromConsole := Arr;
End;
Function CheckFile(Path: String): Boolean;
Var
    IsFileCorrect: Boolean;
    InputFile: TextFile;
    Len, I, Buf: Integer;
    CheckArr: TArr;

Begin
    IsFileCorrect := True;
    I := 0;

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
            If IsFileCorrect And EoLn(InputFile) Then
            Begin
                Writeln('Некорректный ввод данных!');
                IsFileCorrect := False;
            End; 

            Try
                Readln(InputFile, Len);
            Except
                Writeln('Некорректный ввод количества элементов!');
                IsFileCorrect := False;
            End;

            If IsFileCorrect And (Len < MIN_ARR_LENGTH) Or (Len > MAX_ARR_LENGTH) Then
            Begin
                Writeln('Количество элементов массива выходит за возможные пределы!');
                IsFileCorrect := False;
            End;

            If IsFileCorrect Then
            Begin
                SetLength(CheckArr, Len);

                If IsFileCorrect And Eoln(InputFile) Then
                Begin
                    Writeln('Некорректный ввод элементов массива!');
                    IsFileCorrect := False;
                End; 
                
                While (I < Len) And IsFileCorrect Do
                Begin
                    Try
                        Read(InputFile, Buf);
                    Except
                        Writeln('Некорректный ввод элементов массива!');
                        IsFileCorrect := False;
                    End;

                    If (Buf < MIN_ARR_VALUE) Or (Buf > MAX_ARR_VALUE) Then
                    Begin
                        Writeln('Значение элемента выходит за пределы допутимых!');
                        IsFileCorrect := False;
                    End;
                    If IsFileCorrect Then
                    Begin
                        CheckArr[I] := Buf;
                        Inc(I);
                    End;
                End;       
                If IsFileCorrect And (Not EoF(InputFile)) Then
                Begin
                    Writeln('Некорректный ввод данных!');
                    IsFileCorrect := False;
                End;
            End;
            CloseFile(InputFile);
        End;
    End
    Else
    Begin
        Writeln('Файла по данному пути не существует!');
        IsFileCorrect := False;
    End;
    CheckFile := IsFileCorrect;
End;
Function ReadFile(Path: String): TArr;
Var
    Len, I, Buf: Integer;
    Arr: TArr;
    InputFile: TextFile;
Begin
    AssignFile(InputFile, Path);
    Reset(InputFile);

    Readln(InputFile, Len);
    SetLength(Arr, Len);

    For I := 0 To High(Arr) Do
    Begin
        Read(InputFile, Buf);
        Arr[I] := Buf;
    End;

    Close(InputFile);

    ReadFile := Arr;
End;
Function InputArrFromFile(): TArr;
Var
    PathFile: String;
    IsInputFromFileSuccessfully: Boolean;
    Arr: TArr;
Begin
Writeln('Данные в файле должны содержать количество элементов массива в первой строке и элементы массива, записанные через пробел, во второй строке.');
    Repeat
        Write('Введите путь к файлу с его расширением: ');
        Readln(PathFile);
        IsInputFromFileSuccessfully := CheckFile(PathFile);
    Until IsInputFromFileSuccessfully;
    Arr := ReadFile(PathFile);

    InputArrFromFile := Arr;
End;
Function InputArr(): TArr;
Var
    Choice: Integer;
    Arr: TArr;
Begin
    Write('Выберите вариант ввода:', #10, '1. Ввод из консоли', #10, '2. Ввод из файла', #10, 'Использовать вариант: ');
    Choice := ReadNum(1,2);

    If Choice = 1 Then
        Arr := InputArrFromConsole()
    Else
        Arr := InputArrFromFile();

    InputArr := Arr;
End;
Function SortArr(Arr: TArr): TArr;
Var
    I, J, Buf: Integer;
Begin
   For I := 1 to High(Arr) Do
   Begin
      Buf := Arr[I];
      J := I;
      While ((J > 0) And (Arr[J-1] > Buf)) Do
      Begin
          Arr[J] := Arr[J-1];
          Dec(J);
      End;
      Arr[J] := Buf;
   End;
   SortArr := Arr;
End;
Procedure OutputArrToConsole(Arr: TArr);
Var
    I: Integer;
Begin
    For I := 0 To High(Arr) Do
        Write(Arr[I], ' ');
End;

Procedure OutputArrToFile(Arr: TArr);
Var
    IsPathCorrect: Boolean;
    Path: String;
    OutputFile: TextFile;
    I: Integer;
Begin
    Writeln('Для вывода введите путь к файлу и его имя c расширением. Если файл отсутствует, он будет создан автоматически.');
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
                Writeln('Не удалось вывести в Файл!');
                IsPathCorrect := False;
            End;
        End;
    Until IsPathCorrect;

    For I := 0 To High(Arr) Do
        Write(OutputFile, Arr[I], ' ');
    CloseFile(OutputFile);
    Writeln('Вывод данных...  успешно!');
End;


Procedure OutputArr(Arr: TArr);
Var
    Choice: Integer;
Begin
    Write('Выберите вариант вывода:', #10, '1. Вывод в консоль', #10, '2. Вывод файл', #10, 'Использовать вариант: ');
    Choice := ReadNum(1,2);

    If Choice = 1 Then
        OutputArrToConsole(Arr)
    Else
        OutputArrToFile(Arr);
End;
Begin
    PrintCondition();
    NumArr := InputArr();
    NumArr := SortArr(NumArr);
    OutputArr(NumArr);
    Readln;
End.
