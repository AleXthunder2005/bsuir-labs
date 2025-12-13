export function analyze(ast) {
    const metrics = {
        // per-type (для отладки)
        variableWithInit: 0,
        expressionStatements: 0,
        forStatements: 0,
        foreachStatements: 0,
        ifStatements: 0,
        whileStatements: 0,
        switchStatements: 0,
        caseBranches: 0, // non-default cases (test !== null)
        breakStatements: 0,
        continueStatements: 0,
        returnStatements: 0,

        // grouped
        totalOperators: 0,
        branchingOperatorsCount: 0, // For + While + Foreach + If + (each non-default case)
        otherOperatorsCount: 0,

        // depth
        maxBranchingDepth: 0,

        // complexity
        relativeComplexity: 0,
    };

    // helper
    function updateMaxDepth(d) {
        if (d > metrics.maxBranchingDepth) metrics.maxBranchingDepth = d;
    }

    // single recursive traversal that computes counts and depth
    function traverse(node, currentDepth = 0) {
        if (!node) return;
        if (Array.isArray(node)) {
            for (const n of node) traverse(n, currentDepth);
            return;
        }
        if (typeof node !== 'object') return;

        switch (node.type) {
            case 'VariableDeclaration':
                if (node.init !== null && node.init !== undefined) metrics.variableWithInit++;
                if (node.init) traverse(node.init, currentDepth);
                break;

            case 'ExpressionStatement':
                metrics.expressionStatements++;
                if (node.expression) traverse(node.expression, currentDepth);
                break;

            case 'AssignmentExpression':
            case 'BinaryExpression':
                if (node.left) traverse(node.left, currentDepth);
                if (node.right) traverse(node.right, currentDepth);
                break;

            case 'CallExpression':
                if (node.callee) traverse(node.callee, currentDepth);
                if (node.arguments) traverse(node.arguments, currentDepth);
                break;

            case 'UpdateExpression':
                if (node.argument) traverse(node.argument, currentDepth);
                break;

            case 'BreakStatement':
                metrics.breakStatements++;
                break;

            case 'ContinueStatement':
                metrics.continueStatements++;
                break;

            case 'ReturnStatement':
                metrics.returnStatements++;
                if (node.argument) traverse(node.argument, currentDepth);
                break;

            case 'ForStatement': {
                metrics.forStatements++;
                // loop is a branching operator -> increases depth by 1
                const nextDepth = currentDepth + 1;
                updateMaxDepth(nextDepth);
                // init/test/update shouldn't increase depth (but traverse them)
                if (node.init) traverse(node.init, currentDepth);
                if (node.test) traverse(node.test, currentDepth);
                if (node.update) traverse(node.update, currentDepth);
                if (node.body) traverse(node.body, nextDepth);
                break;
            }

            case 'WhileStatement': {
                metrics.whileStatements++;
                const nextDepth = currentDepth + 1;
                updateMaxDepth(nextDepth);
                if (node.test) traverse(node.test, currentDepth);
                if (node.body) traverse(node.body, nextDepth);
                break;
            }

            case 'ForeachStatement': {
                metrics.foreachStatements++;
                const nextDepth = currentDepth + 1;
                updateMaxDepth(nextDepth);
                if (node.source) traverse(node.source, currentDepth);
                if (node.body) traverse(node.body, nextDepth);
                break;
            }

            case 'IfStatement': {
                metrics.ifStatements++;
                const nextDepth = currentDepth + 1;
                updateMaxDepth(nextDepth);
                if (node.test) traverse(node.test, currentDepth);
                if (node.consequent) traverse(node.consequent, nextDepth);
                if (node.alternate) traverse(node.alternate, nextDepth);
                break;
            }

            case 'SwitchStatement': {
                metrics.switchStatements++;
                const cases = Array.isArray(node.cases) ? node.cases : [];
                let nonDefault = 0;
                for (const c of cases) if (c && c.test !== null && c.test !== undefined) nonDefault++;
                metrics.caseBranches += nonDefault;

                // rule: switch with n non-default cases contributes (n-1) to depth
                const extra = Math.max(0, nonDefault - 1);
                const nextDepth = currentDepth + extra;
                updateMaxDepth(nextDepth);

                if (node.discriminant) traverse(node.discriminant, currentDepth);

                for (const c of cases) {
                    if (!c) continue;
                    if (c.test) traverse(c.test, currentDepth);
                    if (c.consequent) {
                        if (Array.isArray(c.consequent)) {
                            for (const s of c.consequent) traverse(s, nextDepth);
                        } else {
                            traverse(c.consequent, nextDepth);
                        }
                    }
                }
                break;
            }

            case 'BlockStatement':
            case 'Program': {
                const body = node.body || node;
                for (const s of body) traverse(s, currentDepth);
                break;
            }

            case 'SwitchCase': {
                if (node.test) {
                    if (node.test !== null && node.test !== undefined) metrics.caseBranches++;
                    traverse(node.test, currentDepth);
                }
                if (node.consequent) traverse(node.consequent, currentDepth);
                break;
            }

            default: {
                for (const k of Object.keys(node)) {
                    const v = node[k];
                    if (v && typeof v === 'object') traverse(v, currentDepth);
                }
                break;
            }
        }
    } // traverse

    // run traversal from program root
    traverse(ast, 0);

    metrics.totalOperators =
        metrics.variableWithInit +
        metrics.expressionStatements +
        (2 * metrics.forStatements) + // <-- здесь учтено требование: for = 3
        metrics.ifStatements +
        metrics.whileStatements +
        metrics.caseBranches +
        metrics.breakStatements +
        metrics.foreachStatements +
        metrics.continueStatements +
        metrics.returnStatements;

    metrics.branchingOperatorsCount =
        metrics.forStatements +
        metrics.whileStatements +
        metrics.foreachStatements +
        metrics.ifStatements +
        metrics.caseBranches;

    metrics.otherOperatorsCount = metrics.totalOperators - metrics.branchingOperatorsCount;

    metrics.relativeComplexity = metrics.totalOperators === 0 ? 0 : (metrics.branchingOperatorsCount / metrics.totalOperators);

    metrics.conditionalEquivalentCount = metrics.ifStatements + metrics.caseBranches;

    return metrics;
}
