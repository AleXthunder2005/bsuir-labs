namespace lab3
{
    public sealed class Classificator
    {

        //Исходные данные
        public readonly double Probability_1; //Априорная вероятность принадлежности классу С1
        public readonly double Probability_2; //Априорная вероятность принадлежности классу С2
        public int XStar { get; private set; } //значение Х*

        public double MaxY                     //Максимальный Y на графике
        {
            get
            {
                var max_1 = DensityValues_1.Max();
                var max_2 = DensityValues_2.Max();

                return max_1 > max_2 ? max_1 : max_2;
            }
        }

        public readonly double[] DensityValues_1;  //Значения плотности распределения для первой случайной величины
        public readonly double[] DensityValues_2;  //Значения плотности распределения для второй случайной величины

        public readonly int SequentsLength; //Количество опытов для генерации последовательности случайных значений каждой СВ
        public readonly int ChartWidth; //Ширина графика

        private readonly Random _random = new();

        private Scope _range_1; //Диапазон распределения 1
        private Scope _range_2; //Диапазон распределения 2

        private double _MathExp_1; //Матожидание случайной величины 1
        private double _MathExp_2; //Матожидание случайной величины 2

        private double _StandartDeviation_1; //Среднеквадратическое отклонение случайной величины 1
        private double _StandartDeviation_2; //Среднеквадратическое отклонение случайной величины 2

        private readonly int[] _sequence_1; //SequentsLength случайных значений СВ1
        private readonly int[] _sequence_2; //SequentsLength случайных значений СВ2

        private const double CMP_DIFF = 0.000005; //Для сравнения double = double

        public Classificator(int sequenceLength, double probability_1, int chartWidth, Scope range_1, Scope range_2)
        {
            ChartWidth = chartWidth;
            SequentsLength = sequenceLength;

            _range_1 = range_1;
            _range_2 = range_2;

            _sequence_1 = new int[SequentsLength];
            _sequence_2 = new int[SequentsLength];
            GenerateSequence();

            Probability_1 = probability_1;       //Вероятность того, что случайная величина принадлежит классу С1
            Probability_2 = 1 - probability_1;   //Вероятность того, что случайная величина принадлежит классу С2

            DensityValues_1 = new double[chartWidth];  //Значения плотности вероятности СВ1 на ширину графика
            DensityValues_2 = new double[chartWidth];  //Значения плотности вероятности СВ2 на ширину графика

            CalculateDistributionDensity();
        }

        private void GenerateSequence()
        {
            for (int i = 0; i < SequentsLength; i++)
            {
                _sequence_1[i] = _random.Next(_range_1.LeftBorder, _range_1.RightBorder);
                _sequence_2[i] = _random.Next(_range_2.LeftBorder, _range_2.RightBorder);
            }
        }

        private void CalculateDistributionDensity()
        {
            CalculateMathExpectation();
            CalculateStandardDeviation();

            for (int x = 0; x < ChartWidth; x++)
            {
                DensityValues_1[x] = Probability_1 *
                    Math.Exp(-0.5 * Math.Pow((x - _MathExp_1) / _StandartDeviation_1, 2)) /
                    (_StandartDeviation_1 * Math.Sqrt(2 * Math.PI));

                DensityValues_2[x] = Probability_2 *
                    Math.Exp(-0.5 * Math.Pow((x - _MathExp_2) / _StandartDeviation_2, 2)) /
                    (_StandartDeviation_2 * Math.Sqrt(2 * Math.PI));

                if (Math.Abs(DensityValues_1[x] - DensityValues_2[x]) <= CMP_DIFF)
                {
                    XStar = x;
                }
            }
        }

        private void CalculateMathExpectation()
        {
            _MathExp_1 = _sequence_1.Sum() / SequentsLength;
            _MathExp_2 = _sequence_2.Sum() / SequentsLength;
        }

        private void CalculateStandardDeviation()
        {
            double squaredDifference_1 = 0;
            double squaredDifference_2 = 0;

            for (int i = 0; i < SequentsLength; i++)
            {
                squaredDifference_1 += Math.Pow(_sequence_1[i] - _MathExp_1, 2);
                squaredDifference_2 += Math.Pow(_sequence_2[i] - _MathExp_2, 2);
            }

            _StandartDeviation_1 = Math.Sqrt(squaredDifference_1 / SequentsLength);
            _StandartDeviation_2 = Math.Sqrt(squaredDifference_2 / SequentsLength);
        }
    }

    public struct Scope
    {
        public int LeftBorder;
        public int RightBorder;

        public Scope(int leftBorder, int rightBorder) 
        { 
            LeftBorder = leftBorder;
            RightBorder = rightBorder;
        }

    }
}
