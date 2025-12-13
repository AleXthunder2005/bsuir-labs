using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace miapr7
{
    public partial class fMain: Form
    {
        private Drawer _drawer;
        private Resolver _resolver;
        private bool _startLineFlag = false;
        private Point _startPoint;
        private Point _endPoint;

        public fMain()
        {
            InitializeComponent();
            pContent.CreateGraphics();
            _drawer = new Drawer();
            this.pContent.Paint += pContent_Paint;
        }

        private void pContent_Paint(object sender, PaintEventArgs e)
        {
            if (_drawer != null)
            {
                _drawer.UpdateGraphics(e.Graphics);
            }
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void pContent_MouseClick(object sender, MouseEventArgs e)
        {
            if (!_startLineFlag)
            {
                _startLineFlag = true;
                _startPoint = new Point(e.X, e.Y);
            }
            else 
            {
                _startLineFlag = false;
                _endPoint = new Point(e.X, e.Y);
                _drawer.AddTerminal(_startPoint, _endPoint);
                pContent.Invalidate();
            }
        }

        private void btnClean_Click(object sender, EventArgs e)
        {
            if (_drawer != null)
            {
                _drawer.ClearTerminals();
                pContent.Invalidate();
            }
        }

        private void btnRecognize_Click(object sender, EventArgs e)
        {
            if (_drawer != null) 
            {
                _resolver = new Resolver(_drawer.Terminals);

                Point leftPoint = new Point();
                List<int> digits = _resolver.Digit(out leftPoint);

                if (digits.Count > 0)
                {
                    digits.Sort();
                    StringBuilder stringBuilder = new StringBuilder();
                    foreach (int digit in digits)
                    {
                        stringBuilder.Append($"{digit}, ");
                    }
                    stringBuilder.Length -= 2;

                    MessageBox.Show($"Распознаны цифры: {stringBuilder.ToString()}!", "Распознавание", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else 
                {
                    MessageBox.Show($"Не распознано ни одной цифры!", "Распознавание", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
        }
    }
}
