using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace miapr8
{
    public partial class fMain: Form
    {
        private Trainer _trainer;

        public fMain()
        {
            InitializeComponent();
        }

        public List<string> GetTrainingLinesList(TextBox textBox)
        {
            string[] lines =  textBox.Lines
                          .Where(line => !string.IsNullOrWhiteSpace(line))
                          .ToArray();

            List<string> linesList = new List<string>();
            foreach (string line in lines) 
            {
                linesList.Add(line);
            }
            return linesList;
        }

        public void ClearAll() 
        {
            tbGeneratedLines.Clear();
            tbGrammarLines.Clear();
        }


        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnTrain_Click(object sender, EventArgs e)
        {
            if (tbTrainingLines.Text == "")
            {
                MessageBox.Show("Не задана обучающая выборка", "Задайте обучающую выборку", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else 
            {
                ClearAll();
                _trainer = new Trainer(GetTrainingLinesList(tbTrainingLines));
                _trainer.CreateGrammar();
                string grammar = _trainer.OutputGrammarText();
                tbGrammarLines.Text = grammar;
            }
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            if (_trainer != null) 
            {
                tbGeneratedLines.Text += $"{_trainer.GenerateString(10)}{Environment.NewLine}";
            }
        }
    }
}
