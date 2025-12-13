#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <stdlib.h>
#include <locale.h>

// Определение структуры узла списка
typedef struct Node {
    int data;
    struct Node* next;
} Node;

// Функция для добавления элемента в список
void addToList(Node** head, int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->data = value;
    newNode->next = *head;
    *head = newNode;
}

// Функция для удаления первого элемента, кратного 5
void removeFirstMultipleOfFive(Node** head) {
    Node* current = *head;
    Node* previous = NULL;

    while (current != NULL) {
        if (current->data % 5 == 0) {
            if (previous == NULL) { // Если это первый элемент
                *head = current->next;
            }
            else {
                previous->next = current->next;
            }
            free(current);
            return; // Удаляем только первый найденный элемент
        }
        previous = current;
        current = current->next;
    }
}

// Функция для вставки 1 перед каждым элементом, кратным 7
void insertOneBeforeMultipleOfSeven(Node** head) {
    Node* current = *head;

    while (current != NULL) {
        if (current->data % 7 == 0) {
            Node* newNode = (Node*)malloc(sizeof(Node));
            newNode->data = 1;
            newNode->next = current;
            if (current == *head) { // Если это первый элемент
                *head = newNode;
            }
            else {
                // Найти предыдущий элемент
                Node* previous = *head;
                while (previous->next != current) {
                    previous = previous->next;
                }
                previous->next = newNode;
            }
        }
        current = current->next; // Переход к следующему элементу
    }
}

// Функция для печати списка
void printList(Node* head) {
    Node* current = head;
    while (current != NULL) {
        printf("%d -> ", current->data);
        current = current->next;
    }
    printf("NULL\n");
}

// Главная функция
int main() {
    setlocale(LC_ALL, "RU");
    Node* head = NULL; // Инициализация списка

    int value;
    printf("Введите числа для списка (введите -1 для завершения ввода):\n");
    while (1) {
        scanf("%d", &value);
        if (value == -1) {
            break; // Завершение ввода
        }
        addToList(&head, value); // Добавление числа в список
    }

    printf("Исходный список:\n");
    printList(head);

    removeFirstMultipleOfFive(&head);
    printf("Список после удаления первого элемента, кратного 5:\n");
    printList(head);

    insertOneBeforeMultipleOfSeven(&head);
    printf("Список после вставки 1 перед каждым элементом, кратным 7:\n");
    printList(head);

    // Освобождение памяти
    Node* current = head;
    while (current != NULL) {
        Node* nextNode = current->next;
        free(current);
        current = nextNode;
    }

    return 0;
}