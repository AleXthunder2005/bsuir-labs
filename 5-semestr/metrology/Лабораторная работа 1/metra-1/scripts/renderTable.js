export function renderTable(data = {}) {
    const operators = data.operators || {};
    const operands = data.operands || {};

    let operatorsTableBody = '';
    let operandsTableBody = '';
    let counter = 1;

    // Measures for operators
    const uniqueOperators = Object.keys(operators).length;
    const totalOperators = Object.values(operators).reduce((sum, value) => sum + value, 0);

    // Measures for operands
    const uniqueOperands = Object.keys(operands).length;
    const totalOperands = Object.values(operands).reduce((sum, value) => sum + value, 0);

    // Sum
    const totalAll = totalOperators + totalOperands;

    // V for program
    const programVocabulary = uniqueOperators + uniqueOperands;
    const programVolume = totalAll * Math.log2(programVocabulary);

    // For operators
    for (const key in operators) {
        operatorsTableBody += renderRow('<td>', counter++, key, operators[key]);
    }

    counter = 1;

    // For operands
    for (const key in operands) {
        operandsTableBody += renderRow('<td>', counter++, key, operands[key]);
    }

    return `<table class="halstead-measures__table">
                <thead class="halstead-measures__table-head">
                    ${renderRow('<th>', 'j', 'Оператор', 'f<sub>1j</sub>')}
                </thead>
                <tbody class="halstead-measures__table-body">
                    ${operatorsTableBody}
                </tbody>
                <tfoot class="halstead-measures__table-foot">
                    ${renderRow('<td>', '', 'Уникальные операторы (η<sub>1</sub>)', uniqueOperators)}
                    ${renderRow('<td>', '', 'Общее количество операторов (N<sub>1</sub>)', totalOperators)}
                </tfoot>
            </table>
            <table class="halstead-measures__table">
                <thead class="halstead-measures__table-head">
                    ${renderRow('<th>', 'j', 'Операнд', 'f<sub>2j</sub>')}
                </thead>
                <tbody class="halstead-measures__table-body">
                    ${operandsTableBody}
                </tbody>
                <tfoot class="halstead-measures__table-foot">
                    ${renderRow('<td>', '', 'Уникальные операнды (η<sub>2</sub>)', uniqueOperands)}
                    ${renderRow('<td>', '', 'Общее количество операндов (N<sub>2</sub>)', totalOperands)}
                    ${renderRow('<td>', '', 'Общая длина программы (N)', totalAll)}
                    ${renderRow('<td>', '', 'Словарь программы (η)', programVocabulary)}
                    ${renderRow('<td>', '', 'Объем программы (V)', programVolume.toFixed(2))}
                </tfoot>
            </table>`;
}

function renderRow(tag, ...cellsValue) {
    return `<tr>${cellsValue.map(cellValue => `${tag}${cellValue}${getClosedTag(tag)}`).join('')}</tr>`;
}

function getClosedTag(tag) {
    return `</${tag.slice(1)}`;
}