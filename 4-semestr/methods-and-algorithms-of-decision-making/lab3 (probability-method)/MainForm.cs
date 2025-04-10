namespace lab3
{
    public partial class MainForm : Form
    {
        private double Probability
        {
            get { return (double)udProbability1.Value / 100; }
        }

        private const string FALSE_ALARM_TEXT = "Ложная тревога: ";
        private const string DETECTION_PASS_TEXT = "Пропуск обнаружения: ";
        private const string SUM_ERROR_TEXT = "Суммарная ошибка: ";

        private const int POINTS_NUM = 50000;
        private const double INITIAL_PROBABILITY = 50.00;

        public MainForm()
        {
            InitializeComponent();

            udProbability1.Value = (decimal)(INITIAL_PROBABILITY);
            var result = Calculate(Probability);

            UpdateLabels(result);
        }

        private Classificator Calculate(double probability)
        {
            var classificator = new Classificator(POINTS_NUM, probability, Chart.Width, new Scope(100, 700), new Scope(300, 900));
            var drawer = new GraphDrawer(Chart, POINTS_NUM);

            drawer.Draw("P(X\\C1)P(C1)", classificator.DensityValues_1);
            drawer.Draw("P(X\\C2)P(C2)", classificator.DensityValues_2);
            drawer.Draw("Х*", classificator.XStar, classificator.MaxY);

            return classificator;
        }

        private void UpdateLabels(Classificator calculations)
        {
            double[] stats = Counter.Count(calculations.XStar, calculations.DensityValues_1,
                calculations.DensityValues_2, Probability);

            lFalseAlarm.Text = FALSE_ALARM_TEXT + Math.Round(stats[Counter.FALSE_ALARM_INDEX] * 100) + "%";
            lDetectionPass.Text = DETECTION_PASS_TEXT + Math.Round(stats[Counter.DETECTION_PASS_INDEX] * 100) + "%";
            lSumError.Text = SUM_ERROR_TEXT + Math.Round(stats[Counter.SUM_ERROR_INDEX] * 100) + "%";
        }

        private void udProbability1_ValueChanged(object sender, EventArgs e)
        {
            udProbability2.Value = 100 - udProbability1.Value;
            var result = Calculate(Probability);

            UpdateLabels(result);
        }

        private void udProbability2_ValueChanged(object sender, EventArgs e)
        {
            udProbability1.Value = 100 - udProbability2.Value;
            var result = Calculate(Probability);

            UpdateLabels(result);
        }
    }
}
