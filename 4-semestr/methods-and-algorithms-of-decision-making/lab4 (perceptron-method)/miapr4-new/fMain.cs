using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace miapr4_new
{
    public partial class fMain: Form
    {
        public int ClassCount { get { return (int)udClassCount.Value; } }
        public int ClassObjectCount { get { return (int)udClassObjectCount.Value; } }
        public int SignCount { get { return (int)udSignCount.Value; } }


        public int TestObjectCount { get { return (int)udTestObjectCount.Value; } }

        public Vector[] TrainingVectors { get; set; }
        public Vector[] TestVectors { get; set; }

        public Vector[] DecisionFunctions { get; set; }


        public static readonly Color[] classColors =
        {
            Color.FromArgb(255, 230, 230), // Светло-розовый
            Color.FromArgb(230, 255, 230), // Светло-зеленый
            Color.FromArgb(230, 230, 255), // Светло-синий
            Color.FromArgb(255, 255, 230), // Светло-желтый
            Color.FromArgb(255, 230, 255), // Светло-фиолетовый
            Color.FromArgb(230, 255, 255), // Светло-голубой
            Color.FromArgb(255, 210, 210), // Бледно-розовый
            Color.FromArgb(210, 255, 210), // Бледно-зеленый
            Color.FromArgb(210, 210, 255), // Бледно-синий
            Color.FromArgb(255, 255, 210), // Бледно-желтый
            Color.FromArgb(255, 210, 255), // Бледно-фиолетовый
            Color.FromArgb(210, 255, 255), // Бледно-голубой
            Color.FromArgb(240, 230, 210), // Светлый бежевый
            Color.FromArgb(210, 240, 230), // Светлый мятный
            Color.FromArgb(230, 210, 240), // Светлый лавандовый
            Color.FromArgb(240, 240, 210), // Светлый песочный
            Color.FromArgb(240, 210, 240), // Светлый розово-лавандовый
            Color.FromArgb(210, 240, 240), // Светлый аквамариновый
            Color.FromArgb(220, 240, 220), // Светлый салатовый
            Color.FromArgb(240, 220, 220)  // Светлый коралловый
        };

        private static readonly Color SELECTED_CELL = Color.LightGray;
        private const int START_CONSTANT = 1;
        private const int MAX_ITERATION_COUNT = 10000;

        private VectorGenerator _vectorGenerator;

        //model
        public fMain()
        {
            InitializeComponent();
        }
        private void CalculateDecisionFunctions()
        {
            DecisionFunctions = _vectorGenerator.GenerateVectors(ClassCount, SignCount + 1, 0); //Весовые коэффициенты
            bool isLastResultRight = true;
            bool isAllTrainingResultsRight = true;
            int iterationCount = 0;
            do
            {
                do
                {
                    for (int i = 0; i < TrainingVectors.Length; i++)
                    {
                        Vector currObject = TrainingVectors[i];
                        isLastResultRight = true;
                        int currClass = currObject.Class - 1;
                        int ownDecisionFunctionValue = DecisionFunctions[currClass].ScalarMultiple(currObject);

                        for (int j = 0; j < DecisionFunctions.Length; j++)
                        {
                            if (j == currClass) continue;

                            Vector currDecisionFunction = DecisionFunctions[j];

                            int decisionFunctionValue = currDecisionFunction.ScalarMultiple(currObject);
                            if (decisionFunctionValue >= ownDecisionFunctionValue)
                            {
                                DecisionFunctions[currClass].Encourage(currObject, START_CONSTANT);
                                currDecisionFunction.Punish(currObject, START_CONSTANT);
                                isLastResultRight = false;
                            }
                            iterationCount++;
                            if (iterationCount > MAX_ITERATION_COUNT) break;
                        }
                        if (iterationCount > MAX_ITERATION_COUNT) break;
                    }
                } while (!isLastResultRight);

                if (iterationCount > MAX_ITERATION_COUNT) 
                {
                    MessageBox.Show($"Количество итераций превысило {MAX_ITERATION_COUNT} - решающие функции могут давать неправильный результат!", "Превышено количество итераций", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    break;
                }

                isAllTrainingResultsRight = true;

                foreach (var currObject in TrainingVectors)
                {
                    int currClass = currObject.Class - 1;
                    int ownDecisionFunctionValue = DecisionFunctions[currClass].ScalarMultiple(currObject);

                    for (int j = 0; j < DecisionFunctions.Length; j++)
                    {
                        if (j == currClass) continue;
                        Vector currDecisionFunction = DecisionFunctions[j];

                        int decisionFunctionValue = currDecisionFunction.ScalarMultiple(currObject);
                        if (decisionFunctionValue >= ownDecisionFunctionValue)
                        {
                            isAllTrainingResultsRight = false;
                            break;
                        }
                    }
                    if (!isAllTrainingResultsRight) break;
                }
            } while (!isAllTrainingResultsRight);
        }

        private void DetermineClass(ref Vector obj) 
        {
            int maxValue = Int32.MinValue;
            int probableClass = -1;
            for (int i = 0; i < DecisionFunctions.Length; i++) 
            {
                int value = DecisionFunctions[i].ScalarMultiple(obj);
                if (value >= maxValue) 
                { 
                    maxValue = value;
                    probableClass = i;
                }
            }

            obj.Class = probableClass;
        }

        //view
        private void TrainingVectorsViewUpdate() 
        {
            lbTrainingSet.Items.Clear();
            lbDecisionFunctions.Items.Clear();

            for (int i = 0; i < TrainingVectors.Length; i++) 
            {
                if (i % ClassObjectCount == 0)
                {
                    lbTrainingSet.Items.Add($"Class {i+1}");
                    lbDecisionFunctions.Items.Add($"d{(i / ClassObjectCount) + 1} = {DecisionFunctions[i / ClassObjectCount].ToFullString()}");
                }

                lbDecisionFunctions.Items.Add("");
                lbTrainingSet.Items.Add(TrainingVectors[i].ToString());
            }
        }

        private void TestVectorsViewUpdate()
        {
            lbTestSet.Items.Clear();

            foreach (var vector in TestVectors)
            {
                lbTestSet.Items.Add(vector);
            }
        }

        private void lbTrainingSet_DrawItem(object sender, DrawItemEventArgs e)
        {
            if (e.Index < 0) return;

            ListBox lbSender = (ListBox)sender;

            string text = lbSender.Items[e.Index].ToString();

            Brush backgroundBrush = new SolidBrush(classColors[e.Index / (ClassObjectCount + 1)]);
            Brush textBrush = Brushes.Black;

            e.Graphics.FillRectangle(backgroundBrush, e.Bounds);
            e.Graphics.DrawString(text, e.Font, textBrush, e.Bounds);
        }

        private void lbTestSet_DrawItem(object sender, DrawItemEventArgs e)
        {
            if (e.Index < 0) return;

            ListBox lbSender = (ListBox)sender;

            string text = lbSender.Items[e.Index].ToString();
            Brush backgroundBrush = new SolidBrush(((e.State & DrawItemState.Selected) == DrawItemState.Selected) ? SELECTED_CELL : (classColors[TestVectors[e.Index].Class]));
            Brush textBrush = Brushes.Black;

            e.Graphics.FillRectangle(backgroundBrush, e.Bounds);
            e.Graphics.DrawString(text, e.Font, textBrush, e.Bounds);
        }
        private void lbSubstitution_DrawItem(object sender, DrawItemEventArgs e)
        {
            if (e.Index < 0) return;

            ListBox lbSender = (ListBox)sender;

            string text = lbSender.Items[e.Index].ToString();
            Brush backgroundBrush = new SolidBrush(classColors[e.Index]); // Цвет текста
            Brush textBrush = Brushes.Black; // Цвет фона

            e.Graphics.FillRectangle(backgroundBrush, e.Bounds);
            e.Graphics.DrawString(text, e.Font, textBrush, e.Bounds);
        }

        private void DisplaySubstitutions(Vector obj) 
        {
            lbSubstitution.Items.Clear();
            for (int i = 0; i < DecisionFunctions.Length; i++) 
            {
                lbSubstitution.Items.Add($"d{i+1} = {DecisionFunctions[i].Substitute(obj)} = {DecisionFunctions[i].ScalarMultiple(obj)}");
            }
        }


        //controllers
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void bthGenerateTrainingSet_Click(object sender, EventArgs e)
        {
            lbTestSet.Items.Clear();
            lbSubstitution.Items.Clear();

            _vectorGenerator = new VectorGenerator();
            _vectorGenerator.InitializeGenerator(SignCount);
            TrainingVectors = _vectorGenerator.GenerateExtendedVectors(ClassCount * ClassObjectCount);
            _vectorGenerator.DistributeByClasses(TrainingVectors, ClassObjectCount);

            CalculateDecisionFunctions();


            TrainingVectorsViewUpdate();
        }

        private void btnGenerateTestSet_Click(object sender, EventArgs e)
        {
            lbTestSet.Items.Clear();
            lbSubstitution.Items.Clear();

            TestVectors = _vectorGenerator.GenerateExtendedVectors(TestObjectCount);

            for (int i = 0; i < TestVectors.Length; i++)
            {
                DetermineClass(ref TestVectors[i]);
            }

            TestVectorsViewUpdate();
        }

        private void lbTestSet_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplaySubstitutions(TestVectors[lbTestSet.SelectedIndex]);
        }

        private void btnClearAll_Click(object sender, EventArgs e)
        {
            lbTrainingSet.Items.Clear();
            lbDecisionFunctions.Items.Clear();
            lbSubstitution.Items.Clear();
            lbTestSet.Items.Clear();    
        }
    }
}
