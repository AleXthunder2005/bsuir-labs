using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace miapr8
{
    public class GrammarElement
    {
        public const int Term = 42424242;
        public const int NoVal = 43434343;
        public int BVal { get; set; }
        public string A { get; set; }
        public string B { get; set; }

        public GrammarElement(int bVal, string a, string b = "")
        {
            A = a;
            B = b;
            BVal = bVal;
        }

        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
            {
                return false;
            }

            GrammarElement other = (GrammarElement)obj;

            return A == other.A && BVal == other.BVal && B == other.B;
        }
    }
}
