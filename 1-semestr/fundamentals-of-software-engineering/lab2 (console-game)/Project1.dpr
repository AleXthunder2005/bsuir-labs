program Project1;
uses
  SysUtils,
  Windows;

Type
  TLetterCount = array ['А'..'Я'] of Integer;
  PascalStr = String[255];

const
  WordsCount = 5;
  InitialWords: array [0..(WordsCount - 1)] of string = ('АЛЭФЫЛП', 'ФДЫЖАФ','ОАЛДДАЛ', 'ЦТКЛТДЛЙЦТ','ЫТЫТПЛД');
Var
  MainWord, InputData, Word: PascalStr;
  Propusk, CurrPlayer, PlayersCount, Error, I: Integer;
  Total_Score: array of Integer;
  Entered_Words: array of string;
  CountLetterInMainWord: TLetterCount;
  {
    MainWord - слово, из букв которого мы составляем слова
    InputData - для ввода кол-ва игроков в Val
    Word - составленное игроком слово
    Propusk - количество пропустивших подряд ход игроков
    CurrPlayer - номер текущего игрока
    PlayerCounts - количество игроков
    Error - ошибка при вводе количества игроков (переменная для Val)
    I - переменная исключительно для цикла for
    Total_Score - массив очков каждого из игроков
    Entered_Words - введенные пользователями слова
    CountLetterInMainWord - Количество каждой буквы в главном слове
  }
// Функция для подсчета дополнительных очков
Function CorrCheck(Checking_Word: PascalStr; Main_Word: TLetterCount): Integer;
var
  Flag: boolean; // показатель уникальности введенного слова
  MinusPoints: Integer; // количество отнимаемых очков
begin
  MinusPoints := 0;
  Flag := True;

  // цикла для проверки уникальности слова
  for I := 0 to Length(Entered_Words) - 1 do
    if Entered_Words[I] = Checking_Word then
      Flag := false;

  if Flag then
  begin
    // Main_Word хранит количества каждой буквы в начальном слове. Когда мы
    // используем какую-то букву, то значение, соответствующее ей в масссиве уменьшается.
    // Если соответствующее символу значение равно нулю или не входит в диапазон допустимых символов,
    // то количество вычитаемых очков увеличивается
    for I := 1 to Length(Checking_Word) do
      if (Checking_Word[I] >= 'А') and (Checking_Word[I] <= 'Я') then
        if (Main_Word[AnsiChar(Checking_Word[I])] > 0) then
          Dec(Main_Word[AnsiChar(Checking_Word[I])])
        else
          Dec(MinusPoints)
      else
        Dec(MinusPoints);
    // Если кол-во вычитаемых равно нулю, то возвращаем длину слова
    if MinusPoints = 0 then
      result := Length(Checking_Word)
    // В противном случае возвращаем кол-во вычитаемых очков
    else
      result := MinusPoints;

    // добавление введенного слова в память
    SetLength(Entered_Words, Length(Entered_Words) + 1);
    Entered_Words[Length(Entered_Words) - 1] := Checking_Word;
  end
  // если введенное слово неуникально то вычитаем его длину
  else
    result := -Length(Checking_Word);
end;

// процедура подсчета очков
Procedure Scoring_Points(Str: String; Current_Player: Integer; Main_Word: TLetterCount);
Var
  AdditionalPoints: Integer; // значение, которое нам вернула функция CorrCheck
begin

  // Проверка на пропуск хода игрока
  If Str = '' then
  begin
    Inc(Propusk);
    Writeln('Пропуск хода.');
  end

  Else
  begin
    AdditionalPoints := CorrCheck(Str, Main_Word);

    // Вывод о изменении количества очков игрока
    if AdditionalPoints < 0 then
      WriteLn('Неправильный ввод. Вам снимается количество очков, равное: ', -AdditionalPoints)
    else
      WriteLn('Вам добавляется количество очков, равное: ', AdditionalPoints);

    // Изменение количества очков игрока; обнуление количества игроков, пропустивших ход:
    // Вывод текущих очков игрока
    Total_Score[Current_Player - 1] := Total_Score[Current_Player - 1] + AdditionalPoints;
    Propusk := 0;
    Writeln('Текущее количество очков ', Current_Player, '-го игрока: ',
      Total_Score[Current_Player - 1]);
  end;
end;


begin
  SetConsoleCp(1251);
  SetConsoleOutPutCp(1251);
  // Генерация случайного слова и его вывод
  Randomize;
  MainWord := InitialWords[Random(WordsCount)];
  Writeln(MainWord);

  // Подсчет количества букв в слове
  for i := 1 to Length(MainWord) do
    Inc(CountLetterInMainWord[MainWord[i]]);

  // ввод количества игроков
  repeat
    Write('Введите количество игроков от 2 до 4: ');
    Readln(InputData);
    Val(InputData, PlayersCount, Error);
    // проверка введенных данных
    if (PlayersCount < 2) or (PlayersCount > 4) or (Error <> 0) then
    begin
      Writeln('Введено недопустимое количество игроков. Повторите свою попытку.');
      Error := 1;
    end;
  until Error = 0;
  // зануление начальных значений очков игроков
  SetLength(Total_Score, PlayersCount);
  for i := 0 to PlayersCount - 1 do
    Total_Score[i] := 0;

  CurrPlayer := 1;
  // продолжение игры пока количества пропусков подряд меньше кол-ва игроков
  while (Propusk < PlayersCount) do
  begin
    Writeln;
    Writeln('Ход ',CurrPlayer,'-го игрока.');
    // ввод слова
    Write('Введите составленное слово: ');
    Readln(Word);
    Word := Trim(Word);
    // UpperCase для введенного слова
    for I := 1 to Length(Word) do
      if Word[i] > 'Я' then
        Word[i] := AnsiChar(Ord(Word[i]) - 32);

    // вызов процедуры для подсчета очков
    Scoring_Points (Word, CurrPlayer, CountLetterInMainWord);

    // изменение номера игрока
    if(CurrPlayer = PlayersCount) then
      CurrPlayer := 1
    else
      Inc(CurrPlayer);
  end;

  Writeln('Игра окончена.');
  Readln;
end.
