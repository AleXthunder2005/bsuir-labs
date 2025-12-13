namespace theory_information_lab4
{
    public static class HashModule
    {
        public static long GetHash(string message, long h0, long n)
        {
            long currH = h0;
            foreach (char mi in message)
            {
                currH = HashFunction(mi, currH, n);
            }
            return currH;
        }

        private static long HashFunction(char mi, long prevH, long n) 
        {
              return MathTools.FastExp((mi + prevH), 2, n);
        }
    }
}
