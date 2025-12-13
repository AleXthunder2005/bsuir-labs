#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <locale.h>

const int MIN = 0;
const int MAX = 99;

// Определяем структуру узла дерева
typedef struct Node {
    int key;
    struct Node* left;
    struct Node* right;
} Node;

// Функция для создания нового узла
Node* createNode(int key) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

// Функция для вставки узла в бинарное дерево поиска
Node* addNode(Node* root, int key) {
    if (root == NULL) {
        return createNode(key);
    }

    if (key < root->key) {
        root->left = addNode(root->left, key);
    }
    else if (key > root->key) {
        root->right = addNode(root->right, key);
    }

    return root;
}

// Функция для поиска узла в бинарном дереве поиска
Node* search(Node* root, int key) {
    if (root == NULL || root->key == key) {
        return root;
    }

    if (key < root->key) {
        return search(root->left, key);
    }
    else {
        return search(root->right, key);
    }
}

// Функция для поиска минимального узла
Node* findMin(Node* root) {
    while (root && root->left != NULL) {
        root = root->left;
    }
    return root;
}

// Функция для удаления узла из дерева
Node* deleteNode(Node* root, int key) {
    if (root == NULL) {
        return root; // Узел не найден
    }

    if (key < root->key) {
        root->left = deleteNode(root->left, key);
    }
    else if (key > root->key) {
        root->right = deleteNode(root->right, key);
    }
    else {
        // Узел найден
        // Узел с одним или нулем дочерних узлов
        if (root->left == NULL) {
            Node* temp = root->right;
            free(root);
            return temp;
        }
        else if (root->right == NULL) {
            Node* temp = root->left;
            free(root);
            return temp;
        }

        // Узел с двумя дочерними узлами: находим минимальный узел в правом поддереве
        Node* temp = findMin(root->right);
        root->key = temp->key; // Копируем значение минимального узла
        root->right = deleteNode(root->right, temp->key); // Удаляем минимальный узел
    }

    return root;
}

// Функции обхода дерева
// Прямой обход R - A - B
void preOrderTraversal(Node* root) {
    if (root != NULL) {
        printf("(%d) ", root->key);
        preOrderTraversal(root->left);
        preOrderTraversal(root->right);
        if (root != NULL) printf("%d ", root->key);
    }
    else {
        printf("nil ");
    }
}

// Симметричный обход  A - R - B
void inOrderTraversal(Node* root) {
    if (root != NULL) {
        printf("%d ", root->key);
        inOrderTraversal(root->left);
        printf("(%d) ", root->key);
        inOrderTraversal(root->right);
        if (root != NULL) printf("%d ", root->key);
    }
    else {
        printf("nil ");
    }
}

// Концевой обход A - B - R
void postOrderTraversal(Node* root) {
    if (root != NULL) {
        printf("%d ", root->key);
        postOrderTraversal(root->left);
        postOrderTraversal(root->right);
        printf("(%d) ", root->key);
    }
    else {
        printf("nil ");
    }
}

// Функция для чтения значения
int readValue() {
    int value;
    printf("Введите значение (0 для завершения): ");
    scanf("%d", &value);
    return value;
}

// Функция для построения дерева
Node* buildTree() {
    Node* root = NULL; // Инициализация корня дерева
    int value = readValue();

    while (value != 0) {
        root = addNode(root, value); // Добавляем узел в дерево
        value = readValue();
    }

    return root;
}

// Функция для вывода дерева с отступами
void printTree(Node* root, int space) {
    // Базовый случай
    if (root == NULL) {
        return;
    }

    // Увеличиваем расстояние между уровнями
    space += 4;

    // Сначала обрабатываем правое поддерево
    printTree(root->right, space);

    // Печатаем текущий узел после пробелов
    printf("\n");
    for (int i = 4; i < space; i++) {
        printf(" ");
    }
    printf("%d", root->key);

    // Обрабатываем левое поддерево
    printTree(root->left, space);
}

// Функция для копирования бинарного дерева
Node* copyTree(Node* root) {
    if (root == NULL) {
        return NULL; // Если узел пустой, возвращаем NULL
    }

    // Создаем новый узел с тем же значением
    Node* newRoot = createNode(root->key);

    // Рекурсивно копируем левое и правое поддеревья
    if (root->left != NULL) newRoot->left = copyTree(root->left);
    if (root->right != NULL) newRoot->right = copyTree(root->right);

    return newRoot; // Возвращаем корень нового дерева
}


// Процедура для симметричной правой прошивки бинарного дерева A - R - B
void flashTree(Node* root, Node* base) {
    if (root == NULL) {
        return;
    }

    // Рекурсивный обход левого поддерева
    flashTree(root->left, root);


    // Устанавливаем указатель на следующий узел
    if (root->right == NULL) {
        root->right = base; // Указатель на следующий узел
        return;
    }

    // Рекурсивный обход правого поддерева
    flashTree(root->right, base);
}

void printFlashedTree(Node* root, Node* flashedRoot, int space) {
    // Базовый случай
    if (root == NULL) {
        return;
    }

    // Увеличиваем расстояние между уровнями
    space += 4;

    // Сначала обрабатываем правое поддерево
    printFlashedTree(root->right, flashedRoot->right, space);

    // Печатаем текущий узел после пробелов
    printf("\n");
    for (int i = 4; i < space; i++) {
        printf(" ");
    }
    if ((root->right == NULL) && (flashedRoot->right != NULL)) {
        printf("%d(%d)", root->key, flashedRoot->right->key);
    }
    else
    {
        printf("%d", root->key);
    }

    // Обрабатываем левое поддерево
    printFlashedTree(root->left, flashedRoot->left, space);
}

int main() {
    setlocale(LC_ALL, "Rus");

    printf("Данная программа построит бинарное дерево поиска и проделает с ним следующие действия:\n    1) Визуализирует дерево\n    2) Выполнит три различных полных обхода по этому бинарному дереву\n    3) Выполнит симметрично правую прошивку дерева\n    4) Позволит удалить вершину прошитого дерева\n");
    printf("\nПОСТРОЕНИЕ ДЕРЕВА:\n");
    Node* tree = buildTree(); // Строим дерево

    printf("\nВЫВОД ДЕРЕВА:\n");
    printTree(tree, 0); // Выводим дерево с отступами

    printf("\n\nПрямой обход:\n");
    preOrderTraversal(tree); // Прямой обход

    printf("\nСимметричный обход:\n");
    inOrderTraversal(tree); // Симметричный обход

    printf("\nКонцевой обход:\n");
    postOrderTraversal(tree); // Концевой обход

    printf("\n\nСИММЕТРИЧНАЯ ПРАВАЯ ПРОШИВКА:\n");
    Node* newTree = copyTree(tree);

    if (tree != NULL) {
        Node* baseNode = tree;
        flashTree(newTree, newTree);
        printFlashedTree(tree, newTree, 0);
    }

    printf("\n\nУДАЛЕНИЕ ВЕРШИНЫ:\n");
    int val = readValue();
    while (val != 0) {
        tree = deleteNode(tree, val);
        newTree = copyTree(tree);
        flashTree(newTree, newTree);
        printf("\n\nПрошитое дерево после удаления вершин:");
        printFlashedTree(tree, newTree, 0);
        printf("\n");
        val = readValue();
    }

    // Освобождение памяти
    while (tree != NULL) {
        tree = deleteNode(tree, tree->key);
    }

    return 0;
}