Program Lab3_1;

Uses
    System.SysUtils;
Var
    TextIn, NewText: String;

Procedure PrintCondition();
Begin
    Writeln('Данная программа выведет каждое нечетное слово в кавычках, а каждое четное - в квадратных скобках');
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

Function GetLastSymbIndex(Text: String): Integer;
Var
    I: Integer;
    C: Char;
Begin
    I := High(Text);
    Repeat
        Dec(I);
        C := Text[I];
    Until (C <> #32);
    GetLastSymbIndex := I;
End;

Function GetNextSpaceIndex(Text: String; SpaceIndex: Integer): Integer;
Var
    I: Integer;
    C: Char;
Begin
    I := SpaceIndex;
    Repeat
        Inc(I);
        C := Text[I];
    Until (C = #32);
    GetNextSpaceIndex := I;
End;

Function GetNewWord(Text: String; Var SpaceIndex: Integer; NumWord: Integer): String;
Var
    I, NextSpaceIndex: Integer;
    Word: String;
    BeginSym, EndSym: Char;
Begin
    Repeat
        NextSpaceIndex := GetNextSpaceIndex(Text, SpaceIndex);
        Inc(SpaceIndex);
    Until NextSpaceIndex - SpaceIndex > 0;

    I := SpaceIndex;

    If NumWord Mod 2 = 1 Then
    Begin
        BeginSym := '"';
        EndSym := '"';
    End
    Else
    Begin
        BeginSym := '[';
        EndSym := ']';
    End;

    Word := BeginSym;
    Repeat
        Word := Word + Text[I];
        Inc(I);
    Until (I = NextSpaceIndex);
    Word := Word + EndSym;

    SpaceIndex := NextSpaceIndex;

    GetNewWord := Word;
End;

Function GetNewText(Text: String): String;
Var
    SpaceIndex, NumWord, LastSpaceIndex: Integer;
    NewWord, NewText: String;
Begin
    NumWord := 1;
    SpaceIndex := 0;
    LastSpaceIndex := GetLastSymbIndex(Text) + 1;

    Repeat
        NewWord := GetNewWord(Text, SpaceIndex, NumWord);
        NewText := NewText + NewWord + ' ';
        Inc(NumWord);
    Until SpaceIndex = LastSpaceIndex;

    GetNewText := NewText;
End;

Function CheckFile(Path: String): Boolean;
Var
    CheckText, BufText: String;
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
                Readln(InputFile, BufText);
                CheckText := CheckText + BufText + ' ';
            Until Eof(InputFile);

            If (High(CheckText) = 0) Or (GetLastSymbIndex(CheckText) = 0) Then
            Begin
                Writeln('Файл пустой!');
                IsFileCorrect := False;
            End;
            Close(InputFile);
        End;
    End
    Else
    Begin
        Writeln('Файла по данному пути не существует!');
        IsFileCorrect := False;
    End;

    CheckFile := IsFileCorrect;
End;

Function ReadFile(Path: String): String;
Var
    Text, BufText: String;
    InputFile: TextFile;
Begin
    AssignFile(InputFile, Path);
    Reset(InputFile);

    Repeat
        Readln(InputFile, BufText);
        Text := Text + BufText + ' ';
    Until Eof(InputFile);
    Close(InputFile);

    ReadFile := Text;
End;

Function InputTextFromFile(): String;
Var
    PathFile, Text: String;
    IsInputFromFileSuccessfully: Boolean;
Begin
Writeln('Данные в файле должны содержать текст');
    Repeat
        Write('Введите путь к файлу с его раширением: ');
        Readln(PathFile);
        IsInputFromFileSuccessfully := CheckFile(PathFile);
    Until IsInputFromFileSuccessfully;
    Text := ReadFile(PathFile);
    Text := Text + ' ';

    InputTextFromFile := Text;
End;

Function InputTextFromConsole(): String;
Var
    Text: String;
    IsTextEmpty: Boolean;
Begin
    Repeat
        Writeln('Введите текст:');
        Readln(Text);
        Text := Text + ' ';
        IsTextEmpty := (High(Text) = 0) Or (GetLastSymbIndex(Text) = 0);
    Until Not IsTextEmpty;

    InputTextFromConsole := Text;
End;

Function InputText(): String;
Var
    Choice: Integer;
    Text: String;
Begin
    Write('Выберите вариант ввода:', #10, '1. Ввод из консоли', #10, '2. Ввод из файла', #10, 'Использовать вариант: ');
    Choice := ReadNum(1,2);

    If Choice = 1 Then
        Text := InputTextFromConsole()
    Else
        Text := InputTextFromFile();

    InputText := Text;
End;

Procedure OutputTextToConsole(Text: String);
Begin
    Writeln(Text);
End;

Procedure OutputTextToFile(Text: String);
Var
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

    Writeln(OutputFile, Text);
    CloseFile(OutputFile);
    Writeln('Вывод данных...  успешно!');
End;


Procedure OutputText(Text: String);
Var
    Choice: Integer;
Begin
    Write('Выберите вариант вывода:', #10, '1. Вывод в консоль', #10, '2. Вывод файл', #10, 'Использовать вариант: ');
    Choice := ReadNum(1,2);

    If Choice = 1 Then
        OutputTextToConsole(Text)
    Else
        OutputTextToFile(Text);
End;


Begin
    PrintCondition();
    TextIn := InputText();
    NewText := GetNewText(TextIn);
    OutputText(NewText);
    Readln;
End.
