export function renderTable(metrics = {}) {
    const absoluteComplexity = Number(metrics.absoluteComplexity) || 0;
    const totalOperators = Number(metrics.totalOperators) || 0;
    const relativeComplexity = absoluteComplexity ? 1 - (totalOperators - 1) / absoluteComplexity : 0;

    const rows = [
        ['Абсолютная граничная сложность программы (Sa)', absoluteComplexity],
        ['Общее кол-во операторов (v)', totalOperators],
        ['Относительная граничная сложность программы (So)', `${relativeComplexity} (${(relativeComplexity * 100).toFixed(3)}%)`]
    ];

    const header = renderRow('<th>', 'Метрика', 'Значение');
    const body = rows.map(([name, val]) => renderRow('<td>', name, val)).join('\n');

    return `
        <table class="metrics-table">
          <colgroup class="metrics-table__columns">
            <col class="metrics-table__metric-col"> 
            <col class="metrics-table__value-col">
          </colgroup>
            <thead class="metrics-table__head">
                ${header}
            </thead>
            <tbody class="metrics-table__body">
                ${body}
            </tbody>
        </table>
    `;
}

function renderRow(tag, ...cellsValue) {
    return `<tr>${cellsValue.map(cellValue => `${tag}${cellValue}${getClosedTag(tag)}`).join('')}</tr>`;
}

function getClosedTag(tag) {
    return `</${tag.slice(1)}`;
}