export function renderTable(metrics = {}) {
    const branching = Number(metrics.branchingOperatorsCount) || 0;
    const total = Number(metrics.totalOperators) || 0;
    const depth = Number(metrics.maxBranchingDepth) - 1 || 0;

    const rel = (typeof metrics.relativeComplexity === 'number')
        ? metrics.relativeComplexity
        : (total === 0 ? 0 : branching / total);

    const relRatio = rel.toFixed(3);
    const relPercent = (rel * 100).toFixed(2) + '%';

    const rows = [
        ['Абсолютная сложность программы (CL))', branching],
        ['Общее кол-во операторов', total],
        ['Относительная сложность программы (cl)', `${relRatio} (${relPercent})`],
        ['Максимальный уровень вложенности (CLI)', depth]
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