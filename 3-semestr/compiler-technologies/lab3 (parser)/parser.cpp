#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_TOKEN_COUNT 256

////// EnumDefinitions //////
typedef enum TokenType {
    ttASSIGNMENT,
    ttARITHMETIC_OPERATOR,
    ttCOMPARISON_SIGN,
    ttCOLON,
    ttTAB,
    ttIF,
    ttELSE,
    ttELIF,
    ttWHILE,
    ttFOR,
    ttIN,
    ttIDENTIFICATOR,
    ttSTRING,
    ttINT,
    ttAND,
    ttOR,
    ttMATCH,
    ttCASE,
    ttBRACKET_OPEN,
    ttBRACKET_CLOSE,
    ttNEW_LINE,
    ttEMPTY_STR,
    ttUNKNOWN,
    ttPROGRAM_END
} TokenType;

typedef TokenType* PTokenType;
////// EnumDefinitions //////

////// StructDefinitions //////
typedef struct Node {
    const char* value;
    char* inSource;
    int count;
    struct Node** nodes;
} Node;

typedef struct Token {
    TokenType type;
    char* inSource;
    int line;
} Token;
typedef Token* PToken;
////// StructDefinitions //////

////// GlobalVariables //////
PToken arr;
int next;
int maxAvailable;
TokenType expectedToken;
Node* tree;
////// GlobalVariables //////

////// NodeFunctions //////
Node* createNode(const char* value, char* inSource, int count);
Node* freeNode(Node* curr);
////// NodeFunctions //////

//////// TreeFunctions //////
Node* freeTree(Node* curr);
//////// TreeFunctions //////

//////// PrintFunctions //////
void printNode(Node* curr, int h);
void printTree(Node* curr, int h);
//////// PrintFunctions //////

//// ParserFunctionsPrototypes //////
Node* errorToken();
Node* term(const TokenType expected);
Node* program();
Node* statement();
Node* statementSet();
Node* ifStatement();
Node* ifTail();
Node* elifBlock();
Node* elseBlock();
Node* whileStatement();
Node* matchStatement();
Node* caseBlockSet();
Node* caseBlock();
Node* assignmentStatement();
Node* operand();
Node* expression();
Node* arithmeticExpressionTail();
Node* condition();
Node* block();
Node* indentedStatementSet();
Node* indentedStatement();
//// ParserFunctionsPrototypes //////

//// TokenFunctions //////
TokenType convertStringToToken(char* str) {
    if (!strcmp(str, "ttARITHMETIC_OPERATOR")) {
        return ttARITHMETIC_OPERATOR;
    }
    if (!strcmp(str, "ttCOMPARISON_SIGN")) {
        return ttCOMPARISON_SIGN;
    }
    if (!strcmp(str, "ttCOLON")) {
        return ttCOLON;
    }
    if (!strcmp(str, "ttASSIGNMENT")) {
        return ttASSIGNMENT;
    }
    if (!strcmp(str, "ttTAB")) {
        return ttTAB;
    }
    if (!strcmp(str, "ttIF")) {
        return ttIF;
    }
    if (!strcmp(str, "ttELSE")) {
        return ttELSE;
    }
    if (!strcmp(str, "ttELIF")) {
        return ttELIF;
    }
    if (!strcmp(str, "ttWHILE")) {
        return ttWHILE;
    }
    if (!strcmp(str, "ttFOR")) {
        return ttFOR;
    }
    if (!strcmp(str, "ttIN")) {
        return ttIN;
    }
    if (!strcmp(str, "ttIDENTIFICATOR")) {
        return ttIDENTIFICATOR;
    }
    if (!strcmp(str, "ttSTRING")) {
        return ttSTRING;
    }
    if (!strcmp(str, "ttINT")) {
        return ttINT;
    }
    if (!strcmp(str, "ttAND")) {
        return ttAND;
    }
    if (!strcmp(str, "ttOR")) {
        return ttOR;
    }
    if (!strcmp(str, "ttMATCH")) {
        return ttMATCH;
    }
    if (!strcmp(str, "ttCASE")) {
        return ttCASE;
    }
    if (!strcmp(str, "ttBRACKET_OPEN")) {
        return ttBRACKET_OPEN;
    }
    if (!strcmp(str, "ttBRACKET_CLOSE")) {
        return ttBRACKET_CLOSE;
    }
    if (!strcmp(str, "ttNEW_LINE")) {
        return ttNEW_LINE;
    }
    if (!strcmp(str, "ttEMPTY_STR")) {
        return ttEMPTY_STR;
    }
    return ttUNKNOWN;
}

char* convertTokenToString(TokenType type) {
    switch (type) {
    case ttEMPTY_STR:
        return "";
    case ttNEW_LINE:
        return "ttNEW_LINE";
    case ttIF:
        return "ttIF";
    case ttELSE:
        return "ttELSE";
    case ttELIF:
        return "ttELIF";
    case ttWHILE:
        return "ttWHILE";
    case ttFOR:
        return "ttFOR";
    case ttIN:
        return "ttIN";
    case ttIDENTIFICATOR:
        return "ttIDENTIFICATOR";
    case ttSTRING:
        return "ttSTRING";
    case ttINT:
        return "ttINT";
    case ttAND:
        return "ttAND";
    case ttOR:
        return "ttOR";
    case ttMATCH:
        return "ttMATCH";
    case ttCASE:
        return "ttCASE";
    case ttBRACKET_OPEN:
        return "ttBRACKET_OPEN";
    case ttBRACKET_CLOSE:
        return "ttBRACKET_CLOSE";
    case ttARITHMETIC_OPERATOR:
        return "ttARITHMETIC_OPERATOR";
    case ttCOMPARISON_SIGN:
        return "ttCOMPARISON_SIGN";
    case ttASSIGNMENT:
        return "ttASSIGNMENT";
    case ttCOLON:
        return "ttCOLON";
    case ttTAB:
        return "ttTAB";
    default:
        return "ttUNKNOWN";
    }
}

PToken getTokenFlowFromFile(char* filePath) {
    int i = 0;
    char* temp1 = (char*)malloc(256 * sizeof(char));
    char* temp2 = (char*)malloc(256 * sizeof(char));
    int temp3;
    FILE* fInput;

    fInput = fopen(filePath, "r");

    arr = (PToken)malloc(sizeof(Token) * MAX_TOKEN_COUNT);

    while (!feof(fInput)) {
        fscanf(fInput, "%255[^|]|%255[^|]|%d\n", temp1, temp2, &temp3);

        arr[i].type = convertStringToToken(temp1);
        arr[i].inSource = (char*)malloc(256 * sizeof(char));
        strcpy(arr[i].inSource, temp2);
        arr[i].line = temp3;
        i++;
    }

    arr[i].type = ttPROGRAM_END;
    arr[i].inSource = "";
    arr[i].line = -1;

    fclose(fInput);

    free(temp1);
    free(temp2);

    return arr;
}
////// TokenFunctions //////


//////// NodeFunctions //////
Node* createNode(const char* value, char* inSource, int count) {
    Node* newNode;

    newNode = (Node*)malloc(sizeof(Node));
    if (newNode == NULL) {
        return newNode;
    }
    newNode->value = value;
    newNode->inSource = inSource;
    newNode->count = count;
    if (count > 0) {
        newNode->nodes = (Node**)malloc(sizeof(Node*) * count);
        for (int i = 0; i < count; i++) {
            newNode->nodes[i] = NULL;
        }
    }
    else {
        newNode->nodes = NULL;
    }

    return newNode;
}

Node* freeNode(Node* curr) {
    free(curr->nodes);
    free(curr);
    return NULL;
}
//////// NodeFunctions //////

//////// TreeFunctions //////
Node* freeTree(Node* curr) {
    if (curr == NULL) {
        return NULL;
    }
    else {
        for (int i = 0; i < curr->count; i++) {
            freeTree(curr->nodes[i]);
        }

        return freeNode(curr);
    }
}
//////// TreeFunctions //////

//////// PrintFunctions //////
void printNode(Node* curr, int h) {
    int i;

    for (i = 0; i < h - 1; i++) {
        printf("      ");
    }

    if (h != 0) {
        printf("      ");
    }

    if (curr->count == 0) {
        if (curr->inSource) {
            printf("<%s>------>(%s)\n", curr->value, curr->inSource);
        }
        else
            printf("<%s>------>(%s)\n", curr->value, "eps");
    }
    else {
        printf("<%s>\n", curr->value);
    }

}

void printTree(Node* curr, int h) {
    if (curr != NULL) {
        printNode(curr, h);

        for (int i = 0; i < curr->count; i++) {
            printTree(curr->nodes[i], h + 1);
        }
    }

}
//////// PrintFunctions //////

// ////// ParserFunctions //////
Node* errorToken() {
    printf("LINE: %d | EXPECTED token: %s | RECIEVED token: %s | value in file: %s.\n", arr[maxAvailable].line, convertTokenToString(expectedToken), convertTokenToString(arr[maxAvailable].type), arr[maxAvailable].inSource);
    return NULL;
}

Node* term(const TokenType expected) {
    Node* t = NULL;
    if (expected == (arr[next].type)) {
        t = createNode(convertTokenToString(arr[next].type), arr[next].inSource, 0);
        if (arr[next].type != ttPROGRAM_END) {
            next += 1;
            if (next > maxAvailable) {
                maxAvailable = next;
            }
        }
    }
    else if (next == maxAvailable)
    {
        expectedToken = expected;
    }

    return t;
}

Node* program() {
    int save = next;
    Node* t1, * t2, * new;

    next = save;
    if ((t1 = statement()) && (t2 = statementSet())) {
        new = createNode("Program", NULL, 2);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        return new;
    }

    return createNode("Program", NULL, 0);

    return NULL;
}

Node* statement() {
    int save = next;
    Node* t1, * new;

    next = save;
    if ((t1 = ifStatement())) {
        new = createNode("Statement", NULL, 1);
        new->nodes[0] = t1;
        return new;
    }

    next = save;
    if ((t1 = whileStatement())) {
        new = createNode("Statement", NULL, 1);
        new->nodes[0] = t1;
        return new;
    }

    next = save;
    if ((t1 = matchStatement())) {
        new = createNode("Statement", NULL, 1);
        new->nodes[0] = t1;
        return new;
    }

    next = save;
    if ((t1 = assignmentStatement())) {
        new = createNode("Statement", NULL, 1);
        new->nodes[0] = t1;
        return new;
    }

    return NULL;
}

Node* statementSet() {
    int save = next;
    Node* t1, * t2, * new;

    next = save;
    if ((t1 = statement()) && (t2 = statementSet())) {
        new = createNode("StatementSet", NULL, 2);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        return new;
    }

    return createNode("StatementSet", NULL, 0);

    return NULL;
}

Node* ifStatement() {
    int save = next;
    Node* t1, * t2, * t3, * t4, * t5, * new;

    next = save;
    if ((t1 = term(ttIF)) &&
        (t2 = condition()) &&
        (t3 = term(ttCOLON)) &&
        (t4 = block()) &&
        (t5 = ifTail())) {
        new = createNode("ifStatement", NULL, 5);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        new->nodes[3] = t4;
        new->nodes[4] = t5;
        return new;
    }
    return NULL;
}

Node* ifTail() {
    int save = next;
    Node* t1, * t2, * new;

    next = save;
    if ((t1 = elifBlock()) && (t2 = ifTail())) {
        new = createNode("IfTail", NULL, 2);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        return new;
    }

    next = save;
    if (t1 = elseBlock()) {
        new = createNode("IfTail", NULL, 1);
        new->nodes[0] = t1;
        return new;
    }

    return createNode("IfTail", NULL, 0);

    return NULL;
}

Node* elifBlock() {
    int save = next;
    Node* t1, * t2, * t3, * t4, * new;

    next = save;
    if ((t1 = term(ttELIF)) &&
        (t2 = condition()) &&
        (t3 = term(ttCOLON)) &&
        (t4 = block())) {
        new = createNode("ElifBlock", NULL, 4);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        new->nodes[3] = t4;
        return new;
    }
    return NULL;
}

Node* elseBlock() {
    int save = next;
    Node* t1, * t2, * t3, * new;

    next = save;
    if ((t1 = term(ttELSE)) &&
        (t2 = term(ttCOLON)) &&
        (t3 = block())) {
        new = createNode("ElseBlock", NULL, 3);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        return new;
    }
    return NULL;
}

Node* whileStatement() {
    int save = next;
    Node* t1, * t2, * t3, * t4, * new;

    next = save;
    if ((t1 = term(ttWHILE)) &&
        (t2 = condition()) &&
        (t3 = term(ttCOLON)) &&
        (t4 = block())) {
        new = createNode("WhileStatement", NULL, 4);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        new->nodes[3] = t4;
        return new;
    }
    return NULL;
}

Node* matchStatement() {
    int save = next;
    Node* t1, * t2, * t3, * t4, * new;

    next = save;
    if ((t1 = term(ttMATCH)) &&
        (t2 = expression()) &&
        (t3 = term(ttCOLON)) &&
        (t4 = caseBlockSet())) {
        new = createNode("MatchStatement", NULL, 4);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        new->nodes[3] = t4;
        return new;
    }
    return NULL;
}

Node* caseBlockSet() {
    int save = next;
    Node* t1, * t2, * new;

    next = save;
    if ((t1 = caseBlock()) && (t2 = caseBlockSet())) {
        new = createNode("CaseBlockSet", NULL, 2);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        return new;
    }

    return createNode("CaseBlockSet", NULL, 0);
}

Node* caseBlock() {
    int save = next;
    Node *t1, *t2, *t3, *t4, *t5, *new;

    next = save;
    if ((t1 = term(ttTAB)) &&
        (t2 = caseBlock())) {
        new = createNode("CaseBlock", NULL, 2);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        return new;
    }

    next = save;
    if ((t1 = term(ttCASE)) &&
        (t2 = expression()) &&
        (t3 = term(ttCOLON)) &&
        (t4 = block())) {
        new = createNode("CaseBlock", NULL, 4);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        new->nodes[3] = t4;
        return new;
    }
    return NULL;
}

Node* assignmentStatement() {
    int save = next;
    Node* t1, * t2, * t3, * new;

    next = save;
    if ((t1 = term(ttIDENTIFICATOR)) &&
        (t2 = term(ttASSIGNMENT)) &&
        (t3 = expression())) {
        new = createNode("AssignmentStatement", NULL, 3);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        return new;
    }
    return NULL;
}

Node* operand() {
    PToken save = next;
    Node* t1, * t2, * t3, * new;

    next = save;
    if ((t1 = term(ttIDENTIFICATOR))) {
        new = createNode("Operand", NULL, 1);
        new->nodes[0] = t1;
        return new;
    }

    next = save;
    if ((t1 = term(ttINT))) {
        new = createNode("Operand", NULL, 1);
        new->nodes[0] = t1;
        return new;
    }

    next = save;
    if ((t1 = term(ttSTRING))) {
        new = createNode("Operand", NULL, 1);
        new->nodes[0] = t1;
        return new;
    }

    next = save;
    if ((t1 = term(ttBRACKET_OPEN)) &&
        (t2 = expression()) &&
        (t3 = term(ttBRACKET_CLOSE))) {
        new = createNode("Operand", NULL, 3);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        return new;
    }

    return NULL;
}

Node* expression() {
    int save = next;
    Node* t1, * t2, * new;

    next = save;
    if ((t1 = operand()) &&
        (t2 = arithmeticExpressionTail())) {
        new = createNode("Expression", NULL, 2);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        return new;
    }
    return NULL;
}

Node* arithmeticExpressionTail() {
    int save = next;
    Node* t1, * t2, * t3, * new;

    next = save;
    if ((t1 = term(ttARITHMETIC_OPERATOR)) &&
        (t2 = operand()) &&
        (t3 = arithmeticExpressionTail())) {
        new = createNode("ArithmeticExpressionTail", NULL, 3);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        return new;
    }

    return createNode("ArithmeticExpressionTail", NULL, 0);
    return NULL;
}

Node* condition() {
    int save = next;
    Node* t1, * t2, * t3, * new;

    next = save;
    if ((t1 = expression()) &&
        (t2 = term(ttCOMPARISON_SIGN)) &&
        (t3 = expression())) {
        new = createNode("Condition", NULL, 3);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        return new;
    }

    next = save;
    if ((t1 = term(ttBRACKET_OPEN)) &&
        (t2 = condition()) &&
        (t3 = term(ttBRACKET_CLOSE))) {
        new = createNode("Condition", NULL, 3);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        new->nodes[2] = t3;
        return new;
    }
    return NULL;
}

Node* block() {
    int save = next;
    Node *t1,*new;

    next = save;
    if (t1 = indentedStatementSet()) {
        new = createNode("Block", NULL, 1);
        new->nodes[0] = t1;
        return new;
    }

    return NULL;
}

Node* indentedStatementSet() {
    int save = next;
    Node* t1, * t2, * new;

    next = save;
    if ((t1 = indentedStatement()) && (t2 = indentedStatementSet())) {
        new = createNode("IndentedStatementSet", NULL, 2);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        return new;
    }

    return createNode("IndentedStatementSet", NULL, 0);

    return NULL;
}

Node* indentedStatement() {
    int save = next;
    Node* t1, * t2, * new;

    next = save;
    if ((t1 = term(ttTAB)) && (t2 = indentedStatement())) {
        new = createNode("IndentedStatement", NULL, 2);
        new->nodes[0] = t1;
        new->nodes[1] = t2;
        return new;
    }

    if (t1 = statement()) {
        new = createNode("IndentedStatement", NULL, 2);
        new->nodes[0] = t1; 
        return new;
    }

    return NULL;
}

////// ParserFunctions //////

int main(void) {
    char* path;
    PToken tokenFlow;

    path = (char*)malloc(sizeof(char) * 256);
    printf("Enter FilePath:\n");
    scanf("%s", path);

    tokenFlow = getTokenFlowFromFile(path);
    next = 0;
    maxAvailable = 0;

    tree = program();

    if (tree == NULL) {
        printf("Unable To Parse");
    }
    else {
        if (arr[next].type != ttPROGRAM_END) {
            printf("Syntax error\n");
            errorToken();
        }
        else {
            printTree(tree, 0);
        }
    }

    fflush(stdin);
    getchar();

    free(tokenFlow);
    free(path);

    return 0;
}
