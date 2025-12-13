#include <iostream>
#include <fstream>
#include <set>
#include <windows.h>
using namespace std;

void printCondition()
{
    cout << "Данная программа напечатает множество всех встречающихся в строке знаков арифметических операций и цифр" << endl;
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
int getLastNotSpaceIndex(string text)
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
string inputStrFromConsole()
{
    string text;
    do
    {
        cout << "Введите текст:" << endl;
        getline(cin, text);
    }
    while ((getLastNotSpaceIndex(text) == 0) || (text.empty()));

    return text;
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

        if ((getLastNotSpaceIndex(checkText) == 0) || (checkText.empty()))
        {
            isFileCorrect = false;
            cout << "Файл пустой!\nВнесите изменения в файл и повторите попытку!" << endl;
        }
        fin.close();
    }

    return isFileCorrect;
}
string inputStrFromFile()
{
    string pathFile, text;
    bool isInputFromFileSuccessfully;

    cout << "Данные в файле должны содержать текст" << endl;
    do
    {
        cout << "Введите путь к файлу и его имя с его расширением:";
        cin >> pathFile;
        isInputFromFileSuccessfully = checkFile(pathFile);
    } while(!isInputFromFileSuccessfully);
    text = readFile(pathFile);

    return text;
}
string inputStr()
{
    int choice;
    string text;

    cout << "Выберите вариант ввода:" << endl << "1. Ввод из консоли" << endl << "2. Ввод из файла" << endl << "Использовать вариант:";
    choice = readNum(1, 2);

    if (choice == 1)
    {
        text = inputStrFromConsole();
    }
    else
    {
        text = inputStrFromFile();
    }

    return text;
}
set<char> findSymbols(string str)
{
    int i;
    set<char> searchCharacters{'0', '1', '2', '3', '4', '5', '6',
                               '7', '8', '9', '+', '-', '=', '*', '/' };
    set<char> answerSet{};
    for (i = 0; i < str.length(); i++)
    {
        if (searchCharacters.count(str[i]))
        {
            answerSet.insert(str[i]);
        }
    }
    return answerSet;
}

void outputAnswerToConsole(set<char> &answer)
{
    if (!answer.empty())
    {
        for (auto it = answer.begin(); it != answer.end(); it++)
        {
            cout << *it << " ";
        }
    }
    else
    {
        cout << "В строке нет нужных символов\n";
    }
}
void outputAnswerToFile(set<char> &answer)
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

        if (!answer.empty())
        {
            for (auto it = answer.begin(); it != answer.end(); it++)
            {
                fout << *it << " ";
            }
        }
        else
        {
            fout << "В строке нет нужных символов\n";
        }

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
void outputAnswer(set<char> &answer)
{
    int  choice;

    cout << "Выберите вариант вывода:" << endl << "1. Вывод в консоль" << endl << "2. Вывод в файл" << endl << "Использовать вариант:";
    choice = readNum(1, 2);

    if (choice == 1)
    {
        outputAnswerToConsole(answer);
    }
    else
    {
        outputAnswerToFile(answer);
    }
}

int main() {
    string str;
    set<char> answerSet;

    SetConsoleOutputCP(CP_UTF8);

    printCondition();
    str = inputStr();
    answerSet = findSymbols(str);
    outputAnswer(answerSet);
    return 0;
}
