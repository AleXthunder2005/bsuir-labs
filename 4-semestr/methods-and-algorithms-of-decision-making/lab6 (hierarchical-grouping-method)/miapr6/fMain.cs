using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace miapr6
{
    public partial class fMain: Form
    {
        public const int DEFAULT_OBJECT_COUNT = 2;


        public int ObjectCount { get; set; } = DEFAULT_OBJECT_COUNT;
        private TableHandler _tableGenerator = null;
        private ChartBuilder _chartBuilder = null;
        private bool IsMaxCritery { get { return cbMaxCritery.Checked; } }


        public fMain()
        {
            InitializeComponent();
        }


        public void ViewUpdate() 
        {
            FillDataGridView(dgvDistanceTable, _tableGenerator.DistanceTable);
        }

        private void FillDataGridView(DataGridView dataGridView, float[][] distanceTable)
        {
            if (distanceTable == null || distanceTable.Length == 0)
            {
                MessageBox.Show("Массив DistanceTable пуст или не инициализирован");
                return;
            }

            dataGridView.Rows.Clear();
            dataGridView.Columns.Clear();

            // Добавляем первый столбец для заголовков строк
            dataGridView.Columns.Add("RowHeaders", "");

            // Добавляем столбцы X1, X2, X3...
            for (int col = 1; col <= distanceTable[0].Length; col++)
            {
                dataGridView.Columns.Add($"X{col}", $"X{col}");
            }

            // Заполняем данные
            for (int i = 0; i < distanceTable.Length; i++)
            {
                // Создаем массив с дополнительным элементом для заголовка строки
                object[] rowData = new object[distanceTable[i].Length + 1];
                rowData[0] = $"X{i + 1}"; // Заголовок строки

                // Копируем данные расстояний
                Array.Copy(Array.ConvertAll(distanceTable[i], x => (object)x), 0,
                         rowData, 1, distanceTable[i].Length);

                dataGridView.Rows.Add(rowData);
            }

            // Настраиваем отображение
            dataGridView.DefaultCellStyle.Format = "F2";
            dataGridView.Columns[0].DefaultCellStyle.Font = new Font(dataGridView.Font, FontStyle.Bold);
            dataGridView.Columns[0].HeaderText = ""; // Убираем текст заголовка первого столбца
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGenerateDistanceTable_Click(object sender, EventArgs e)
        {
            ObjectCount = (int)udObjectCount.Value;

            _tableGenerator = new TableHandler(ObjectCount);
            _tableGenerator.GenerateDistanceTable();

            ViewUpdate();
        }

        private void btnGrouping_Click(object sender, EventArgs e)
        {
            // Очищаем график перед новой отрисовкой
            this.chart.Series.Clear();
            this.chart.ChartAreas.Clear();
            this.chart.Legends.Clear();

            Group root = _tableGenerator.GroupingStart(IsMaxCritery);

            _chartBuilder = new ChartBuilder(this.chart, root);
            _chartBuilder.BuildDendrogram();
            
            ViewUpdate();
        }
    }
}
