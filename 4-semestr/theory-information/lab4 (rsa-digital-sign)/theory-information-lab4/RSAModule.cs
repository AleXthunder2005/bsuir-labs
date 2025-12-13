using System.Collections.Generic;
using System.Windows.Forms;

namespace theory_information_lab4
{
    public static class RSAModule
    {
        const long START_HASH_VALUE = 100;

        public static List<long> CalculateRSADegreeList(long phi) 
        {
            List<long> result = new List<long>();
            for (int i = 2; i < phi; i++)
            {
                if (MathTools.IsRelativelyPrime(i, phi)) result.Add(i);
            }
            return result;
        }

        public static long CalculateOpenKeyComponent(long d, long phi)
        {
            //(x1 * a) + (y1 * b) = GCD(a,b)
            //(x1 * Ф(r)) + (e * d) = GCD(Ф(r),d)
            
            long x, y;
            var gcd = MathTools.ExtendedGcd(phi, d, out x, out y);

            if (y < 0)
            {
                y = (y + phi) % phi;
            }

            return y;
        }

        public static long GenerateSignature(string message, long d, long r, out long hash)
        {
            hash = HashModule.GetHash(message, START_HASH_VALUE, r);

            if (hash >= r) 
            {
                MessageBox.Show($"Для данных p и q (r = {r}) создание подписи невозможно, так как hash = {hash} превышает r",
                    "Ошибка создания подписи",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);

                return -1;
            }
            return RSAEncryption(hash, d, r);
        }
        
        public static bool IsSignatureAuthentic(string message, long fileSignature, long e, long r, out long hash, out long fileHash)
        {
            hash = HashModule.GetHash(message, START_HASH_VALUE, r);
            fileHash = RSADecryption(fileSignature, e, r);

            return hash == fileHash;
        }

        private static long RSAEncryption(long m, long d, long r) 
        {
            return MathTools.FastExp(m, d, r);
        }

        private static long RSADecryption(long m, long e, long r)
        {
            return MathTools.FastExp(m, e, r);
        }
    }
}
