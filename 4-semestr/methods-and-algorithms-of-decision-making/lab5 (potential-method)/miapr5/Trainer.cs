using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static miapr5.ItemsGenerator;

namespace miapr5
{
    public class Trainer
    {
        private const int MAX_ITERATION_COUNT = 100000;

        public Vector SumPotential { get; set; }
        
        private Item[] Kernels { get; set; }
      
        public Trainer(Item[][] kernels) { 
            SumPotential = new Vector();

            Kernels = new Item[2 * kernels[0].Length];
            int j = 0;
            foreach (Item[] set in kernels)
            {
                for (int i = 0; i < set.Length; i++)
                {
                    Kernels[j] = set[i];
                    j++;
                }
            }

        }
        public void StartTraining() 
        {
            int iterationCount = 0;

            Vector PrivatePotential = Vector.CalculatePrivatePotential(Kernels[0]);
            SumPotential.Add(PrivatePotential);                                          // K1 = K0 + K(X, Kernels[0])
            bool canFinish = true;
            do
            {
                canFinish = true;
                for (int i = 0; i < Kernels.Length; i++)
                {
                    int substitutionItemIndex = (i < Kernels.Length - 1) ? i + 1 : 0;
                    BigInteger substitutionResult = SumPotential.Substitute(Kernels[substitutionItemIndex]);   //подстановка в K1

                    if (Kernels[substitutionItemIndex].Class == 1)
                    {
                        if (substitutionResult <= 0)
                        {
                            PrivatePotential = Vector.CalculatePrivatePotential(Kernels[substitutionItemIndex]);
                            SumPotential.Add(PrivatePotential);                                     // K2 = K1 + K(X, Kernels[1])
                                
                            canFinish = false;
                        }
                    }
                    else
                    {
                        if (substitutionResult > 0)
                        {
                            PrivatePotential = Vector.CalculatePrivatePotential(Kernels[substitutionItemIndex]);
                            SumPotential.Sub(PrivatePotential);                                     // K2 = K1 - K(X, Kernels[1])

                            canFinish = false;
                        }
                    }
                    iterationCount++;
                    if (iterationCount > MAX_ITERATION_COUNT) 
                    { 
                        MessageBox.Show($"Количество итераций превысило {MAX_ITERATION_COUNT}", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return; 
                    }
                }
            } while (!canFinish);
        }

        public class Vector 
        {
            private const int DEFAULT_VECTOR_SIZE = 4;

            public BigInteger[] Coefficients {  get; set; }
            public int Size { get; set; } = DEFAULT_VECTOR_SIZE;

            public Vector() { 
                Coefficients = new BigInteger[Size];
                for (int i = 0; i < Coefficients.Length; i++) Coefficients[i] = 0;
            }

            public Vector Add(Vector vector) 
            {
                if (vector.Size != Size) return null;

                for (int i = 0; i < Coefficients.Length;i++)
                {
                    Coefficients[i] += vector.Coefficients[i];
                }
                return this;
            }

            public Vector Sub(Vector vector)
            {
                if (vector.Size != Size) return null;

                for (int i = 0; i < Coefficients.Length; i++)
                {
                    Coefficients[i] -= vector.Coefficients[i];
                }
                return this;
            }

            public Vector MultipleWithConstant(int c)
            {
                for (int i = 0; i < Coefficients.Length; i++)
                {
                    Coefficients[i] *= c;
                }
                return this;
            }

            public BigInteger Substitute(Item item)
            {
                BigInteger res = 0;
                if (Size != 4) return 0;

                res += Coefficients[0];
                res += Coefficients[1] * item.X;
                res += Coefficients[2] * item.Y;
                res += Coefficients[3] * item.X * item.Y;
                
                return res;
            }

            public static Vector CalculatePrivatePotential(Item item)
            {
                Vector res = new Vector();

                res.Coefficients[0] = 1;
                res.Coefficients[1] = 4 * item.X;
                res.Coefficients[2] = 4 * item.Y;
                res.Coefficients[3] = 16 * item.X * item.Y;

                return res;
            }

            public static Vector CalculateSumPotential(params Vector[] vectors)
            {
                Vector result = new Vector();
                foreach (Vector v in vectors)
                {
                    result.Add(v);
                }

                return result;
            }

            public override string ToString()
            {
                return $"{Coefficients[0]} + {Coefficients[1]}*x1 + {Coefficients[2]}*x2 + {Coefficients[3]}*x1x2";
            }
        }
    }
}
