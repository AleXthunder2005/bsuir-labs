#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <locale.h>
#include <stdlib.h>


char* getSubstring(char* str, int start, int length) {
    char* word;
    int i;
    word = (char*)malloc(length + 1);
    for (i = 0; i < length; i++) {
        word[i] = str[start + i];
    }
    word[length] = 0;
    return word;
}

int getEndOfWord(char* str, int start) {
    int i;
    i = start;
    while ((str[i] != '_') && (str[i] != 0)) {
        i++;
    }
    return i;
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


const char* findRusWord(const char* englishWords[], const char* russianWords[], const char* englishWord) {
    for (int i = 0; i < 20; i++) {
        if (strcmp(englishWords[i], englishWord) == 0) {
            return russianWords[i];
        }
    }
    return englishWord;
}

int main() {
    setlocale(LC_ALL, "Rus");

    char str[256];
    char rusStr[256];
    char *word, *rusWord;
    int prevPos = 0, currPos = 0;

    const char* englishWords[20] = {
        "THIS",
        "A",
        "IS",
        "TABLE",
        "BOOK",
        "CAT",
        "DOG",
        "HOUSE",
        "CAR",
        "COMPUTER",
        "SCHOOL",
        "PEN",
        "PAPER",
        "WINDOW",
        "DOOR",
        "FISH",
        "BIRD",
        "TREE",
        "FLOWER",
        "CHAIR"
    };

    const char* russianWords[20] = {
        "ЭТО",
        "",
        "",
        "СТОЛ",
        "КНИГА",
        "КОШКА",
        "СОБАКА",
        "ДОМ",
        "МАШИНА",
        "КОМПЬЮТЕР",
        "ШКОЛА",
        "РУЧКА",
        "БУМАГА",
        "ОКНО",
        "ДВЕРЬ",
        "РЫБА",
        "ПТИЦА",
        "ДЕРЕВО",
        "ЦВЕТОК",
        "СТУЛ"
    };



    printf("1. Выполнить перевод предложения на английском.\n");
    printf("Введите строку.\n");
    gets(str);
    int strLength = getStringLength(str);

    while (currPos != strLength - 1) {
        currPos = getEndOfWord(str, prevPos);
        word = getSubstring(str, prevPos, currPos-prevPos);
        rusWord = findRusWord(englishWords, russianWords, word);

        printf("%s", rusWord);
        ((rusWord[0] == 0) || (currPos == strLength - 1)) ? printf("") : printf("_");
        prevPos = currPos+1;
    }
    return 0;
}