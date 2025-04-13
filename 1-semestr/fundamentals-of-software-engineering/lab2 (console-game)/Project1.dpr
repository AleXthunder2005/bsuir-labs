program Project1;
uses
  SysUtils,
  Windows;

Type
  TLetterCount = array ['�'..'�'] of Integer;
  PascalStr = String[255];

const
  WordsCount = 5;
  InitialWords: array [0..(WordsCount - 1)] of string = ('�������', '������','�������', '����������','�������');
Var
  MainWord, InputData, Word: PascalStr;
  Propusk, CurrPlayer, PlayersCount, Error, I: Integer;
  Total_Score: array of Integer;
  Entered_Words: array of string;
  CountLetterInMainWord: TLetterCount;
  {
    MainWord - �����, �� ���� �������� �� ���������� �����
    InputData - ��� ����� ���-�� ������� � Val
    Word - ������������ ������� �����
    Propusk - ���������� ������������ ������ ��� �������
    CurrPlayer - ����� �������� ������
    PlayerCounts - ���������� �������
    Error - ������ ��� ����� ���������� ������� (���������� ��� Val)
    I - ���������� ������������� ��� ����� for
    Total_Score - ������ ����� ������� �� �������
    Entered_Words - ��������� �������������� �����
    CountLetterInMainWord - ���������� ������ ����� � ������� �����
  }
// ������� ��� �������� �������������� �����
Function CorrCheck(Checking_Word: PascalStr; Main_Word: TLetterCount): Integer;
var
  Flag: boolean; // ���������� ������������ ���������� �����
  MinusPoints: Integer; // ���������� ���������� �����
begin
  MinusPoints := 0;
  Flag := True;

  // ����� ��� �������� ������������ �����
  for I := 0 to Length(Entered_Words) - 1 do
    if Entered_Words[I] = Checking_Word then
      Flag := false;

  if Flag then
  begin
    // Main_Word ������ ���������� ������ ����� � ��������� �����. ����� ��
    // ���������� �����-�� �����, �� ��������, ��������������� �� � �������� �����������.
    // ���� ��������������� ������� �������� ����� ���� ��� �� ������ � �������� ���������� ��������,
    // �� ���������� ���������� ����� �������������
    for I := 1 to Length(Checking_Word) do
      if (Checking_Word[I] >= '�') and (Checking_Word[I] <= '�') then
        if (Main_Word[AnsiChar(Checking_Word[I])] > 0) then
          Dec(Main_Word[AnsiChar(Checking_Word[I])])
        else
          Dec(MinusPoints)
      else
        Dec(MinusPoints);
    // ���� ���-�� ���������� ����� ����, �� ���������� ����� �����
    if MinusPoints = 0 then
      result := Length(Checking_Word)
    // � ��������� ������ ���������� ���-�� ���������� �����
    else
      result := MinusPoints;

    // ���������� ���������� ����� � ������
    SetLength(Entered_Words, Length(Entered_Words) + 1);
    Entered_Words[Length(Entered_Words) - 1] := Checking_Word;
  end
  // ���� ��������� ����� ����������� �� �������� ��� �����
  else
    result := -Length(Checking_Word);
end;

// ��������� �������� �����
Procedure Scoring_Points(Str: String; Current_Player: Integer; Main_Word: TLetterCount);
Var
  AdditionalPoints: Integer; // ��������, ������� ��� ������� ������� CorrCheck
begin

  // �������� �� ������� ���� ������
  If Str = '' then
  begin
    Inc(Propusk);
    Writeln('������� ����.');
  end

  Else
  begin
    AdditionalPoints := CorrCheck(Str, Main_Word);

    // ����� � ��������� ���������� ����� ������
    if AdditionalPoints < 0 then
      WriteLn('������������ ����. ��� ��������� ���������� �����, ������: ', -AdditionalPoints)
    else
      WriteLn('��� ����������� ���������� �����, ������: ', AdditionalPoints);

    // ��������� ���������� ����� ������; ��������� ���������� �������, ������������ ���:
    // ����� ������� ����� ������
    Total_Score[Current_Player - 1] := Total_Score[Current_Player - 1] + AdditionalPoints;
    Propusk := 0;
    Writeln('������� ���������� ����� ', Current_Player, '-�� ������: ',
      Total_Score[Current_Player - 1]);
  end;
end;


begin
  SetConsoleCp(1251);
  SetConsoleOutPutCp(1251);
  // ��������� ���������� ����� � ��� �����
  Randomize;
  MainWord := InitialWords[Random(WordsCount)];
  Writeln(MainWord);

  // ������� ���������� ���� � �����
  for i := 1 to Length(MainWord) do
    Inc(CountLetterInMainWord[MainWord[i]]);

  // ���� ���������� �������
  repeat
    Write('������� ���������� ������� �� 2 �� 4: ');
    Readln(InputData);
    Val(InputData, PlayersCount, Error);
    // �������� ��������� ������
    if (PlayersCount < 2) or (PlayersCount > 4) or (Error <> 0) then
    begin
      Writeln('������� ������������ ���������� �������. ��������� ���� �������.');
      Error := 1;
    end;
  until Error = 0;
  // ��������� ��������� �������� ����� �������
  SetLength(Total_Score, PlayersCount);
  for i := 0 to PlayersCount - 1 do
    Total_Score[i] := 0;

  CurrPlayer := 1;
  // ����������� ���� ���� ���������� ��������� ������ ������ ���-�� �������
  while (Propusk < PlayersCount) do
  begin
    Writeln;
    Writeln('��� ',CurrPlayer,'-�� ������.');
    // ���� �����
    Write('������� ������������ �����: ');
    Readln(Word);
    Word := Trim(Word);
    // UpperCase ��� ���������� �����
    for I := 1 to Length(Word) do
      if Word[i] > '�' then
        Word[i] := AnsiChar(Ord(Word[i]) - 32);

    // ����� ��������� ��� �������� �����
    Scoring_Points (Word, CurrPlayer, CountLetterInMainWord);

    // ��������� ������ ������
    if(CurrPlayer = PlayersCount) then
      CurrPlayer := 1
    else
      Inc(CurrPlayer);
  end;

  Writeln('���� ��������.');
  Readln;
end.
