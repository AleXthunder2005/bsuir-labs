#include <iostream>
#include <windows.h>
#include <fstream>
using namespace std;

void printCondition();
int readNum(int min, int max);
bool checkFile(string path);
string readFile(string path);
string inputTextFromFile();
string inputTextFromConsole();
string inputText();
int getLastSymbIndex(string text);
int getNextSpaceIndex(string text, int spaceIndex);
string getNewWord(string text, int& spaceIndex, int numWord);
void outputTextToConsole(string text);
void outputTextToFile(string text);
void outputText(string text);

void printCondition()
{
    cout << "Данная программа выведет каждое нечетное слово в кавычках, а каждое четное - в квадратных скобках" << endl;
}

string inputText()
{
    int choice;
    string text;

    cout << "Выберите вариант ввода:" << endl << "1. Ввод из консоли" << endl << "2. Ввод из файла" << endl << "Использовать вариант:";
    choice = readNum(1, 2);

    if (choice == 1)
    {
        text = inputTextFromConsole();
    }
    else
    {
        text = inputTextFromFile();
    }

    return text;
}

string inputTextFromConsole()
{
    string text;
    do
    {
        cout << "Введите текст:" << endl;
        getline(cin, text);
    }
    while ((getLastSymbIndex(text) == 0) || (text.empty()));
    text = " " + text + " ";

    return text;
}

string inputTextFromFile()
{
    string pathFile, text;
    bool isInputFromFileSuccessfully;


    cout << "Данные в файле должны содержать текст" << endl;
    do
    {
        cout << "Введите путь к файлу и его имя с его раширением:";
        cin >> pathFile;
        isInputFromFileSuccessfully = checkFile(pathFile);
    } while(!isInputFromFileSuccessfully);
    text = readFile(pathFile);

    return text;
}

bool checkFile(string path)
{
    ifstream fin;
    bool isFileCorrect;
    string checkText, bufText;

    isFileCorrect = true;

    fin.open(path);
    if (!fin.is_open())
    {
        isFileCorrect = false;
        cout << "Файл не найден!\nВнесите изменения в файл и повторите попытку!" << endl;
    }
    else
    {
        do
        {
            getline(fin, bufText);
            checkText += bufText;
        }
        while (!fin.eof());

        if ((getLastSymbIndex(checkText) == 0) or (checkText.empty()))
        {
            isFileCorrect = false;
            cout << "Файл пустой!\nВнесите изменения в файл и повторите попытку!" << endl;
        }
        fin.close();
    }

    return isFileCorrect;
}

string readFile(string path)
{
    ifstream fin;
    string text, bufText;

    fin.open(path);
    do
    {
        getline(fin, bufText);
        text += bufText;
    }
    while (!fin.eof());
    fin.close();

    text = " " + text + " ";

    return text;
}

int readNum(int min, int max)
{
    bool isIncorrect;
    int num;

    do
    {
        isIncorrect = true;
        cin >> num;
        if (cin.fail() || (cin.get() != '\n'))
        {
            cout << "Некорректный ввод! Введите значение еще раз:" << endl;
            cin.clear();
            while (cin.get() != '\n');
        }
        else
        {
            if (num < min || num > max)
            {
                cout << "Недопустимое значение! Введите значение еще раз:" << endl;
            }
            else
            {
                isIncorrect = false;
            }
        }
    }
    while (isIncorrect);

    return num;
}

int getLastSymbIndex(string text)
{
    int i;
    char c;
    i = text.length() - 1;
    do
    {
        i--;
        c = text[i];
    }
    while((c == 32) && (i != 0));

    return i;
}

int getNextSpaceIndex(string text, int spaceIndex)
{
    int i;
    char c;
    i = spaceIndex;
    do
    {
        i++;
        c = text[i];
    }
    while(c != 32);

    return i;
}

string getNewWord(string text, int& spaceIndex, int numWord)
{
    int i, nextSpaceIndex;
    string word;
    char beginSym, endSym;

    do
    {
        nextSpaceIndex = getNextSpaceIndex(text, spaceIndex);
        spaceIndex++;
    }
    while (nextSpaceIndex - spaceIndex == 0);

    i = spaceIndex;

    if (numWord % 2 == 1)
    {
        beginSym = '"';
        endSym = '"';
    }
    else
    {
        beginSym = '[';
        endSym = ']';
    }

    word = beginSym;
    do
    {
        word += text[i];
        i++;
    }
    while (i != nextSpaceIndex);
    word += endSym;

    spaceIndex = nextSpaceIndex;

    return word;
}

string getNewText(string text)
{
    int spaceIndex, numWord, lastSpaceIndex;
    string newWord, newText;

    spaceIndex = 0;
    numWord = 1;
    lastSpaceIndex = getLastSymbIndex(text) + 1;

    do
    {
        newWord = getNewWord(text, spaceIndex, numWord);
        newText += newWord + ' ';
        numWord++;
    }
    while (spaceIndex != lastSpaceIndex);

    return newText;
}

void outputText(string text)
{
    int  choice;

    cout << "Выберите вариант вывода:" << endl << "1. Вывод в консоль" << endl << "2. Вывод в файл" << endl << "Использовать вариант:";
    choice = readNum(1, 2);

    if (choice == 1)
    {
        outputTextToConsole(text);
    }
    else
    {
        outputTextToFile(text);
    }
}

void outputTextToConsole(string text)
{
    cout << text;
}

void outputTextToFile(string text)
{
    ofstream fout;
    string path;
    bool isFileIncorrect;

    cout << "Для вывода введите путь к файлу и его имя c расширением." << endl;
    cout << "Если файл отсутствует то он будет создан автоматически по указанному пути или в корневой папке программы (по умолчанию)" << endl;
    do
    {
        cout << "Введите путь:";
        cin >> path;
        fout.open(path);
        isFileIncorrect = false;

        fout << text;
        if (fout.fail())
        {
            cout << "Не удалось вывести в файл! ";
            isFileIncorrect = true;
            fout.clear();
        }
    }
    while (isFileIncorrect);

    fout.close();
    cout << "Вывод данных... успешно!";
}

int main()
{
    string textIn, newText;

    SetConsoleOutputCP(CP_UTF8);

    printCondition();
    textIn = inputText();
    newText = getNewText(textIn);
    outputText(newText);
    return 0;
}
