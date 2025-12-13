using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms.VisualStyles;
using Microsoft.Win32;
using static System.Net.Mime.MediaTypeNames;

namespace theory_information_lab2
{
    static class ModelFunctions
    {
        public const string EMPTY_STRING = "";
        public const int REGISTER_SIZE = 40;
        public const string POLYNOM = "x^40 + x^21 + x^19 + x^2 + 1";
        public const char SPLITER = '_';
        
        public static byte[] _activeBitNums;

        public static bool IsLengthSuitable(int currLength, int maxLength) 
        {
            return currLength < maxLength;
        }

        public static bool IsKeyBinaryDigit(char Key) 
        {
            return (Key == '0') || (Key == '1');
        }

        public static string ConvertTextToBytes(string line) 
        {
            line = EraseSpliters(line);
            StringBuilder sb = new StringBuilder();
            for (int i = 1; i <= line.Length; i++)
            {
                sb.Append(line[i-1]);
                if (i % 8 == 0) sb.Append(SPLITER);
            }

            return sb.ToString().Trim(SPLITER);
        }
        public static string EraseSpliters(string line)
        {
            StringBuilder sb = new StringBuilder();
            foreach (char c in line)
            {
                if (!(c==SPLITER))
                {
                    sb.Append(c);
                }
            }
            return sb.ToString();
        }

        public static byte[] ConvertBinaryTextToByteArray(string text)
        {
            int length = text.Length;
            int byteCount = (length + 7) / 8; // Количество байт, чтобы вместить все биты
            byte[] data = new byte[byteCount];
            int bitIndex = 0; // Текущий индекс бита в массиве байтов
            foreach (char c in text)
            {
                int bitValue = (c == '1') ? 1 : 0;
                int byteIndex = bitIndex / 8;
                int bitPosition = 7 - (bitIndex % 8); 
                data[byteIndex] |= (byte)(bitValue << bitPosition);

                //"11101100 10101010" - 0[11101100] 1[10101010] 2[]
                bitIndex++;
            }

            return data;
        }

        private static string ConvertByteToText(byte b) 
        {
            StringBuilder binaryText = new StringBuilder();
            for (int j = 7; j >= 0; j--)
            {
                int bit = (b >> j) & 1;
                binaryText.Append(bit);
            }

            return binaryText.ToString();
        }

        public static string ConvertByteArrayToBinaryText(byte[] data)
        {
            int necessaryByteCount = 4 * REGISTER_SIZE / 8;
            StringBuilder binaryText = new StringBuilder();

            if (data.Length > necessaryByteCount)
            {
                for (int i = 0; i < 2 * REGISTER_SIZE / 8; i++)
                {
                    binaryText.Append(ConvertByteToText(data[i]));
                    binaryText.Append(SPLITER);
                }
                binaryText.Length--;
                binaryText.Append($"{SPLITER}...{SPLITER}");
                for (int i = 2 * REGISTER_SIZE / 8; i > 0 ; i--)
                {
                    binaryText.Append(ConvertByteToText(data[data.Length - i]));
                    binaryText.Append(SPLITER);
                }
                binaryText.Length--;
            }
            else
            {
                foreach (byte b in data)
                {
                    binaryText.Append(ConvertByteToText(b));
                    binaryText.Append(SPLITER);
                }
                binaryText.Length--;
            }

            return binaryText.ToString();
        }

        public static byte[] ParsePolynom(string polynom) 
        {
            int activeBitCount = 0;
            foreach (char c in polynom)  {if (c == '^') activeBitCount++; }

            byte[] activeBitNums = new byte[activeBitCount];
            int i = 0;
            int j = 0;
            while (j < polynom.Length) 
            {
                if (polynom[j] == '^') 
                { 
                    StringBuilder sb = new StringBuilder();
                    j++;
                    while (polynom[j] != ' ') 
                    {
                        sb.Append(polynom[j]);
                        j++;
                    }
                    activeBitNums[i] = Byte.Parse(sb.ToString());
                    i++;
                }
                j++;
            }

            return activeBitNums;
        }

        public static long ConvertTextToLong(string text)
        {
            long register = 0;
            int shiftCount = 0;

            for (int i = text.Length - 1; i >= 0; i--)
            {
                char c = text[i];
                long bitValue = (c == '1') ? 1 : 0;
                register |= (bitValue << shiftCount);
                shiftCount++;
            }

            return register;
        }
        //11110000
        public static byte[] GenerateKey(string key, long sourceDataLength)
        {
            //"11101100 10101010" - 0[11101100] 1[10101010] 2[]
            long register = ConvertTextToLong(EraseSpliters(key));
            byte[] keyBytes = new byte[sourceDataLength];

            long bitIndex = 0;

            while (bitIndex < keyBytes.Length * 8)
            {
                long byteIndex = bitIndex / 8;
                byte bitPosition = (byte)(7 - (bitIndex % 8));
                byte newKeyBit = GetNewKeyBit(ref register);
                keyBytes[byteIndex] |= (byte)(newKeyBit << bitPosition);

                
                bitIndex++;
            }

            return keyBytes;
        }

        private static byte GetBit(long register, int bitNum) 
        {
            return (byte)((register >> bitNum) & 1);   //нумерация с нуля
        }

        private static byte GetNewKeyBit(ref long register) 
        {
            
            byte resultBit = 0;
            for (int i = _activeBitNums.Length - 1; i >= 0; i--) 
            {
                resultBit ^= GetBit(register, _activeBitNums[i]-1);
            }

            register <<= 1;
            register |= (long)resultBit;

            return GetBit(register, REGISTER_SIZE);
        }

        public static void StartParsePolynom() 
        {
            _activeBitNums = ParsePolynom(POLYNOM);
        }

    }


}
