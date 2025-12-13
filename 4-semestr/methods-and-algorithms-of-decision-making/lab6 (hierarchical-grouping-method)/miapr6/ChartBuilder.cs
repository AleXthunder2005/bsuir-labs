using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms.DataVisualization.Charting;

namespace miapr6
{
    public class ChartBuilder
    {
        private readonly Chart _chart;
        private readonly Group _root;
        private Dictionary<Group, float> _positions;

        public ChartBuilder(Chart chart, Group root)
        {
            _chart = chart;
            _root = root;
            InitializeChart();
        }

        private void InitializeChart()
        {
            _chart.Series.Clear();
            _chart.ChartAreas.Clear();
            _chart.Legends.Clear(); // Удаляем легенду

            var chartArea = new ChartArea
            {
                AxisX = {
                    Title = "Objects",
                    Interval = 1,
                    MajorGrid = { Enabled = false },
                    LabelStyle = { Enabled = false }
                },
                AxisY = {
                    Title = "Distance",
                    Minimum = 0,
                    MajorGrid = { LineColor = Color.LightGray }
                }
            };

            _chart.ChartAreas.Add(chartArea);
            _positions = new Dictionary<Group, float>();
        }

        public void BuildDendrogram()
        {
            if (_root == null) throw new InvalidOperationException("Root group is null");

            // 1. Вычисляем позиции всех элементов
            float currentX = 1f;
            CalculatePositions(_root, ref currentX);

            // 2. Рисуем чистую иерархию
            DrawPureHierarchy(_root);

            // 3. Добавляем подписи объектов
            AddProperLabels();
        }

        private float CalculatePositions(Group group, ref float currentX)
        {
            if (group.Groups.Count == 0)
            {
                float x = currentX++;
                _positions[group] = x;
                return x;
            }

            var childPositions = new List<float>();
            foreach (var child in group.Groups)
            {
                childPositions.Add(CalculatePositions(child, ref currentX));
            }

            float groupX = (childPositions.Min() + childPositions.Max()) / 2;
            _positions[group] = groupX;
            return groupX;
        }

        private void DrawPureHierarchy(Group group)
        {
            if (group.Groups.Count != 2) return;

            var leftChild = group.Groups[0];
            var rightChild = group.Groups[1];

            float leftX = _positions[leftChild];
            float rightX = _positions[rightChild];

            // 1. Левая вертикальная линия
            var leftLine = new Series
            {
                ChartType = SeriesChartType.Line,
                Color = Color.Black, // Все линии черные
                BorderWidth = 2,
                IsVisibleInLegend = false // Отключаем отображение в легенде
            };
            leftLine.Points.AddXY(leftX, leftChild.Distance);
            leftLine.Points.AddXY(leftX, group.Distance);
            _chart.Series.Add(leftLine);

            // 2. Правая вертикальная линия
            var rightLine = new Series
            {
                ChartType = SeriesChartType.Line,
                Color = Color.Black,
                BorderWidth = 2,
                IsVisibleInLegend = false
            };
            rightLine.Points.AddXY(rightX, rightChild.Distance);
            rightLine.Points.AddXY(rightX, group.Distance);
            _chart.Series.Add(rightLine);

            // 3. Горизонтальная линия
            var horizontalLine = new Series
            {
                ChartType = SeriesChartType.Line,
                Color = Color.Black,
                BorderWidth = 2,
                IsVisibleInLegend = false
            };
            horizontalLine.Points.AddXY(leftX, group.Distance);
            horizontalLine.Points.AddXY(rightX, group.Distance);
            _chart.Series.Add(horizontalLine);

            // Рекурсивная обработка
            DrawPureHierarchy(leftChild);
            DrawPureHierarchy(rightChild);
        }

        private void AddProperLabels()
        {
            // Серия для меток объектов
            var labelSeries = new Series
            {
                ChartType = SeriesChartType.Point,
                Color = Color.Transparent,
                IsVisibleInLegend = false
            };

            // Серия для маркеров позиций (невидимая)
            var markerSeries = new Series
            {
                ChartType = SeriesChartType.Point,
                Color = Color.Transparent,
                IsVisibleInLegend = false
            };

            float yPosition = -0.1f * (float)_chart.ChartAreas[0].AxisY.Maximum;

            foreach (var kvp in _positions.Where(p => p.Key.Groups.Count == 0))
            {
                // 1. Невидимый маркер на правильной позиции
                markerSeries.Points.AddXY(kvp.Value, 0);

                // 2. Подпись под осью по центру
                labelSeries.Points.Add(new DataPoint(kvp.Value, yPosition)
                {
                    Label = $"X{kvp.Key.Indexes[0] + 1}",
                    LabelForeColor = Color.Black,
                    Font = new Font("Arial", 8, FontStyle.Bold),
                    LabelToolTip = $"Object X{kvp.Key.Indexes[0] + 1}"
                });
            }

            _chart.Series.Add(markerSeries);
            _chart.Series.Add(labelSeries);
        }
    }
}