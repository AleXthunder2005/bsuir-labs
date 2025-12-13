export class Parser {
    constructor(tokens) {
        this.tokens = tokens || [];
        this.pos = 0;
    }

    peek(n = 0) { return this.tokens[this.pos + n] || { type: 'EOF', text: '' }; }
    next() { return this.tokens[this.pos++] || { type: 'EOF', text: '' }; }
    match(type, text = null) {
        const t = this.peek();
        if (!t || t.type !== type) return false;
        if (text && t.text !== text) return false;
        this.pos++;
        return true;
    }
    expect(type, text = null) {
        const t = this.peek();
        if (!t || t.type !== type || (text && t.text !== text)) {
            throw new Error(`Expected ${type}${text ? ' '+text : ''}, got ${t.type} '${t.text}' at ${this.pos}`);
        }
        return this.next();
    }
    isWord(word) { return this.peek().text.toLowerCase() === word.toLowerCase(); }
    consume(word) { if (this.isWord(word)) return this.next(); throw new Error(`Expected '${word}', got '${this.peek().text}'`); }

    // --- Точка входа ---
    parseProgram() {
        const body = [];
        while (this.peek().type !== 'EOF') {
            // Пропускаем лишние закрывающие фигурные скобки на верхнем уровне,
            // чтобы они не становились Unknown / ExpressionStatement.
            if (this.peek().type === 'SYMBOL' && this.peek().text === '}') {
                this.next(); // просто пропустить
                continue;
            }

            const node = this.parseStatement();
            // Если parseStatement по какой-то причине вернул null — пропускаем токен
            if (node) body.push(node);
            else {
                // защита от зацикливания: съедаем один токен
                this.next();
            }
        }
        return { type: 'Program', body };
    }

    parseBlock() {
        this.expect('SYMBOL', '{');
        const body = [];
        while (!(this.peek().type === 'SYMBOL' && this.peek().text === '}') && this.peek().type !== 'EOF') {
            const stmt = this.parseStatement();
            if (stmt) body.push(stmt);
            else {
                // если parseStatement вернул null — защита
                if (this.peek().type === 'SYMBOL' && this.peek().text === '}') break;
                this.next();
            }
        }
        this.expect('SYMBOL', '}');
        return { type: 'BlockStatement', body };
    }

    parseStatement() {
        if (this.isWord('if')) return this.parseIf();
        if (this.isWord('switch')) return this.parseSwitch();
        if (this.isWord('for')) return this.parseFor();
        if (this.isWord('while')) return this.parseWhile();
        if (this.isWord('foreach')) return this.parseForeach();
        if (this.isWord('return')) return this.parseReturn();
        if (this.isWord('break')) { this.next(); this.match('SYMBOL',';'); return { type: 'BreakStatement' }; }
        if (this.isWord('continue')) { this.next(); this.match('SYMBOL',';'); return { type: 'ContinueStatement' }; }
        if (this.peek().type === 'SYMBOL' && this.peek().text === '{') return this.parseBlock();
        if (this.isDeclarationLookahead()) return this.parseVariableDeclaration(true);
        return this.parseExpressionStatement();
    }

    parseIf() {
        this.consume('if'); this.expect('SYMBOL', '(');
        const test = this.parseExpression();
        this.expect('SYMBOL', ')');
        const consequent = this.parseStatement();
        let alternate = null;
        if (this.isWord('else')) { this.next(); alternate = this.parseStatement(); }
        return { type: 'IfStatement', test, consequent, alternate };
    }

    parseSwitch() {
        this.consume('switch'); this.expect('SYMBOL', '(');
        const discriminant = this.parseExpression();
        this.expect('SYMBOL', ')'); this.expect('SYMBOL', '{');
        const cases = [];
        while (!(this.peek().type === 'SYMBOL' && this.peek().text === '}') && this.peek().type !== 'EOF') {
            if (this.isWord('case') || this.isWord('default')) {
                const isDefault = this.isWord('default');
                this.next();
                const test = isDefault ? null : this.parseExpression();
                this.expect('SYMBOL', ':');
                const consequent = [];
                while (!(this.isWord('case') || this.isWord('default') || (this.peek().type === 'SYMBOL' && this.peek().text === '}')) && this.peek().type !== 'EOF') {
                    const s = this.parseStatement();
                    if (s) consequent.push(s); else break;
                }
                cases.push({ type: 'SwitchCase', test, consequent });
            } else {
                // skip stray
                this.next();
            }
        }
        this.expect('SYMBOL', '}');
        return { type: 'SwitchStatement', discriminant, cases };
    }

    parseFor() {
        this.consume('for'); this.expect('SYMBOL', '(');
        const init = this.parseForInit();
        this.expect('SYMBOL', ';');
        const test = this.parseExpressionOrEmpty();
        this.expect('SYMBOL', ';');
        const update = this.parseExpressionOrEmpty();
        this.expect('SYMBOL', ')');
        const body = this.parseStatement();
        return { type: 'ForStatement', init, test, update, body };
    }

    parseForInit() {
        if (this.peek().type === 'SYMBOL' && this.peek().text === ';') return null;
        if (this.isDeclarationLookahead()) return this.parseVariableDeclaration(false);
        return this.parseExpression();
    }

    parseWhile() {
        this.consume('while'); this.expect('SYMBOL', '(');
        const test = this.parseExpression();
        this.expect('SYMBOL', ')');
        const body = this.parseStatement();
        return { type: 'WhileStatement', test, body };
    }

    parseForeach() {
        this.consume('foreach'); this.expect('SYMBOL', '(');
        const varType = this.parseType();
        const id = this.expect('IDENT').text;
        // allow 'in' as KEYWORD or IDENT with lowercased text depending on lexer
        if (this.peek().text.toLowerCase() === 'in') this.next(); else this.consume('in');
        const source = this.parseExpression();
        this.expect('SYMBOL', ')');
        const body = this.parseStatement();
        return { type: 'ForeachStatement', varType, id, source, body };
    }

    parseReturn() {
        this.consume('return');
        const arg = (this.peek().type === 'SYMBOL' && this.peek().text === ';') ? null : this.parseExpression();
        this.match('SYMBOL', ';');
        return { type: 'ReturnStatement', argument: arg };
    }

    // Declarations lookahead: Type IDENT ...
    isDeclarationLookahead() {
        const t0 = this.peek();
        const t1 = this.tokens[this.pos + 1];
        return (t0 && (t0.type === 'IDENT' || t0.type === 'KEYWORD')) && t1 && t1.type === 'IDENT';
    }

    parseType() {
        const parts = [this.next().text];
        while (this.peek().text === '.' && this.tokens[this.pos + 1] && this.tokens[this.pos + 1].type === 'IDENT') {
            parts.push(this.next().text, this.next().text);
        }
        if (this.peek().text === '<') {
            let depth = 0, buf = '';
            do {
                const t = this.next();
                buf += t.text;
                if (t.text === '<') depth++;
                if (t.text === '>') depth--;
            } while (depth > 0 && this.peek().type !== 'EOF');
            parts.push(buf);
        }
        while (this.peek().text === '[' && this.tokens[this.pos + 1] && this.tokens[this.pos + 1].text === ']') {
            this.next(); this.next(); parts.push('[]');
        }
        return parts.join('');
    }

    parseVariableDeclaration(consumeSemicolon) {
        const varType = this.parseType();
        const name = this.expect('IDENT').text;
        let init = null;
        if (this.match('SYMBOL', '=')) init = this.parseExpression();
        if (consumeSemicolon) this.match('SYMBOL', ';');
        return { type: 'VariableDeclaration', varType, id: name, init };
    }

    parseExpressionOrEmpty() {
        if (this.peek().type === 'SYMBOL' && (this.peek().text === ';' || this.peek().text === ')')) return null;
        return this.parseExpression();
    }

    // ---- FIX: operator classification (correctly distinguish == vs =) ----
    parseExpression() {
        let left = this.parsePrimary();
        // note: we check peek().text against known operators (both OP and SYMBOL tokens)
        while (true) {
            const opTxt = this.peek().text;
            if (!opTxt) break;
            // operators we accept here:
            const ops = ['==','!=','<=','>=','<','>','+','-','*','/','%','=','+=','-=','*=','/=','&&','||'];
            if (!ops.includes(opTxt)) break;
            const op = this.next().text;
            const right = this.parsePrimary();
            // assignment only when op is exactly '=' or one of compound assignments
            const assignmentOps = ['=','+=','-=','*=','/='];
            const nodeType = assignmentOps.includes(op) ? 'AssignmentExpression' : 'BinaryExpression';
            left = { type: nodeType, operator: op, left, right };
        }
        return left;
    }

    parsePrimary() {
        const t = this.peek();
        if (t.type === 'NUMBER' || t.type === 'STRING' || t.type === 'CHAR') {
            this.next();
            return { type: 'Literal', value: t.text };
        }
        if (t.type === 'IDENT' || t.type === 'KEYWORD') {
            let node = { type: 'Identifier', name: this.next().text };
            node = this.maybeCallOrMember(node);
            return node;
        }
        if (t.type === 'SYMBOL' && t.text === '(') {
            this.next();
            const expr = this.parseExpression();
            this.expect('SYMBOL', ')');
            return expr;
        }
        // если встретили '}' внутри выражения — вернуть null-подобный узел
        if (t.type === 'SYMBOL' && t.text === '}') {
            // don't consume here — let caller decide; but in practice parseProgram skips stray '}'.
            return { type: 'Unknown', value: this.next().text };
        }
        return { type: 'Unknown', value: this.next().text };
    }

    maybeCallOrMember(node) {
        while (true) {
            const t = this.peek();
            if (t.type === 'SYMBOL' && t.text === '.') {
                this.next();
                const prop = this.expect('IDENT').text;
                node = { type: 'MemberExpression', object: node, property: prop };
                continue;
            }
            if (t.type === 'SYMBOL' && t.text === '(') {
                this.next();
                const args = [];
                if (!(this.peek().type === 'SYMBOL' && this.peek().text === ')')) {
                    args.push(this.parseExpression());
                    while (this.peek().type === 'SYMBOL' && this.peek().text === ',') { this.next(); args.push(this.parseExpression()); }
                }
                this.expect('SYMBOL', ')');
                node = { type: 'CallExpression', callee: node, arguments: args };
                continue;
            }
            if (t.type === 'OP' && (t.text === '++' || t.text === '--')) {
                node = { type: 'UpdateExpression', operator: this.next().text, argument: node, prefix: false };
                continue;
            }
            break;
        }
        return node;
    }

    parseExpressionStatement() {
        const expr = this.parseExpression();
        this.match('SYMBOL', ';');
        return { type: 'ExpressionStatement', expression: expr };
    }
}
