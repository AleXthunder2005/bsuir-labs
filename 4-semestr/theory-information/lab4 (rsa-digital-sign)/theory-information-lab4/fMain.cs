using System;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;

namespace theory_information_lab4
{
    public partial class fMain: Form
    {
        private int _p;
        private int _q;
        private long _r;
        private long _phi;
        private long _d;
        private long _e;
        private string _data = "";
        private Validator _validator;

        public fMain()
        {
            InitializeComponent();
            _validator = new Validator();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnAccept_Click(object sender, EventArgs e)
        {
            if (_validator.IsValidRSAPrimeComponent(tbP.Text, "P") && 
                _validator.IsValidRSAPrimeComponent(tbQ.Text, "q"))
            {
                _p = int.Parse(tbP.Text);
                _q = int.Parse(tbQ.Text);
                if (!_validator.IsValidPAndQ(_p, _q)) return;

                _r = _p * _q;
                _phi = (_p - 1) * (_q - 1);
                
                lRValue.Text = _r.ToString();
                lPhiValue.Text = _phi.ToString();

                var degrees = RSAModule.CalculateRSADegreeList(_phi);

                cbD.DataSource = new List<long>(degrees);
                //cbE.DataSource = new List<long>(degrees);

                cbD.SelectedIndex = -1;
                cbE.SelectedIndex = -1;

                cbD.Enabled = true;
                cbE.Enabled = true;
                btnCheckSignature.Enabled = true;
                btnSignature.Enabled = true;
            }
        }

        private void btnSignature_Click(object sender, EventArgs e)
        {
            if (_validator.IsValidRSADegree(cbD.Text, _phi, "D"))
            {
                _d = long.Parse(cbD.Text);
                lOpenDegreeValue.Text = RSAModule.CalculateOpenKeyComponent(_d, _phi).ToString();

                long hash;
                long signature = RSAModule.GenerateSignature(_data, _d, _r, out hash);
                if (signature < 0) return;


                lHashValue.Text = hash.ToString();

                AppendSignatureToText(ref _data, signature);
                tbData.Text = _data;
            }
        }

        private void btnCheckSignature_Click(object sender, EventArgs e)
        {
            if (_validator.IsValidE(cbE.Text))
            {
                _e = long.Parse(cbE.Text);

                string message;
                long fileSignature;

                if (SplitSignedTextToMessageAndSignature(_data, out message, out fileSignature)) 
                {
                    long hash;
                    long decryptedFileHash;
                    if (RSAModule.IsSignatureAuthentic(message, fileSignature, _e, _r, out hash, out decryptedFileHash))
                    {
                        lHashValue.Text = hash.ToString();
                        MessageBox.Show($"Подпись {fileSignature} является корректной!", "Проверка подписи", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else 
                    {
                        lHashValue.Text = hash.ToString();
                        MessageBox.Show($"Подпись {fileSignature} не является корректной (Хэш-образ сообщения: {hash}, Хэш-образ из цифровой подписи: {decryptedFileHash})!", "Проверка подписи", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }

        private void btnOpenFile_Click(object sender, EventArgs e)
        {
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    _data = File.ReadAllText(openFileDialog.FileName);
                }
                catch 
                {
                    MessageBox.Show($"Ошибка чтения файла {openFileDialog.FileName}", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    _data = "";
                }
                tbData.Text = _data;
            }
        }

        private void btnSaveFile_Click(object sender, EventArgs e)
        {
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    File.WriteAllText(saveFileDialog.FileName, _data);
                }
                catch
                {
                    MessageBox.Show($"Ошибка записи в файл {saveFileDialog.FileName}", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }


        private void AppendSignatureToText(ref string data, long signature)
        {
            data += $"{Environment.NewLine}{signature}";
        }

        private bool SplitSignedTextToMessageAndSignature(string data, out string message, out long signature)
        {
            message = string.Empty;
            signature = 0;

            if (string.IsNullOrEmpty(data))
            {
                MessageBox.Show($"Подпись не обнаружена! Файл пустой!", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
                
            // Находим последний перевод строки в тексте
            int lastNewLineIndex = data.LastIndexOf(Environment.NewLine, StringComparison.Ordinal);
            
            if (lastNewLineIndex < 0) // Если не нашли разделитель
            {
                MessageBox.Show($"Подпись не обнаружена!", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }

            // Разделяем текст на сообщение и подпись
            message = data.Substring(0, lastNewLineIndex);
            string signatureStr = data.Substring(lastNewLineIndex + Environment.NewLine.Length); // +2 чтобы пропустить "\n\r"

            if (!long.TryParse(signatureStr, out signature)) // Пытаемся распарсить подпись
            {
                MessageBox.Show($"Невозможно распознать подпись! Подпись повреждена!", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }

            return true;
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            _data = "";
            tbData.Text = _data;
        }
    }
}
