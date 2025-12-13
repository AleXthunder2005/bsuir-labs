Program Lab3_2;

Uses
    System.SysUtils;

Type
    TSet = Set Of Char;
Var
    StrIn: AnsiString;
    AnswerSet: TSet;

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

Function GetLastNotSpaceIndex(Line: String): Integer;
Var
    I: Integer;
    C: Char;
Begin
    I := High(Line);
    Repeat
        Dec(I);
        C := Line[I];
    Until (C <> #32);
    GetLastNotSpaceIndex := I;
End;

Function CheckFile(Path: String): Boolean;
Var
    CheckLine, BufLine: String;
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
            Repeat
                Readln(InputFile, BufLine);
                CheckLine := CheckLine + BufLine;
            Until Eof(InputFile);

            If (CheckLine = '') Or (GetLastNotSpaceIndex(CheckLine) = 0) Then
            Begin
                Writeln('Файл пустой!');
                IsFileCorrect := False;
            End;
            Close(InputFile)
        End;
    End
    Else
    Begin
        Writeln('Файла по данному пути не существует!');
        IsFileCorrect := False;
    End;

    CheckFile := IsFileCorrect;
End;

Function ReadFile(Path: String): AnsiString;
Var
    Line, BufLine: AnsiString;
    InputFile: TextFile;
Begin
    AssignFile(InputFile, Path);
    Reset(InputFile);

    Repeat
        Readln(InputFile, BufLine);
        Line := Line + BufLine;
    Until Eof(InputFile);
    Close(InputFile);

    ReadFile := Line;
End;

Function InputStrFromFile(): AnsiString;
Var
    PathFile, Line: AnsiString;
    IsInputFromFileSuccessfully: Boolean;
Begin
Writeln('Данные в файле должны содержать текст');
    Repeat
        Write('Введите путь к файлу с его раширением: ');
        Readln(PathFile);
        IsInputFromFileSuccessfully := CheckFile(PathFile);
    Until IsInputFromFileSuccessfully;
    Line := ReadFile(PathFile);

    InputStrFromFile := Line;
End;

Function InputStrFromConsole(): AnsiString;
Var
    Line: AnsiString;
    IsTextEmpty: Boolean;
Begin
    Repeat
        Writeln('Введите текст:');
        Readln(Line);
        IsTextEmpty := (Line = '') Or (GetLastNotSpaceIndex(Line) = 0);
    Until Not IsTextEmpty;

    InputStrFromConsole := Line;
End;

Function InputStr(): AnsiString;
Var
    Choice: Integer;
    Line: AnsiString;
Begin
    Write('Выберите вариант ввода:', #10, '1. Ввод из консоли', #10, '2. Ввод из файла', #10, 'Использовать вариант: ');
    Choice := ReadNum(1,2);

    If Choice = 1 Then
        Line := InputStrFromConsole()
    Else
        Line := InputStrFromFile();

    InputStr := Line;
End;

Function FindSymbols(Line: AnsiString): TSet;
Var
    I: Integer;
    AnswerSet: TSet;
Const
    SearchCharacters = ['+', '-', '/', '*', '0'..'9'];
Begin
    AnswerSet := [];
    For I := 1 To Length(Line) Do
        If Line[I] In SearchCharacters Then
            Include(AnswerSet, Line[I]);

    FindSymbols:= AnswerSet;
End;

Procedure OutputAnswerToConsole(Answer: TSet);
Var
    С: Char;
Begin
    If Answer <> [] Then
    Begin
        For С := '*' To '9' Do
            If С In Answer Then
                Write(С, ' ');
    End
    Else
        Writeln('В строке не было найдено нужных символов');
End;

Procedure OutputAnswerToFile(Answer: TSet);
Var
    С: Char;
    IsPathCorrect: Boolean;
    Path: String;
    OutputFile: TextFile;
Begin
    Writeln('Для вывода введите путь к файлу и его имя c расширением. Если файл отсутствует то он будет создан автоматически по указанному пути или в корневой папке программы (по умолчанию)');
    Repeat
        IsPathCorrect := True;
        Write('Введите путь: ');
        Readln(Path);
        If Path = '' Then
            IsPathCorrect := False
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

    If Answer <> [] Then
    Begin
        For С := '*' To '9' Do
            If С In Answer Then
                Write(OutputFile, С, ' ');
    End
    Else
        Writeln(OutputFile, 'В строке не было найдено нужных символов');

    CloseFile(OutputFile);
    Writeln('Вывод данных...  успешно!');
End;

Procedure OutputAnswer(Answer: TSet);
Var
    Choice: Integer;
Begin
    Write('Выберите вариант вывода:', #10, '1. Вывод в консоль', #10, '2. Вывод файл', #10, 'Использовать вариант: ');
    Choice := ReadNum(1,2);

    If Choice = 1 Then
        OutputAnswerToConsole(Answer)
    Else
        OutputAnswerToFile(Answer);
End;

Procedure PrintCondition();
Begin
    Writeln('Данная программа напечатает множество всех встречающихся в строке знаков арифметических операций и цифр');
End;

Begin
    PrintCondition();
    StrIn := InputStr();
    AnswerSet := FindSymbols(StrIn);
    OutputAnswer(AnswerSet);
    Readln;
End.
