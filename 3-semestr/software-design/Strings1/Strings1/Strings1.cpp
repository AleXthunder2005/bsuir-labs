#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <locale.h>
#include <stdlib.h>

char* getSubstring(char* str, int start, int length) {
    char* word;
    int i;
    word = (char *)malloc(length + 1);
    for (i = 0; i < length; i++) {
        word[i] = str[start + i];
    }
    word[length] = 0;
    return word;
}

char* findMostLongWord(char* str) {
    int i, startMaxWord, currLength, maxLength; 
    i = 0;
    startMaxWord = 0;
    currLength = 0;
    maxLength = 0;
    while (str[i]) {
        if ((str[i] == ' ')) {
            if (currLength > maxLength) {
                maxLength = currLength;
                startMaxWord = i - maxLength;
            }
            currLength = 0;
        } else {
            currLength++;
        }
        i++;
    }
    if (currLength > maxLength) {
        maxLength = currLength;
        startMaxWord = i - maxLength;
    }

    return getSubstring(str, startMaxWord, maxLength);
}

int getStringLength(char* str) {
    int i, length;
    i = 0;
    length = 0;
    while (str[i]) {
        length++;
        i++;
    }

    return ++length;
}

char* getNewStr(char* str) {
    int i;
    int length;
    length = getStringLength(str);
    char* newStr;
    newStr = malloc(length);
    char* word;

    int currWordLength = 0;
    int j;
    int index = 0;

    i = length - 2;
    int currWordStart = i;
    while (i >= 0) {
        if (str[i] == ' ') {
            currWordStart = i+1;
            j = 0;
            while (j < currWordLength) {
                newStr[index + j] = str[currWordStart + j];
                j++;
            }

            newStr[index + j] = ' ';
            index = index + j + 1;
            currWordLength = 0;
        }
        else {
            currWordLength++;
        }
        i--;
    }

    currWordStart = i + 1;
    j = 0;
    while (j < currWordLength) {
        newStr[index + j] = str[currWordStart + j];
        j++;
    }

    newStr[index + j] = 0;

    return newStr;
}

char* convertString(char *a, char *b, int m, int n) {
    int i, j;
    i = m;
    j = 0;

    while ((a[i] != 0) && (j < n)) {
        a[i] = b[j];
        i++;
        j++;
    }
    return a;
}

int main() {
    setlocale(LC_ALL, "Rus");

    char str[256];
    char a[256];
    char b[256];
    char* word;
    char* newStr;
    printf("Введите строку.\n");
    gets(str);

    printf("1. Вывести на экран самое длинное слово из текста.\n");
    word = findMostLongWord(str);
    if (word[0]) { 
        puts(word);
    }
    else puts("Не найдено ни одного слова.");
    

    printf("2. Поменять местами первое слово с последним, второе с предпоследним и т.д.\n");
    newStr = getNewStr(str);
    if (newStr[0]) {
        puts(newStr);
    }
    else puts("Не найдено ни одного слова.");


    int m, n;
    printf("\n3. Даны переменные M, N и строки A, B. В строке A заменить символы начиная с M на первые N символов строки B.\n");
    printf("Введите строку А:\n");
    gets(a);
    printf("Введите строку B:\n");
    gets(b);
    printf("Введите число M:\n");
    scanf("%d", &m);
    printf("Введите число N:\n");
    scanf("%d", &n);
    puts(convertString(a, b, m, n));

    return 0;
}