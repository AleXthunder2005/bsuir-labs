function isOperatorNode(node) {
    if (!node || typeof node !== 'object') return false;
    switch (node.type) {
        case 'VariableDeclaration':
            return (node.init !== null && node.init !== undefined);
        case 'ExpressionStatement':
        case 'ForStatement':
        case 'WhileStatement':
        case 'ForeachStatement':
        case 'IfStatement':
        case 'BreakStatement':
        case 'ContinueStatement':
        case 'ReturnStatement':
            return true;
        case 'SwitchCase':
            return (node.test !== null && node.test !== undefined); // non-default case only
        default:
            return false;
    }
}

const createOperatorsCalculator = function () {
    let totalOperators = 0;
    return {
        walk: function walk(node) {
            if (!node) return;
            if (Array.isArray(node)) {
                for (const n of node) walk(n);
                return;
            }
            if (typeof node !== 'object') return;

            if (isOperatorNode(node)) {
                // Special rule: ForStatement counts as 2 operators
                if (node.type === 'ForStatement') {
                    totalOperators += 2;
                } else if (node.type === 'SwitchStatement') {
                    totalOperators += 0;
                }
                else {
                    totalOperators += 1;
                }
            }

            // Recurse into children (cover all possible child properties)
            switch (node.type) {
                case 'Program':
                case 'BlockStatement':
                    if (node.body) walk(node.body);
                    break;

                case 'IfStatement':
                    if (node.test) walk(node.test);
                    if (node.consequent) walk(node.consequent);
                    if (node.alternate) walk(node.alternate);
                    break;

                case 'ForStatement':
                    if (node.init) walk(node.init);
                    if (node.test) walk(node.test);
                    if (node.update) walk(node.update);
                    if (node.body) walk(node.body);
                    break;

                case 'WhileStatement':
                    if (node.test) walk(node.test);
                    if (node.body) walk(node.body);
                    break;

                case 'ForeachStatement':
                    if (node.source) walk(node.source);
                    if (node.body) walk(node.body);
                    break;

                case 'SwitchStatement':
                    if (node.discriminant) walk(node.discriminant);
                    if (Array.isArray(node.cases)) {
                        for (const c of node.cases) {
                            walk(c);
                        }
                    }
                    break;

                case 'SwitchCase':
                    if (node.test) walk(node.test);
                    if (node.consequent) walk(node.consequent);
                    break;

                case 'ExpressionStatement':
                    if (node.expression) walk(node.expression);
                    break;
                case 'AssignmentExpression':
                case 'BinaryExpression':
                    if (node.left) walk(node.left);
                    if (node.right) walk(node.right);
                    break;
                case 'CallExpression':
                    if (node.callee) walk(node.callee);
                    if (node.arguments) walk(node.arguments);
                    break;
                case 'MemberExpression':
                    if (node.object) walk(node.object);
                    break;
                case 'UpdateExpression':
                    if (node.argument) walk(node.argument);
                    break;

                default:
                    break;
            }
        },
        getTotalOperators: () => totalOperators
    }
}

const calculateAbcoluteComplexity = function (ast) {
    const complexities = [];

    function walk(node) {
        if (!node) return;
        if (Array.isArray(node)) {
            for (const n of node) walk(n);
            return;
        }
        if (typeof node !== 'object') return;

        if (isOperatorNode(node)) {
            if (node.type !== 'SwitchStatement') {
                complexities.push({complexity: calculateCorrectedVertexComplexity(node), node: node});
            }

            if (node.type === 'ForStatement') {
                complexities.push({complexity: 1, node: {type: "ForUpdateExpression"}});
            }

        }

        // Recurse into children (cover all possible child properties)
        switch (node.type) {
            case 'Program':
            case 'BlockStatement':
                if (node.body) walk(node.body);
                break;

            case 'IfStatement':
                if (node.test) walk(node.test);
                if (node.consequent) walk(node.consequent);
                if (node.alternate) walk(node.alternate);
                break;

            case 'ForStatement':
                if (node.init) walk(node.init);
                if (node.test) walk(node.test);
                if (node.update) walk(node.update);
                if (node.body) walk(node.body);
                break;

            case 'WhileStatement':
                if (node.test) walk(node.test);
                if (node.body) walk(node.body);
                break;

            case 'ForeachStatement':
                if (node.source) walk(node.source);
                if (node.body) walk(node.body);
                break;

            case 'SwitchStatement':
                if (node.discriminant) walk(node.discriminant);
                if (Array.isArray(node.cases)) {
                    for (const c of node.cases) {
                        walk(c);
                    }
                }
                break;

            case 'SwitchCase':
                if (node.test) walk(node.test);
                if (node.consequent) walk(node.consequent);
                break;

            case 'ExpressionStatement':
                if (node.expression) walk(node.expression);
                break;
            case 'AssignmentExpression':
            case 'BinaryExpression':
                if (node.left) walk(node.left);
                if (node.right) walk(node.right);
                break;
            case 'CallExpression':
                if (node.callee) walk(node.callee);
                if (node.arguments) walk(node.arguments);
                break;
            case 'MemberExpression':
                if (node.object) walk(node.object);
                break;
            case 'UpdateExpression':
                if (node.argument) walk(node.argument);
                break;

            default:
                break;
        }
    }

    walk(ast);
    console.log(complexities);
    let absoluteComplexity = complexities.reduce((sum, val) => sum + val.complexity, 0);
    return absoluteComplexity + 1; //потому что вершина НАЧАЛО является принимающей
}

export function analyze(ast) {
    const totalCalculator = createOperatorsCalculator();
    totalCalculator.walk(ast);
    const totalOperators = totalCalculator.getTotalOperators();

    let absoluteComplexity = calculateAbcoluteComplexity(ast);

    return {totalOperators, absoluteComplexity};
}


export function calculateCorrectedVertexComplexity(node) {
    if (!node) return 0;
    const operatorsCalculator = createOperatorsCalculator();

    // Если передан массив узлов — обходим каждый
    if (Array.isArray(node)) {
        let sum = 0;
        for (const n of node) operatorsCalculator.walk(n);
        return sum;
    }
    // Защитный случай: если node не объект — 0
    if (typeof node !== 'object') return 0;

    switch (node.type) {
        //для ифов - количество операторов + 1 (нижняя граница подграфа)
        case 'IfStatement': {
            if (node.consequent) operatorsCalculator.walk(node.consequent);
            if (node.alternate) operatorsCalculator.walk(node.alternate);
            return operatorsCalculator.getTotalOperators() + 1;
        }

        //для циклов - количество операторов + 2
        case 'ForStatement':
            if (node.body) operatorsCalculator.walk(node.body);
            return operatorsCalculator.getTotalOperators() + 3;
        case 'WhileStatement':
        case 'ForeachStatement': {
            if (node.body) operatorsCalculator.walk(node.body);
            return operatorsCalculator.getTotalOperators() + 2;
        }

        case 'SwitchStatement': {
            const cases = Array.isArray(node.cases) ? node.cases : [];
            for (const c of cases) {
                if (!c) continue;
                if (c.consequent) operatorsCalculator.walk(c.consequent);
            }
            return operatorsCalculator.getTotalOperators() + 1;
        }

        case 'SwitchCase': {
            if (node.consequent) operatorsCalculator.walk(node.consequent);
            let casesCount = 0;
            let currNode = node.alternate;
            while (currNode) {
                operatorsCalculator.walk(currNode);
                casesCount++;
                currNode = currNode.alternate;
            }
            return operatorsCalculator.getTotalOperators() + 1;
        }

        // Для операторов, которые содержат другие выражения/узлы, но по нашим правилам не являются ветвлением,
        // считаем их как атомарные операторы = 1 (например ExpressionStatement, ReturnStatement, VariableDeclaration и т.д.)
        default:
            return 1;
    }

    // return operatorsCalculator
}
