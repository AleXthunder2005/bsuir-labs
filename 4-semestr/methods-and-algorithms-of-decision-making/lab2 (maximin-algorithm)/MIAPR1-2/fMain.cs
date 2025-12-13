using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace MIAPR1_2
{
    public partial class fMain: Form
    {

        private const byte MIN_CLASS_COUNT = 2;
        private const byte MAX_CLASS_COUNT = 20;
        private const int MIN_OBJECT_COUNT = 1000;
        private const int MAX_OBJECT_COUNT = 100000;

        private const int MIN_X = 0;
        private const int MAX_X = 1400;
        private const int MIN_Y = 0;
        private const int MAX_Y = 900;

        private static int pCONTENT_WIDTH = MAX_X;
        private static int pCONTENT_HEIGHT = MAX_Y;

        private const byte DEFAULT_CLASS_ID = 0;
        public static Color DEFAULT_COLOR = Color.LightGray;
        public static Color DEFAULT_KERNEL_COLOR = Color.Black;
        public static Color[] COLORS = {
                                        DEFAULT_COLOR,
                                        Color.GreenYellow,
                                        Color.Red,
                                        Color.Blue,
                                        Color.Yellow,
                                        Color.Orange,
                                        Color.Purple,
                                        Color.Pink,
                                        Color.Cyan,
                                        Color.Magenta,
                                        Color.Brown,
                                        Color.Lime,
                                        Color.Teal,
                                        Color.Indigo,
                                        Color.Violet,
                                        Color.Gold,
                                        Color.Silver,
                                        Color.DarkGreen,
                                        Color.DarkBlue,
                                        Color.DarkRed,
                                        Color.Coral
                                    };

        private LabObject[] m_objects;
        private LabObject[] m_kernels;

        public fMain()
        {
            InitializeComponent();
            InitializeUserComponent();
        }

        //model
        private void InitializeUserComponent()
        {
            this.pContent.Paint += new PaintEventHandler(Content_Paint);
            this.Resize += new EventHandler(fMain_Resize);

            //udClassCount
            udClassCount.Value = MIN_CLASS_COUNT;
            udClassCount.Minimum = MIN_CLASS_COUNT;
            udClassCount.Maximum = MAX_CLASS_COUNT;

            //udObjectCount
            udObjectCount.Value = MIN_OBJECT_COUNT;
            udObjectCount.Minimum = MIN_OBJECT_COUNT;
            udObjectCount.Maximum = MAX_OBJECT_COUNT;

            pCONTENT_WIDTH = this.ClientSize.Width - pSideMenu.Width;
            pCONTENT_HEIGHT = this.ClientSize.Height;
        }

        private void CloseApp() 
        {
            this.Close();
        }

        private class LabObject 
        {
            public int m_x;
            public int m_y;
            public int m_classId = DEFAULT_CLASS_ID;
            public Color m_color = DEFAULT_COLOR;

            public double m_averageDistance = Double.MaxValue; //поле для ядер классов

            private static Random randomCoord = new Random();

            public LabObject() 
            {
                m_x = randomCoord.Next(MIN_X, pCONTENT_WIDTH);
                m_y = randomCoord.Next(MIN_Y, pCONTENT_HEIGHT);
            }

            public void SetColor() 
            {
                m_color = COLORS[m_classId];
            }

            public void SetKernelColor() 
            {
                m_color = DEFAULT_KERNEL_COLOR;
            }

            public void SetKernelClassId(int ID) 
            {
                m_classId = ID;
            }

            public int DistanceTo(LabObject obj) 
            {
                return (int)Math.Round(Math.Sqrt(Sqr(this.m_x - obj.m_x) + Sqr(this.m_y - obj.m_y)));
            }
            public int SKOTo(LabObject obj)
            {
                return (int)Math.Round(Math.Sqrt(Sqr(this.m_x - obj.m_x) + Sqr(this.m_y - obj.m_y)));
            }

            //public int SKOTo(LabObject obj)
            //{
            //    return Sqr(this.m_x - obj.m_x) + Sqr(this.m_y - obj.m_y);
            //}

            private int Sqr(int a) => a * a;

            public void Draw(Graphics parent)
            {
                using (SolidBrush brush = new SolidBrush(m_color))
                {
                    parent.FillRectangle(brush, m_x, m_y, 4, 4);
                }
            }


        }
        private void InitializeObjects(int classCount, int objectCount, bool isKAverageAlgorithm) 
        {
            if (isKAverageAlgorithm)
            {
                int simpleObjectCount = objectCount - classCount;
                m_objects = new LabObject[simpleObjectCount];
                for (int i = 0; i < simpleObjectCount; i++) m_objects[i] = new LabObject();

                m_kernels = new LabObject[classCount];
                for (int i = 0; i < classCount; i++)
                {
                    m_kernels[i] = new LabObject();
                    m_kernels[i].SetKernelColor();
                    m_kernels[i].SetKernelClassId(i + 1);
                }
            }
            else 
            {
                int simpleObjectCount = objectCount - 1;
                m_objects = new LabObject[simpleObjectCount];
                for (int i = 0; i < simpleObjectCount; i++) m_objects[i] = new LabObject();

                m_kernels = new LabObject[MAX_CLASS_COUNT];
                m_kernels[0] = new LabObject();
                m_kernels[0].SetKernelColor();
                m_kernels[0].SetKernelClassId(1);
            }
        }



        private void AssignClass() 
        {
            if (m_objects == null || m_kernels == null) return;


            int distance;
            for (int i = 0; i < m_objects.Length; i++)
            {
                if (m_objects[i] == null) continue;

                int minDist = int.MaxValue;
                int suitableClassId = 0;
                foreach (var kernel in m_kernels)
                {
                    if (kernel == null) continue;  

                    distance = m_objects[i].DistanceTo(kernel);
                    if (distance < minDist)
                    {
                        minDist = distance;
                        suitableClassId = kernel.m_classId;
                    }
                }
                m_objects[i].m_classId = suitableClassId;
                m_objects[i].SetColor();
            }

            for (int i = 0; i < m_kernels.Length; i++) 
            {
                if (m_kernels[i] == null) continue;
                m_kernels[i].SetKernelColor();
            }
        }

        private double CalculateAverageSKOToOthers(LabObject candidate) 
        {
            double distance = 0;
            int classMemberCount = 0;
            long XCommon = 0, YCommon = 0;
            double XAverage = 0, YAverage = 0;

            foreach (var obj in m_objects)
            {
                if (obj == null) continue;

                if (candidate.m_classId == obj.m_classId)
                {
                    XCommon += obj.m_x;
                    YCommon += obj.m_y;
                    classMemberCount++;
                }
            }

            XAverage = XCommon / classMemberCount; 
            YAverage = YCommon / classMemberCount;

            //return Math.Sqrt(SKOForX(candidate.m_classId, (int)Math.Round(XAverage)) + SKOForY(candidate.m_classId, (int)Math.Round(YAverage)) / classMemberCount);

            return Math.Sqrt(Sqr(candidate.m_x - (int)Math.Round(XAverage)) + Sqr(candidate.m_y - (int)Math.Round(YAverage)));
        }

        private int SKOForX(int classId, int averageCoord) 
        {
            int sum = 0;
            foreach (var obj in m_objects)
            {
                if (obj == null) continue;

                if (classId == obj.m_classId)
                {
                    sum += Sqr(obj.m_x - averageCoord);
                }
            }

            return sum;
        }

        private int SKOForY(int classId, int averageCoord)
        {
            int sum = 0;
            foreach (var obj in m_objects)
            {
                if (obj == null) continue;

                if (classId == obj.m_classId)
                {
                    sum += Sqr(obj.m_y - averageCoord);
                }
            }
            return sum;
        }

        private int Sqr(int a) => a * a;

        private bool RecognizeObjectsWithKAverageAlgorithm() 
        {
            bool canClassKernelChange;
            bool hasChanges = false;
            double minDistance;
            double distance;
            int kernelCandidateIndex;
            for (int j = 0; j < m_kernels.Length; j++) 
            {
                LabObject kernel = m_kernels[j];

                if (kernel == null) continue;

                minDistance = kernel.m_averageDistance;
                kernelCandidateIndex = 0;
                canClassKernelChange = false;

                for (int i = 0; i < m_objects.Length; i++) 
                {
                    LabObject curr = m_objects[i];

                    if (curr == null) continue;

                    if (curr.m_classId == kernel.m_classId) 
                    {
                        distance = CalculateAverageSKOToOthers(curr);
                        if (distance < minDistance) 
                        {
                            minDistance = distance;
                            kernelCandidateIndex = i;
                            canClassKernelChange = true;
                        }
                    }
                }

                if (canClassKernelChange)
                {
                    LabObject temp = kernel;
                    temp.m_averageDistance = Double.MaxValue;


                    m_objects[kernelCandidateIndex].m_averageDistance = minDistance;
                    m_kernels[j] = m_objects[kernelCandidateIndex];
                    
                    m_objects[kernelCandidateIndex] = temp;
                    hasChanges = true;
                }
            }

            return hasChanges;
        }

        private int FindKernelCandidate(LabObject oldKernel, ref double maxDistance) 
        {
            double currMaxDistance = 0;
            int currCandidateIndex = 0;
            int classId = oldKernel.m_classId;
            for (int i = 0; i < m_objects.Length; i++) 
            {
                LabObject curr = m_objects[i];
                if (curr == null) continue;

                if (curr.m_classId == classId) 
                {
                    double distance = oldKernel.DistanceTo(curr);
                    if (distance > currMaxDistance) 
                    {
                        currMaxDistance = distance;
                        currCandidateIndex = i;
                    }
                }
            }

            maxDistance = currMaxDistance;

            return currCandidateIndex;
        }

        private int GetKernelCount()
        {
            int counter = 0;
            foreach (var kernel in m_kernels) if (kernel != null) counter++;
            return counter;
        }

        private double GetAverageDistanceBetweenKernels() 
        {
            int kernelCount = GetKernelCount();

            if (kernelCount == 1) return 0;

            int distanceCounter = 0;
            double commonDistance = 0;
            for (int i = 0; i < kernelCount; i++) 
            {
                for (int j = i+1; j < kernelCount; j++) 
                {
                    commonDistance += m_kernels[i].DistanceTo(m_kernels[j]);
                    distanceCounter++;
                }
            }

            return commonDistance / distanceCounter;
        }

        private bool RecognizeObjectsWithMaximinAlgorithm() 
        {
            //найдем новое ядро
            double distance = 0;
            double currMaxDistance = 0;
            int currPriorityCandidateIndex = 0;

            int kernelCount = GetKernelCount();

            for (int i = 0; i < kernelCount; i++)
            {
                if (m_kernels[i] == null) continue;

                int candidateIndex = FindKernelCandidate(m_kernels[i], ref distance);
                if (distance > currMaxDistance) 
                {
                    currMaxDistance = distance;
                    currPriorityCandidateIndex = candidateIndex;
                }   
            }

            //теперь проверим а надо ли оно (если currMaxDistance больше половины среднего арифметического всех расстояний между ядрами)
            if (currMaxDistance > (0.5 * GetAverageDistanceBetweenKernels())) 
            {
                m_kernels[kernelCount] = m_objects[currPriorityCandidateIndex];
                m_kernels[kernelCount].SetKernelClassId(kernelCount + 1);
                m_kernels[kernelCount].SetKernelColor();
                m_objects[currPriorityCandidateIndex] = null;

                return true;
            }

            return false;
        }

        private async void StartRecognition(bool isKAverage) 
        {
            AssignClass();
            pContent.Invalidate(); // Отрисовка начального состояния
            await Task.Delay(1000);

            if (isKAverage)
            {
                bool isIterationNeeded;
                do
                {
                    isIterationNeeded = RecognizeObjectsWithKAverageAlgorithm();
                    AssignClass();
                    pContent.Invalidate();
                    await Task.Delay(3000);

                    // Можно также использовать await Task.Yield(), чтобы сразу вернуть управление UI
                    // await Task.Yield();
                } while (isIterationNeeded);
            }
            else 
            {
                bool isIterationNeeded;
                do
                {
                    isIterationNeeded = RecognizeObjectsWithMaximinAlgorithm();

                    AssignClass();
                    pContent.Invalidate();
                    await Task.Delay(3000);
            } while (isIterationNeeded) ;
        }

            MessageBox.Show($"Распознавание завершено! Количество классов: {GetKernelCount()}");
            udClassCount.Value = GetKernelCount();
        }

        //view
        private void Content_Paint(object sender, PaintEventArgs e)
        {
            if (m_objects == null || m_kernels == null) return;
            
            Graphics g = e.Graphics;
            foreach (var obj in m_objects) if (obj != null) obj.Draw(g);
            foreach (var obj in m_kernels) if (obj != null) obj.Draw(g);
        }

        private void fMain_Resize(object sender, EventArgs e)
        {
            pCONTENT_WIDTH = this.ClientSize.Width - pSideMenu.Width;
            pCONTENT_HEIGHT = this.ClientSize.Height;
        }

        //controllers
        private void btnExit_Click(object sender, EventArgs e)
        {
            CloseApp();
        }

        private void btnObjectGeneration_Click(object sender, EventArgs e)
        {
            InitializeObjects((int)udClassCount.Value, (int)udObjectCount.Value, this.rbtnKAverage.Checked);
            pContent.Invalidate();
        }

        private void btnStartRecognition_Click(object sender, EventArgs e)
        {
            if (m_objects == null || m_kernels == null) return;

            StartRecognition(rbtnKAverage.Checked);

            
        }
    }
}
