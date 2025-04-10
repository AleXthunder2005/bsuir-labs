using System.Windows.Forms.DataVisualization.Charting;

namespace lab3
{
    public sealed class GraphDrawer
    {
        private readonly Chart Chart; // График на котором рисуем
        private readonly int _incorrectValuesNum;

        private const string CHART_AREA_NAME = "MIAPR3";
        private const double INCORRECT_PERCENTAGE = 0.001;
        public GraphDrawer(Chart chart, int pointsNum)
        {
            _incorrectValuesNum = (int)(pointsNum * INCORRECT_PERCENTAGE);

            Chart = chart;
            Chart.Dock = DockStyle.Left;
            Chart.ChartAreas.Clear();
            Chart.Series.Clear();
            Chart.Legends.Clear();
            Chart.ChartAreas.Add(new ChartArea(CHART_AREA_NAME));
        }

        public void Draw(string name, double[] points)
        {
            var seriesOfPoints = new Series(name)
            {
                ChartType = SeriesChartType.Line,
                ChartArea = CHART_AREA_NAME
            };

            for (int x = _incorrectValuesNum; x < points.Length; x++)
            {
                seriesOfPoints.Points.AddXY(x, points[x]);
            }
            Chart.Legends.Add(name);
            Chart.Series.Add(seriesOfPoints);
        }

        public void Draw(string name, int xStar, double maxY)
        {
            var seriesOfPoints = new Series(name)
            {
                ChartType = SeriesChartType.Candlestick,
                ChartArea = CHART_AREA_NAME
            };

            seriesOfPoints.Points.AddXY(xStar, 0);
            seriesOfPoints.Points.AddXY(xStar, maxY);
            Chart.Legends.Add(name);
            Chart.Series.Add(seriesOfPoints);
        }
    }
}
