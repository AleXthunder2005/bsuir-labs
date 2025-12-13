<?php
class Table_builder {
    private $rows = [];
    private $attributes = []; //атрибуты для htlm таблицы (class, id, ...)

    public function __construct($attributes = []) {
        $this->attributes = $attributes;
    }

    public function add_row($cells = []) {  //добавить новую строку (массив ячеек)
        $this->rows[] = $cells;
        return $this;
    }

    public function build_table() {
        $table_attributes = '';
        foreach ($this->attributes as $name => $value) {
            $table_attributes .= " $name=\"$value\"";
        }

        $html = "<table$table_attributes>";

        foreach ($this->rows as $row) {
            $html .= "<tr>";

            foreach ($row as $cell) {
                //если это ячейка с атрибутами
                if (is_array($cell)) {
                    $value = $cell['value'] ?? '';
                    unset($cell['value']);

                    $td_attributes = '';
                    foreach ($cell as $name => $val) {
                        $td_attributes .= " $name=\"$val\"";
                    }
                    $html .= "<td$td_attributes>$value</td>";
                }
                //если это ячейка без атрибутов (только значение)
                else {
                    $html .= "<td>$cell</td>";
                }
            }

            $html .= "</tr>";
        }

        $html .= "</table>";
        return $html;
    }
}

// Пример
$table_builder = new Table_builder(['class' => 'data-table', 'border' => '1']);
$table_builder
    ->add_row(['Name', 'Age', 'City'])
    ->add_row(['John Doe', ['value' => '30', 'class' => 'age-cell', 'colspan' => '2']])
    ->add_row(['Jane Smith', '25', 'London']);

echo $table_builder->build_table();
