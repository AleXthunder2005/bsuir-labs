using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace miapr5
{
    public partial class fMain: Form
    {
        private ItemsGenerator _itemsGenerator = null;
        private Trainer _trainer = null;
        private Classificator _classificator = null;

        private int ContentWidth { get {return this.ClientSize.Width - pSide.Width; } }
        private int ContentHeight { get { return this.ClientSize.Height; } }
        private int ClassPresenterCount { get; set; }

        public fMain()
        {
            InitializeComponent();
        }
        
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGenerateObjects_Click(object sender, EventArgs e)
        {
            ClassPresenterCount = (int)udClassPresenterCount.Value;
            _itemsGenerator = new ItemsGenerator(ContentWidth, ContentHeight, ClassPresenterCount);
            
            pContent.Invalidate();
        }

        private void pContent_Paint(object sender, PaintEventArgs e)
        {
            if (_itemsGenerator != null)
                _itemsGenerator.DrawItems(e.Graphics);
        }

        private void btnStartClassification_Click(object sender, EventArgs e)
        {
            if (_itemsGenerator != null)
            {
                _trainer = new Trainer(_itemsGenerator.Kernels);
                _trainer.StartTraining();

                _classificator = new Classificator(_itemsGenerator.Items, _trainer.SumPotential);
                _classificator.StartClassification();

                pContent.Invalidate();
            }
        }
    }
}
