import {lex} from './scripts/lexer.mjs'
import {Parser} from "./scripts/parser.mjs"
import {analyze} from "./scripts/analyzer.mjs";
import {renderTable} from "./scripts/renderTable.mjs";

const tableContainer = document.querySelector('.jilb-measures__container');
tableContainer.innerHTML = renderTable();

const codeForm = document.querySelector('.code-form');
codeForm.onsubmit = (e) => {
    e.preventDefault();
    const formData = new FormData(codeForm);
    const tokens = lex(formData.get("code"));
    tableContainer.innerHTML = renderTable(analyze(new Parser(tokens).parseProgram()));
}
