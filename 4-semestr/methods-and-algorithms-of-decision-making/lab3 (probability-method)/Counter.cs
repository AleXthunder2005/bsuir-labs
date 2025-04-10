namespace lab3
{
    public static class Counter
    {
        public static readonly int FALSE_ALARM_INDEX = 0;
        public static readonly int DETECTION_PASS_INDEX = 1;
        public static readonly int SUM_ERROR_INDEX = 2;

        private static int _xStar;

        public static double[] Count(int xStar, double[] densityValues_1, double[] densityValues_2, double probability_1)
        {
            double[] result = new double[3];

            _xStar = xStar;

            result[FALSE_ALARM_INDEX] = CalculateFalseAlarm(densityValues_2);
            result[DETECTION_PASS_INDEX] = CalculateDetectionPass(densityValues_1, densityValues_2, probability_1);
            result[SUM_ERROR_INDEX] = result[FALSE_ALARM_INDEX] + result[DETECTION_PASS_INDEX];
  
            return result;
        }

        private static double CalculateFalseAlarm(double[] densityValues_2) => densityValues_2.Take(_xStar).Sum();
        /*        private static double CalculateDetectionPass(double[] densityValues_1, double[] densityValues_2, double probability_1)
                    => probability_1 > 0.5 ? densityValues_2.Skip(_xStar).Sum() : densityValues_1.Skip(_xStar).Sum();*/

        private static double CalculateDetectionPass(double[] densityValues_1, double[] densityValues_2, double probability_1)
            => densityValues_1.Skip(_xStar).Sum();

    }
}
