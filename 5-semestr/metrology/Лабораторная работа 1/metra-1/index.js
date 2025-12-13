import {calculateHalsteadMeasures} from "./scripts/calculateHalsteadMeasures.js";
import {renderTable} from "./scripts/renderTable.js";

const tableContainer = document.querySelector('.halstead-measures__container');
tableContainer.innerHTML = renderTable();

const codeForm = document.querySelector('.code-form');

codeForm.onsubmit = (e) => {
    e.preventDefault();
    const formData = new FormData(codeForm);
    const data = calculateHalsteadMeasures(formData.get("code"));
    tableContainer.innerHTML = renderTable(data);
}
