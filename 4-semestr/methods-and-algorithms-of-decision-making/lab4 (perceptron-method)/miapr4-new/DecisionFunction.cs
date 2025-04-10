using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace miapr4_new
{
    public class DecisionFunction : Vector
    {
        public DecisionFunction(int size, int defaultValue) : base(size, defaultValue) { }
        public DecisionFunction(int size, Random rand) : base(size, rand) { }
        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();

            for (int i = 1; i <= Rates.Length; i++)
            {
                sb.Append($"{Rates[i]}X{i}");
                if (i < Rates.Length) sb.Append(" + ");
            }
            return sb.ToString();   
        }

    }
}
