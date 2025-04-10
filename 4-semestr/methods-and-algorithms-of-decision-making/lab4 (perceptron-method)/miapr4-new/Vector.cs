using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace miapr4_new
{
    public class Vector
    {
        public const int MIN_RATE = -10;
        public const int MAX_RATE = 10;
        public const int RATE_TEXT_POSITION_COUNT = 4;
        public int Size { get; set; }
        
        public int Class {  get; set; }
        public int[] Rates { get; set; }
        public Vector(int size, Random rand)
        {
            Size = size;
            Rates = new int[size];
            for (int i = 0; i < size; i++)
            {
                Rates[i] = rand.Next(MIN_RATE, MAX_RATE);
            }
        }

        public Vector(int size, int defaultValue)
        {
            Size = size;
            Rates = new int[size];
            for (int i = 0; i < size; i++)
            {
                Rates[i] = defaultValue;
            }
        }

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < Rates.Length - 1; i++)
            {
                var rate = Rates[i];
                sb.Append(rate.ToString().PadLeft(RATE_TEXT_POSITION_COUNT, ' '));
                sb.Append("; ");
            }

            return sb.ToString().Trim();
        }

        public string ToFullString()
        {
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < Rates.Length; i++)
            {
                // Добавляем знак перед коэффициентом, если это не первый элемент
                if (i > 0)
                {
                    sb.Append(Rates[i] >= 0 ? " + " : " - ");
                }
                else if (Rates[i] < 0)
                {
                    sb.Append("-");
                }

                // Добавляем абсолютное значение коэффициента
                sb.Append(Math.Abs(Rates[i]));

                // Добавляем переменную, если это не последний элемент
                if (i < Rates.Length - 1)
                {
                    sb.Append($"x{i + 1}");
                }
            }

            return sb.ToString();
        }

        public string Substitute(Vector obj)
        {
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < Rates.Length; i++)
            {
                // Добавляем знак перед коэффициентом, если это не первый элемент
                if (i > 0)
                {
                    sb.Append(Rates[i] >= 0 ? " + " : " - ");
                }
                else if (Rates[i] < 0)
                {
                    sb.Append("-");
                }

                // Добавляем абсолютное значение коэффициента
                sb.Append(Math.Abs(Rates[i]));
                sb.Append($" * {obj.Rates[i]}");
            }

            return sb.ToString();
        }

        public Vector Add(Vector v) 
        {
            if (this.Size != v.Size) return null;

            for (int i = 0; i < Rates.Length; i++)
            {
                Rates[i] += v.Rates[i];
            }
            return this;
        }

        public Vector Sub(Vector v)
        {
            if (this.Size != v.Size) return null;
            for (int i = 0; i < Rates.Length; i++)
            {
                Rates[i] -= v.Rates[i];
            }
            return this;
        }

        public int ScalarMultiple(Vector v) //скалярное произведение
        {
            if (this.Size != v.Size) return 0;

            int result = 0;
            for (int i = 0; i < Rates.Length; i++)
            {
                result += Rates[i] * v.Rates[i];
            }
            return result;
        }

        public Vector ConstantMultiple(int c)  //Умножение на константу
        {
            for (int i = 0; i < Rates.Length; i++)
            {
               Rates[i] *= c;
            }
            return this;
        }

        public void Punish(Vector obj, int c) 
        {
            this.Sub(obj.ConstantMultiple(c));
        }

        public void Encourage(Vector obj, int c) 
        {
            this.Add(obj.ConstantMultiple(c));
        }
    }
}
