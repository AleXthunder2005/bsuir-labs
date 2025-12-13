using System;

namespace theory_information_lab4
{
    public static class MathTools
    {
        public static long FastExp(long foundation, long degree, long n)
        {
            //foundation^degree mod n

            long currFoundation = foundation;
            long currDegree = degree;
            long result = 1;

            while (currDegree != 0)
            {
                while (currDegree % 2 == 0)
                {
                    currDegree /= 2;
                    currFoundation = (currFoundation * currFoundation) % n;
                }

                currDegree--;
                result = (result * currFoundation) % n;
            }

            return result;
        }

        public static bool IsPrime(int n)
        {
            if (n == 1) return false;

            bool isPrime = true;
            for (int i = 2; i <= Math.Sqrt(n); i++)
            {
                if (n % i == 0)
                {
                    isPrime = false;
                    break;
                }
            }
            return isPrime;
        }

        public static bool IsRelativelyPrime(long a, long b)
        {
            //Если НОД == 1 - то взаимопростые
            while (b != 0)
            {
                long remainder = a % b;
                a = b;
                b = remainder;
            }
            return a == 1;
        }


        public static long ExtendedGcd(long a, long b, out long x, out long y)
        {
            long d0 = a, d1 = b;
            long x0 = 1, x1 = 0;
            long y0 = 0, y1 = 1;

            while (d1 > 1)  
            {
                long q = d0 / d1;
                long d2 = d0 % d1;
                long x2 = x0 - q * x1;
                long y2 = y0 - q * y1;

                // Сдвигаем значения для следующей итерации
                d0 = d1;
                d1 = d2;
                x0 = x1;
                x1 = x2;
                y0 = y1;
                y1 = y2;
            }

            // Возвращаем коэффициенты Безу и НОД
            x = x1;
            y = y1;
            return d1;
        }
    }
}
