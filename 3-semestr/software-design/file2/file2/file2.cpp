#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>

#define MAX_SURNAME_LENGTH 30
#define PHONE_LENGTH 14
#define FILENAME "F:\\Projects\\C Projects\\file2\\info"

typedef struct {
    char surname[MAX_SURNAME_LENGTH];
    int year;
    char phone_number[PHONE_LENGTH];
} Person;

typedef struct ListItem {
    Person person;
    struct ListItem* next;
} ListItem;

void addToList(ListItem** header, Person person) {
    ListItem* newElem = malloc(sizeof(ListItem));
    if (!newElem) {
        fprintf(stderr, "Memory allocation failed\n");
        return;
    }
    newElem->person = person;
    newElem->next = NULL;

    // If the list is empty, set the new element as the header
    if (*header == NULL) {
        *header = newElem;
    }
    else {
        ListItem* tail = *header;
        while (tail->next != NULL) {
            tail = tail->next;
        }
        tail->next = newElem;
    }
}

void deleteFromList(ListItem** header, char* phoneNumber) {
    ListItem* current = *header;
    ListItem* previous = NULL;

    while (current != NULL) {
        if (strcmp(current->person.phone_number, phoneNumber) == 0) {
            if (previous == NULL) {
                // Deleting the first element
                ListItem* temp = current;
                *header = current->next;
                free(temp);
            }
            else {
                // Deleting an element in the middle or end
                previous->next = current->next;
                free(current);
            }
            return; // Exit after deletion
        }
        previous = current;
        current = current->next;
    }
}

ListItem* findByPhoneNumber(ListItem* header, char* phoneNumber) {
    ListItem* current = header;
    while (current != NULL) {
        if (strcmp(current->person.phone_number, phoneNumber) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL; // Not found
}

ListItem* findBySurname(ListItem* header, char* surname) {
    ListItem* current = header;
    while (current != NULL) {
        if (strcmp(current->person.surname, surname) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL; // Not found
}

int countPhonesByYear(ListItem* header, int year) {
    int count = 0;
    ListItem* current = header;
    while (current != NULL) {
        if (current->person.year >= year) {
            count++;
        }
        current = current->next;
    }
    return count;
}

ListItem* loadPersons() {
    ListItem* header = NULL;

    FILE* file = fopen(FILENAME, "rb");
    if (!file) {
        perror("Failed to open file");
        return NULL;
    }

    Person person;
    while (fread(&person, sizeof(Person), 1, file) == 1) {
        addToList(&header, person);
    }

    fclose(file);
    return header;
}

void savePersons(ListItem* header) {
    FILE* file = fopen(FILENAME, "wb");
    if (!file) {
        perror("Failed to open file");
        return;
    }

    ListItem* current = header;
    while (current != NULL) {
        fwrite(&current->person, sizeof(Person), 1, file);
        current = current->next;
    }
    fclose(file);
}

void displayPersons(ListItem* current) {
    if (current == NULL) {
        printf("Нет доступных абонентов.\n");
        return;
    }

    printf("\nСписок абонентов:\n");
    while (current != NULL) {
        printf("Фамилия: %s, Год установки: %d, Номер телефона: %s\n",
            current->person.surname, current->person.year, current->person.phone_number);
        current = current->next;
    }
}

Person createPerson() {
    Person person;
    printf("Введите фамилию абонента: ");
    scanf("%s", person.surname);
    printf("Введите год установки телефона: ");
    scanf("%d", &person.year);
    printf("Введите номер телефона: ");
    scanf("%s", person.phone_number);
    return person;
}

int main() {
    setlocale(LC_ALL, "Rus");
    ListItem* header = NULL;

    while (1) {
        printf("\nМеню:\n");
        printf("1. Добавить абонента\n");
        printf("2. Удалить абонента\n");
        printf("3. Загрузить абонентов из файла\n");
        printf("4. Выгрузить абонентов в файл\n");
        printf("5. Найти номер по фамилии\n");
        printf("6. Посчитать количество телефонов, установленных с года ХХХХ\n");
        printf("7. Выход\n");

        int choice;
        printf("Выберите действие (1-7): ");
        scanf("%d", &choice);

        switch (choice) {
        case 1: {
            Person new_person = createPerson();
            addToList(&header, new_person);
            break;
        }
        case 2: {
            char phone_number[PHONE_LENGTH];
            printf("Введите номер телефона для удаления: ");
            scanf("%s", phone_number);
            deleteFromList(&header, phone_number);
            break;
        }
        case 3:
            header = loadPersons();
            if (header) {
                printf("Абоненты загружены из файла.\n");
            }
            break;
        case 4:
            savePersons(header);
            printf("Абоненты сохранены в файл.\n");
            break;
        case 5: {
            char surname[MAX_SURNAME_LENGTH];
            printf("Введите фамилию для поиска номера: ");
            scanf("%s", surname);
            ListItem* item = findBySurname(header, surname);
            if (item) {
                printf("Номер телефона: %s\n", item->person.phone_number);
            }
            else {
                printf("Абонент не найден.\n");
            }
            break;
        }
        case 6: {
            int year;
            printf("Введите год для подсчета телефонов: ");
            scanf("%d", &year);
            int count = countPhonesByYear(header, year);
            printf("Количество телефонов, установленных c %d года: %d\n", year, count);
            break;
        }
        case 7:
            while (header != NULL) {
                ListItem* temp = header;
                header = header->next;
                free(temp);
            }
            exit(0);
        default:
            printf("Неверный выбор. Пожалуйста, попробуйте снова.\n");
        }

        displayPersons(header);
    }

    return 0;
}