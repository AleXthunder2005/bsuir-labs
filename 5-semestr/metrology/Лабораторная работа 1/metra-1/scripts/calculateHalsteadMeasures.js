const REGULAR_EXPRESSIONS = {
    //operands
    STRING_LITERAL: /(['`"])(.*?)\1/g,                //сначала удаляем строки, потом ключ слова, потом идентификаторы
    NUMBER_LITERAL: /\b\d+(\.\d+)?(e[+-]?\d+)?\b/ig,
    BOOLEAN_LITERAL: /\b(true|false)\b/g,
    NULL_LITERAL: /\b(null)\b/g,
    IDENTIFICATOR: /[a-zA-Z_][a-zA-Z0-9_]*/g,

    //operators
    //functions
    FUNCTION_CALL: null,
    FUNCTION_DECLARATION: null,
    TYPE_CASTING: null,

    //conditionals
    IF: /\bif\b(\s)*\(/g,
    SWITCH: /\bswitch\b(\s)*\(/g,

    //cycles
    FOR: /\bfor\b(\s)*\(/g,
    WHILE: /\bwhile\b(\s)*\(/g,
    DO: /\bdo\b/g,
    FOREACH: /\bforeach\b(\s)*\(/g,

    //error boundaries
    TRY: /\btry\b/g,
    CATCH: /\bcatch\b(\s)*\(/g,
    EMBEDDED_OPERATORS: /\bbreak\b|\bcontinue\b|\breturn\b|\bthrow\b|\bnew\b/g,


    //arithmetic operators
    ARITHMETIC_OPERATOR: /[+*%\-/|&^!]/g,
    LOGIC_OPERATOR: /\|\||\?\?|&&/g,
    INCREMENT_DECREMENT: /\+\+|--/g,
    ASSIGN_OPERATOR: /=|[+\-*/%&|^]=/g,
    COMPOSITE_COMPARE_OPERATOR: /[=!><]=/g,
    SIMPLE_COMPARE_OPERATOR: /[><]/g,
    COMPARE_KEYWORDS: /\bas\b|\bis\b/g,
    SPREAD_OPERATOR: /\.\.\./g,
    OBJECT_ACCESSING: /\?\.|\./g,
    TERNARY_OPERATOR: /(\w+)\s*\?\s*(.*?)\s*:\s*(.*?)/g,

    //brackets
    FIGURE_BRACKETS: /{/g,
    ROUND_BRACKETS: /\(/g,

    //separators
    SEPARATOR: /[;:,]/g,

    //others
    TYPE_KEYWORDS: /\b(int|float|double|bool|char|string|void|decimal|long|object|var|dynamic)\b/g,
    CLASS_DECLARATION:/\b[A-Z][a-zA-Z0-9_]* \b/g,
    METHOD_KEYWORDS: /\b(static|public|protected|private|internal|const)\b/g,
    OTHER_KEYWORDS: /\b(ref|out|in|yield)\b/g,
    UNNECESSARY_KEYWORDS: /\belse|case|finally|default\b/g,
}

//инициализация REGULAR_EXPRESSIONS
REGULAR_EXPRESSIONS.FUNCTION_CALL = new RegExp(`(${REGULAR_EXPRESSIONS.IDENTIFICATOR.source})\\s*\\(`, "g");
REGULAR_EXPRESSIONS.FUNCTION_DECLARATION = new RegExp(`${REGULAR_EXPRESSIONS.TYPE_KEYWORDS.source}\\s*${REGULAR_EXPRESSIONS.FUNCTION_CALL.source}`, "g");
REGULAR_EXPRESSIONS.TYPE_CASTING = new RegExp(`\\((\\s*)${REGULAR_EXPRESSIONS.TYPE_KEYWORDS.source}(\\s*)\\)`, "g");

export function calculateHalsteadMeasures(sourceCode) {
    const data = {
        operators: {

        },
        operands: {

        },
        addOperator(operator) {
            const currValue = this.operators[operator];
            this.operators[operator] = currValue ? currValue+1 : 1;
        },
        addOperand(operand) {
            const currValue = this.operands[operand];
            this.operands[operand] = currValue ? currValue+1 : 1;
        },
        addOperandsList (operands ) {
            operands.forEach(operand => {data.addOperand(operand);});
        },
        addOperatorsList (operators) {
            operators.forEach(operator => {data.addOperator(operator);});
        }
    };

    const splitter = "class Program";
    const startClassIndex = sourceCode.indexOf(splitter);
    let classContent = sourceCode.substring(startClassIndex + splitter.length);


    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.STRING_LITERAL, false) //удаляем строковые литералы
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.NUMBER_LITERAL, false) //обрабатываем числовые литералы
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.BOOLEAN_LITERAL, false) //обрабатываем boolean литералы
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.NULL_LITERAL, false) //обрабатываем null литералы

    classContent = processRegExpWithConcat(classContent, data, REGULAR_EXPRESSIONS.TRY, "-catch-finally", true) //обрабатываем try catch
    classContent = deleteRegExp(classContent, REGULAR_EXPRESSIONS.CATCH)

    classContent = deleteRegExp(classContent, REGULAR_EXPRESSIONS.FUNCTION_DECLARATION) //удаляем объявления функций

    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.TYPE_CASTING, true) //обрабатываем приведение типа

    //удаляем ключевые слова не считая их
    classContent = deleteRegExp(classContent, REGULAR_EXPRESSIONS.TYPE_KEYWORDS)
    classContent = deleteRegExp(classContent, REGULAR_EXPRESSIONS.METHOD_KEYWORDS)
    classContent = deleteRegExp(classContent, REGULAR_EXPRESSIONS.OTHER_KEYWORDS)
    classContent = deleteRegExp(classContent, REGULAR_EXPRESSIONS.UNNECESSARY_KEYWORDS)

    //обработка ключевых слов в логических выражениях
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.COMPARE_KEYWORDS, true)

    //обработка if-else
    classContent = processRegExpWithConcat(classContent, data, REGULAR_EXPRESSIONS.IF,"-else", true, 2)

    //обработка while и do-while
    const doWhileCycleCount = (classContent.match(REGULAR_EXPRESSIONS.DO) ?? []).length;
    classContent = processRegExpWithConcat(classContent, data, REGULAR_EXPRESSIONS.DO,"-while", true)
    const whileCycles = classContent.match(REGULAR_EXPRESSIONS.WHILE) ?? [];
    const resultWhileCycles = whileCycles.map((match) => match.slice(0, match.length-2));
    data.addOperatorsList(resultWhileCycles.slice(0, resultWhileCycles.length - doWhileCycleCount));
    classContent = deleteRegExp(classContent, REGULAR_EXPRESSIONS.WHILE)

    //обработка switch-case
    classContent = processRegExpWithConcat(classContent, data, REGULAR_EXPRESSIONS.SWITCH,"-case-default", true, 2)

    //обработка for
    classContent = processRegExpWithConcat(classContent, data, REGULAR_EXPRESSIONS.FOR,"", true, 2);

    //обработка foreach
    classContent = processRegExpWithConcat(classContent, data, REGULAR_EXPRESSIONS.FOREACH,"", true, 2);

    //обработка вызовов функций
    classContent = processRegExpWithConcat(classContent, data, REGULAR_EXPRESSIONS.FUNCTION_CALL,")", true);

    //Удаляем типы классы
    classContent = deleteRegExp(classContent, REGULAR_EXPRESSIONS.CLASS_DECLARATION);

    //обрабатываем spread оператор, символы разделители, обращение к объектам
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.SPREAD_OPERATOR, true);
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.OBJECT_ACCESSING, true);
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.SEPARATOR, true);

    //обработка return, break, continue, throw ...
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.EMBEDDED_OPERATORS, true);

    //обработка идентификаторов
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.IDENTIFICATOR, false);

    //обработка арифметических операторов
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.INCREMENT_DECREMENT, true);
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.COMPOSITE_COMPARE_OPERATOR, true);
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.SIMPLE_COMPARE_OPERATOR, true);
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.ASSIGN_OPERATOR, true);
    classContent = processRegExp(classContent, data, REGULAR_EXPRESSIONS.ARITHMETIC_OPERATOR, true);

    //обработка оставшихся разделителей
    classContent = processRegExpWithConcat(classContent, data, REGULAR_EXPRESSIONS.ROUND_BRACKETS,")", true);
    processRegExpWithConcat(classContent, data, REGULAR_EXPRESSIONS.FIGURE_BRACKETS,"}", true);
    return data;
}

function processRegExp(content, data, regexp, isOperator = true) {
    const matches = content.match(regexp) ?? [];
    isOperator ? data.addOperatorsList(matches) : data.addOperandsList(matches);
    return content.replaceAll(regexp, " ");
}

function processRegExpWithConcat(content, data, regexp, additionalString,  isOperator = true, erasedLetterCount = 0) {
    const matches = content.match(regexp) ?? [];
    const resultMatches = matches.map((match) => match.slice(0, match.length-erasedLetterCount).concat(additionalString));
    isOperator ? data.addOperatorsList(resultMatches) : data.addOperandsList(resultMatches);
    return content.replaceAll(regexp, " ");
}

function deleteRegExp(content, regexp) {
    return content.replaceAll(regexp, " ");
}
