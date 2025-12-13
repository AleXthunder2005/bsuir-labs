const tokenSpecs = [
    ['WHITESPACE', /^\s+/],
    ['COMMENT', /^\/\/[^\n]*/],
    ['COMMENT', /^\/\*[\s\S]*?\*\//],
    ['STRING', /^@"[^"]*"|^"((\\.|[^"\\])*)"/],
    ['CHAR', /^'([^'\\]|\\.)'/],
    ['NUMBER', /^\d+(\.\d+)?([fFdDmM])?/],
    ['KEYWORD', /^(class|namespace|using|public|private|static|void|int|float|double|string|bool|var|new|return|if|else|switch|case|default|for|while|foreach|in|break|continue|true|false|null)\b/],
    ['IDENT', /^[A-Za-z_][A-Za-z0-9_]*/],
    ['OP', /^(\+\+|--|==|!=|<=|>=|\+=|-=|\*=|\/=|&&|\|\||<<|>>|=>)/],
    ['SYMBOL', /^[\{\}\(\)\[\];,:\.<>=%\+\-\*\/\&\|\!\?]/],
];

function getTokens(input) {
    const tokens = [];
    let i = 0;
    while (i < input.length) {
        let matched = false;
        for (const [type, regex] of tokenSpecs) {
            const slice = input.slice(i);
            const m = regex.exec(slice);
            if (m) {
                matched = true;
                const text = m[0];
                if (type !== 'WHITESPACE' && type !== 'COMMENT') {
                    tokens.push({ type, text, pos: i });
                }
                i += text.length;
                break;
            }
        }
        if (!matched) {
            tokens.push({ type: 'UNKNOWN', text: input[i], pos: i });
            i++;
        }
    }
    tokens.push({ type: 'EOF', text: '', pos: i });
    return tokens;
}


export function lex(sourceCode){
    const classSplitter = "class Program";
    const startClassIndex = sourceCode.indexOf(classSplitter);
    let classContent = sourceCode.substring(startClassIndex + classSplitter.length);

    const mainSplitter = /void\s+main\s*\(\)/i;
    const mainMatch = classContent.match(mainSplitter);
    const startMainIndex = mainMatch.index;
    let mainContent = classContent.substring(startMainIndex + mainMatch[0].length).trim();

    return getTokens(mainContent);
}