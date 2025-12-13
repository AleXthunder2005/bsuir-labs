Program Lab2_4;

Uses
    System.SysUtils;

Type
    TArray = Array Of Integer;

Var
    CountOfPrimeNumbers: Integer;
    ArrA: TArray;

Const
    MIN_ARR_LENGTH = 1;
    MAX_ARR_LENGTH = 20;
    MIN_ARR_VALUE = 1;
    MAX_ARR_VALUE = 100;

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
Function CheckFile(Path: String; Var Arr: TArray): Boolean;
Var
    I, Buf, Length: Integer;
    IsFileCorrect: Boolean;
    InputFile: TextFile;

Begin
    IsFileCorrect := True;

    If FileExists(Path) Then
    Begin
        AssignFile(InputFile, Path);
        Try
            Reset(InputFile);
        Except
            Writeln('Не удалось открыть файл');
            IsFileCorrect := False;
        End;

        If IsFileCorrect Then
        Begin
            Try
                Read(InputFile, Length);
            Except
                Writeln('Длина массива введена некорректно!');
                IsFileCorrect := False;
            End;

            If Not Eoln(InputFile) Or EoF(InputFile) Then
            Begin
                Writeln('В первой строке должна содержаться длина массива, во второй строке - все его элементы!');
                IsFileCorrect := False;
            End;

            If IsFileCorrect And (Length < MIN_ARR_LENGTH) Or (Length > MAX_ARR_LENGTH) Then
            Begin
                Writeln('Введена длина массива, не входящая в диапазон допустимых значений!');
                IsFileCorrect := False;
            End;

            SetLength(Arr, Length);
            I := 0;

            While (IsFileCorrect And (I < Length)) Do
            Begin
                Try
                    Read(InputFile, Buf);
                Except
                    Writeln('Элементы массива введены некорректно!');
                    IsFileCorrect := False;
                End;

                If IsFileCorrect And Eoln(InputFile) And Not (I = High(Arr)) Then
                Begin
                    Writeln('Все элементы массива должны быть записаны во второй строке!');
                    IsFileCorrect := False;
                End;
                
                If IsFileCorrect And (Buf < MIN_ARR_VALUE) Or (Buf > MAX_ARR_VALUE) Then
                Begin
                    Writeln('Элементы массива не входят в диапазон допустимых значений!');
                    IsFileCorrect := False;
                End;

                Arr[I] := Buf;
                Inc(I);
            End;

            If IsFileCorrect And Not EoF(InputFile) Then
            Begin
                Writeln('Данные в файле представлены в неправильном формате!');
                IsFileCorrect := False;
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

Procedure InputDataFromConsole(Var Arr: TArray);
Var
    ArrayLength, I, Buf: Integer;
Begin
    Writeln('Введите количесво элементов массива от ', MIN_ARR_LENGTH, ' до ', MAX_ARR_LENGTH, ': ');
    ArrayLength := ReadNum(MIN_ARR_LENGTH, MAX_ARR_LENGTH);

    SetLength(Arr, ArrayLength);

    Writeln('Введите элементы массива', #10, 'Каждый элемент массива - натуральное число от ',   MIN_ARR_VALUE, ' до ', MAX_ARR_VALUE);
    For I := 0 To High(Arr) Do
    Begin
        Write('Введите элемент ', I + 1, ': ');
        Buf := ReadNum(MIN_ARR_VALUE, MAX_ARR_VALUE);
        Arr[I] := Buf;
    End;
End;

 Procedure InputDataFromFile(Var Arr: TArray);
Var
    PathFile: String;
    IsInputFromFileSuccessfully: Boolean;
Begin
Writeln('Данные в файле должны содержать:', #10, 'Натуральное число - количество элементов массива от ', MIN_ARR_LENGTH, ' до ', MAX_ARR_LENGTH, #10, 'Элементы массива, записанные через пробел, допустимые значения для которых от ', MIN_ARR_VALUE, ' до ', MAX_ARR_VALUE);
        Repeat
            Write('Введите путь к файлу с его раширением: ');
            Readln(PathFile);
            IsInputFromFileSuccessfully := CheckFile(PathFile, Arr);
        Until IsInputFromFileSuccessfully;
End;


Procedure InputData(Var Arr: TArray);
Var
    Choice: Integer;
Begin
    Write('Выберите вариант ввода:', #10, '1. Ввод из консоли', #10, '2. Ввод из файла', #10, 'Использовать вариант: ');
    Choice := ReadNum(1,2);

    If Choice = 1 Then
        InputDataFromConsole(Arr)
    Else
        InputDataFromFile(Arr);
End;

Procedure OutputDataToConsole(Count: Integer);
Begin
    If Count = 0 Then
        Writeln('Среди элементов массива нет простых чисел')
    Else
        Writeln('Число простых чисел среди элементов массива: ', Count);
End;

Procedure OutputDataToFile(Count: Integer);
Var
    IsPathCorrect: Boolean;
    Path: String;
    OutputFile: TextFile;
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

        If Count = 0 Then
            Writeln(OutputFile, 'Среди элементов массива нет простых чисел')
        Else
            Writeln(OutputFile, 'Число простых чисел среди элементов массива: ', Count);
        CloseFile(OutputFile);
        Writeln('Вывод данных...  успешно!');
End;


Procedure OutputData(Count: Integer);
Var
    Choice: Integer;
Begin
    Write('Выберите вариант вывода:', #10, '1. Вывод в консоль', #10, '2. Вывод файл', #10, 'Использовать вариант: ');
    Choice := ReadNum(1,2);

    If Choice = 1 Then
        OutputDataToConsole(Count)
    Else
        OutputDataToFile(Count);
End;

Function CheckNumber(Num: Integer): Boolean;
Var
    I: Integer;
    NumRoot: Real;
Begin
    NumRoot := Sqrt(Num);
    I := 1;
    Repeat
        Inc(I);
    Until ((Num Mod I = 0) Or (I > NumRoot));

    CheckNumber := (I > NumRoot);
    If Num = 1 Then
        CheckNumber := False;
End;

Function GetСountOfPrimeNumbers(Var Arr: TArray): Integer;
Var
    I, Count: Integer;
    IsPrimeNumber: Boolean;
Begin
    Count := 0;

    For I := 0 To High(Arr) Do
    Begin
        IsPrimeNumber := CheckNumber(Arr[I]);
        If IsPrimeNumber Then
            Inc(Count);
    End;
    GetСountOfPrimeNumbers := Count;
End;

Begin
    Writeln('Данная программа вычислит количество простых чисел в массиве');
    InputData(ArrA);
    CountOfPrimeNumbers := GetСountOfPrimeNumbers(ArrA);
    OutputData(CountOfPrimeNumbers);
    Readln;
End.
