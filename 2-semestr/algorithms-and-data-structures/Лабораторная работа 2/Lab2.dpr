program Lab2;

uses
    System.SysUtils;

const
    SegmentCount = 10;

type
    PPages = ^PagesListElem;
    PagesListElem = record
        PageValue: Word;
        NextPage: PPages;
    end;

    PTerm = ^TermListElem;
    TermListElem = record
        TermValue: String;
        Subterm: PTerm;
        Pages: PPages;
        NextTerm: PTerm;
    end;

    PHeader = ^PSegmentListHeader;
    PSegmentListHeader = record
        FirstTerm: PTerm;
    end;

    THashTable = array [0..SegmentCount-1] of PHeader;

var
    Choice: Integer;
    NewTerm: PTerm;
    //Header: PHeader;
    TermName: String;
    HashTable: THashTable;



procedure OutputMainMenu;
begin
    Writeln('--------------------------------------------------------');
    Writeln('1. Просмотреть предметный указатель');
    Writeln('2. Добавить термин');
    Writeln('3. Редактировать термин');
    Writeln('4. Удалить термин');
    Writeln('5. Поиск терминов по подтермину');
    Writeln('6. Поиск подтермина по термину');
    Writeln('7. Отсортировать термины по алфавиту');
    Writeln('8. Отсортировать термины по номерам страниц');
    Writeln('9. Выход');
    Writeln('--------------------------------------------------------');
    Writeln('Выберите желаемое действие:');
end;

procedure OutputEditTermMenu;
begin
    Writeln('--------------------------------------------------------');
    Writeln('1. Добавить подтермин');
    Writeln('2. Редактировать подтермин');
    Writeln('3. Удалить подтермин');
    Writeln('4. Добавить номер страницы');
    Writeln('5. Удалить номер страницы');
    Writeln('6. Завершить');
    Writeln('--------------------------------------------------------');
    Writeln('Выберите желаемое действие:');
end;

function InputChoice(Min, Max: Integer): Integer;
var
    Num: Integer;
    IsCorrect: Boolean;
begin
    repeat
        IsCorrect := True;
        try
            Readln(Num);
        except
            Writeln('Некорректный ввод! Попробуйте еще:');
            IsCorrect := False;
        end;
        if IsCorrect and ((Num < Min) or (Num > Max)) then
        begin
            Writeln('Некорректный ввод! Попробуйте еще:');
            IsCorrect := False;
        end;
    until IsCorrect;
    InputChoice := Num;
end;

function HasTermListThisTerm (Header: PHeader; NewTermValue: String): Boolean;
var
    HasThisTerm: Boolean;
    Head: PTerm;
begin
    HasThisTerm := False;
    if Header^.FirstTerm <> nil then
    begin
        Head := Header^.FirstTerm;
        repeat
            if Head^.TermValue = NewTermValue then
            begin
                HasThisTerm := True;
                Break;
            end;
            Head := Head^.NextTerm;
        until Head = nil;

        if HasThisTerm then
            Writeln('Такой термин уже существует');
    end;

    HasTermListThisTerm := HasThisTerm;
end;

function HasThisTerm(HashTable: THashTable; NewTermValue: String);
var
    HasTerm: Boolean;
    I: Integer;
begin
    HasTerm := False;
    I := 0;
    repeat
        HasTerm := HasTermListThisTerm (HashTable[I], NewTermValue);
        Inc(I);
    until HasTerm and (I = SegmentCount);
    HasThisTerm := HasTerm;
end;

procedure AddTerm(Header: PHeader; Term: PTerm);
var
    Head: PTerm;
begin
    if Header^.FirstTerm <> nil then
    begin
        Head := Header^.FirstTerm;
        while Head^.NextTerm <> nil do
            Head := Head^.NextTerm;
        Head^.NextTerm := Term;
    end
    else
        Header^.FirstTerm := Term;
    
    Writeln('Термин добавлен успешно!');
end;

function HasSubtermListThisSubterm(Term: PTerm; NewSubtermValue: String): Boolean;
var
    Curr: PTerm;
    HasThisSubterm: Boolean;
begin
    HasThisSubterm := False;
    Curr := Term^.Subterm;
    if Curr <> nil then
    begin
        repeat
            if Curr^.TermValue = NewSubtermValue then
            begin
                HasThisSubterm := True;
                Break;
            end;
            Curr := Curr^.NextTerm;
        until Curr = nil;
    end;

    HasSubtermListThisSubterm := HasThisSubterm;
end;

function CreateSubterm(Value: String): PTerm;
var
    NewSubterm: PTerm;
begin
    New(NewSubterm);
    NewSubterm^.TermValue := Value;
    NewSubterm^.Subterm := nil;
    NewSubterm^.Pages := nil;
    NewSubterm^.NextTerm := nil;

    CreateSubterm := NewSubterm;
end;

function CreatePage(PageValue: Word): PPages;
var
    Page: PPages;
begin
    New(Page);
    Page^.PageValue := PageValue;
    Page^.NextPage := nil;   

    CreatePage := Page;
end;

procedure AddPage(NewTerm: PTerm);
var
    Page: Word;        
    Curr, Temp: PPages;
begin
    Writeln('Введите страницу с термином:');
    Page := InputChoice(0, 65000);

    if NewTerm^.Pages = nil then
    begin
        NewTerm^.Pages := CreatePage(Page);
        Writeln('Страница добавлена успешно!');
    end
    else
    begin
        Curr := NewTerm^.Pages;
        if Page <= Curr^.PageValue then
        begin
            if Curr^.PageValue = Page then
            begin
                Writeln('Такая страница уже указана!');
                Exit;
            end
            else
            begin
                NewTerm^.Pages^.NextPage := CreatePage(NewTerm^.Pages^.PageValue);
                NewTerm^.Pages^.PageValue := Page;
            end;
        end
        else
        begin
            while (Curr^.NextPage <> nil) and (Curr^.NextPage^.PageValue < Page) do
            begin
                if Curr^.NextPage^.PageValue = Page then
                begin
                    Writeln('Такая страница уже указана!');
                    Exit;
                end;
                Curr := Curr^.NextPage;
            end;

            if Curr^.NextPage = nil then
                Curr^.NextPage := CreatePage(Page)
            else
            begin    
                Temp := CreatePage(Page);
                Temp^.NextPage := Curr^.NextPage;
                Curr^.NextPage := Temp;
            end;
        end;
        Writeln('Страница добавлена успешно!');
    end;
end;

procedure DeletePage(NewTerm: PTerm);
var
    Page: Word;
    Curr, Temp: PPages;
begin
    Writeln('Введите страницу с термином:');
    Page := InputChoice(0, 65000);

    if NewTerm^.Pages = nil then
    begin
        Writeln('Термин не указан ни на одной из страниц!');
        Exit;
    end
    else
    begin
        Curr := NewTerm^.Pages;
        if Curr^.PageValue = Page then
        begin
            NewTerm^.Pages := Curr^.NextPage;
            Dispose(Curr);
            Writeln('Удаление страницы успешно!');
        end
        else
        begin
            while (Curr^.NextPage <> nil) and (Curr^.NextPage^.PageValue <> Page) do
                Curr := Curr^.NextPage;

            if (Curr^.NextPage <> nil) and (Curr^.NextPage^.PageValue = Page) then
            begin
                Temp := Curr^.NextPage;
                Curr^.NextPage := Temp^.NextPage;
                Dispose(Temp);
                Writeln('Удаление страницы успешно!');
            end
            else
            begin
                Writeln('Термин не найден на данной странице!');
            end;
        end;
    end;
end;
      
function CreateNewTerm(Value: String): PTerm;
var
    NewTerm: PTerm;
begin
    New(NewTerm);
    NewTerm^.TermValue := Value;
    NewTerm^.Subterm := nil;
    NewTerm^.Pages := nil;
    NewTerm^.NextTerm := nil;

    CreateNewTerm := NewTerm;
end;

procedure OutputSubterm(Subterm: PTerm; Padding: String);
var
    Page: PPages;
begin
    if Subterm = nil then
        Exit
    else
    begin
        Write(Padding + Subterm^.TermValue + '| ');
        Page := Subterm^.Pages;
        while Page <> nil do
        begin
            Write(Page^.PageValue, ' ');
            Page := Page^.NextPage;
        end;
        Writeln;
        OutputSubterm(Subterm^.Subterm, Padding + '    ');
    end;
end;

procedure OutputSegmentList(Header: PHeader);
var
    Term, Subterm: PTerm;
    Page: PPages;
begin
    if Header^.FirstTerm = nil then
        Writeln('Предметный указатель не заполнен!')
    else
    begin
        Writeln('ПРЕДМЕТНЫЙ УКАЗАТЕЛЬ');
        Term := Header^.FirstTerm;
        repeat
            Writeln('----------------------------');
            Write(Term^.TermValue + '| ');
            Page := Term^.Pages;
            while Page <> nil do
            begin
                Write(Page^.PageValue, ' ');
                Page := Page^.NextPage;
            end;
            if (Term^.Subterm <> nil) then
            begin
                Writeln;
                Subterm := Term^.Subterm;
                repeat
                    OutputSubterm(Subterm, '    ');
                    Subterm := Subterm^.NextTerm;
                until Subterm = nil;
            end
            else
                Writeln;
            Writeln('----------------------------');
            Term := Term^.NextTerm;
        until Term = nil;
    end;
end;

procedure DeleteSubterm(NewTerm: PTerm);
var
    Curr, Temp: PTerm;
    DelSubtermValue: String;
begin
    Writeln('Введите подтермин: ');
    Readln(DelSubtermValue);
    if HasSubtermListThisSubterm(NewTerm, DelSubtermValue) then
    begin
        Curr := NewTerm^.Subterm;
        if Curr^.TermValue = DelSubtermValue then
        begin
            Temp := Curr;
            NewTerm^.Subterm := Curr^.NextTerm;
            Dispose(Temp);
        end
        else
        begin
            Temp := Curr^.NextTerm;
            while Temp^.TermValue <> DelSubtermValue do
            begin
                Curr := Temp;
                Temp := Temp^.NextTerm;
            end;

            Curr^.NextTerm := Temp^.NextTerm;
            Dispose(Temp);
        end;
        Writeln('Подтермин удален успешно!')
    end
    else
        Writeln('Подтермин не найден!');    
end;

procedure AddSubterm(NewTerm: PTerm);forward;

procedure EditSubterm(NewTerm: PTerm);
var
    SubtermValue: String;
    NowSubterm: PTerm;
    Choice:Integer;
begin
    if NewTerm^.Subterm = nil then
    begin
        Writeln('У данного термина еще нет подтерминов!');
        Exit;
    end
    else
    begin
        Writeln('Введите поддтермин');
        Readln(SubtermValue);
        if HasSubtermListThisSubterm(NewTerm, SubtermValue) then
        begin
            if (NewTerm^.Subterm^.TermValue = SubtermValue) then
            begin
                NowSubterm := NewTerm^.Subterm;   
            end
            else
            begin
                NowSubterm := NewTerm^.Subterm;
                while (NowSubterm^.NextTerm <> nil) and (NowSubterm^.NextTerm^.TermValue <> SubtermValue) do
                    NowSubterm := NowSubterm^.NextTerm;

                NowSubterm := NowSubterm^.NextTerm;
            end;

            repeat
                Writeln('--------------------------------------------------------');
                Writeln('РЕДАКТОР ПОДТЕРМИНА ' + SubtermValue);
                OutputEditTermMenu;
                Choice := InputChoice(1,6);
                case Choice of
                    1: AddSubterm(NowSubterm);
                    2: EditSubterm(NowSubterm);
                    3: DeleteSubterm(NowSubterm);
                    4: AddPage(NowSubterm);
                    5: DeletePage(NowSubterm);
                    6:
                end;
            until Choice = 6;
        end
        else
            Writeln('Подтермин не найден!');
    end;
end;

procedure AddSubterm(NewTerm: PTerm);
var
    Curr, NewSubterm: PTerm;
    NewSubtermValue: String;
    Choice:Integer;
begin
    Writeln('Введите подтермин: ');
    Readln(NewSubtermValue);
    if HasSubtermListThisSubterm(NewTerm, NewSubtermValue) then
        Writeln('Такой подтермин уже существует')
    else
    begin
        NewSubterm := CreateNewTerm(NewSubtermValue);
        repeat
            Writeln('--------------------------------------------------------');
            Writeln('РЕДАКТОР ПОДТЕРМИНА ' + NewSubtermValue);
            OutputEditTermMenu;
            Choice := InputChoice(1,6);
            case Choice of
                1: AddSubterm(NewSubterm);
                2: EditSubterm(NewSubterm);
                3: DeleteSubterm(NewSubterm);
                4: AddPage(NewSubterm);
                5: DeletePage(NewSubterm);
                6:
            end;
        until Choice = 6;

        Curr := NewTerm^.Subterm;
        if Curr <> nil then
        begin
            while Curr^.NextTerm <> nil do
                Curr := Curr^.NextTerm;
            Curr^.NextTerm := NewSubterm;
        end
        else
            NewTerm^.Subterm := NewSubterm;

        Writeln('Подтермин добавлен успешно!');    
    end;
end;

function CreateSubjectIndex: PHeader;
var
    Header: PHeader;
begin
    New(Header);
    Header^.FirstTerm := nil;

    CreateSubjectIndex := Header;
end;

procedure CreateHashTable(var HashTable: THashTable);
var
    I: Integer;
begin
    for I := Low(HashTable) to High(HashTable) do
    begin
        New(HashTable[I]);
        HashTable[I]^.FirstTerm := nil;
    end;
end;

procedure OutputSubjectIndex(HashTable: THashTable);
var
    I: Integer;
begin
    for I := Low(HashTable) to High(HashTable) do
    begin
        OutputSegmentList(HashTable[I]);
    end;
end;

begin
    Writeln('Данная программа - предметный указатель');
    CreateHashTable(HashTable);
    repeat
        OutputMainMenu;
        Choice := InputChoice(1, 9);
        case Choice of
            1: OutputSubjectIndex(HashTable);
            2:
                begin
                    Writeln('Введите термин: ');
                    Readln(TermName);
                    if not HasTermListThisTerm(Header, TermName) then
                    begin
                        NewTerm := CreateNewTerm(TermName);
                        repeat
                            Writeln('--------------------------------------------------------');
                            Writeln('РЕДАКТОР ТЕРМИНА ' + TermName);
                            OutputEditTermMenu;
                            Choice := InputChoice(1,6);
                            case Choice of
                                1: AddSubterm(NewTerm);
                                2: EditSubterm(NewTerm);
                                3: DeleteSubterm(NewTerm);
                                4: AddPage(NewTerm);
                                5: DeletePage(NewTerm);
                                6: AddTerm(Header, NewTerm);
                            end;
                        until Choice = 6;
                    end;
                end;
            3:;
            4:;
            5:;
            6:;
            7:;
            8:;
        end;
    until Choice = 9;
end.
