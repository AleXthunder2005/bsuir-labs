using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Text;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using static theory_information_lab2.ModelFunctions;
using static System.Net.Mime.MediaTypeNames;

namespace theory_information_lab2
{
    public partial class fMain: Form
    {
        private string _key = EMPTY_STRING;
        private string _resultKeyText = EMPTY_STRING;
        private string _sourceDataText = EMPTY_STRING;
        private string _resultDataText = EMPTY_STRING;

        byte[] _sourceData;
        byte[] _resultData;
        byte[] _keyData;
        



        public fMain()
        {
            InitializeComponent();
            InitializeUserComponent();
        }

        //model
        private void InitializeUserComponent() 
        {
            lRegisterSize.Text = REGISTER_SIZE.ToString();
            lPolynom.Text = POLYNOM;

            StartParsePolynom();
        }
        private void CloseApplication() 
        {
            this.Close();
        }
        private void ClearAll()
        {
            _key = EMPTY_STRING;
            _sourceDataText = EMPTY_STRING;
            _resultDataText = EMPTY_STRING;
        }
        private void StartEncryption() 
        {
            _keyData = GenerateKey(_key, _sourceData.LongLength);
            _resultKeyText = ConvertByteArrayToBinaryText(_keyData);

            ViewUpdate();
        }

        private void ProcessData() 
        {
            _resultData = new byte[_sourceData.Length];
            for (int i = 0; i < _sourceData.Length; i++) {
                _resultData[i] = (byte) (_sourceData[i] ^ _keyData[i]);   
            }
            _resultDataText = ConvertByteArrayToBinaryText(_resultData);
        }

        //view
        private void ViewUpdate() 
        {
            tbKey.Text = _key;
            tbResultKey.Text = _resultKeyText;
            tbSourceData.Text = _sourceDataText;
            tbResultData.Text = _resultDataText;
        }


        //controllers
        private void btnExit_Click(object sender, EventArgs e)
        {
            CloseApplication();
        }

        private void btnClearAll_Click(object sender, EventArgs e)
        {
            ClearAll();
            ViewUpdate();
        }

        private void btnOpenFile_Click(object sender, EventArgs e)
        {
            if (openFileDialog.ShowDialog() == DialogResult.OK) 
            {
                string path = openFileDialog.FileName;
                try
                {
                    _sourceData = File.ReadAllBytes(path);
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при чтении файла: {ex.Message}", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

            _sourceDataText = ConvertByteArrayToBinaryText(_sourceData);
            _resultKeyText = EMPTY_STRING;
            _resultDataText = EMPTY_STRING;
            ViewUpdate();
        }

        private void btnSaveFile_Click(object sender, EventArgs e)
        {
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                string path = saveFileDialog.FileName;
                try
                {
                    File.WriteAllBytes(path, _resultData);
                    MessageBox.Show("Файл успешно сохранён!", "Сохранено успешно", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при записи файла: {ex.Message}", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void btnClearKey_Click(object sender, EventArgs e)
        {
            _key = EMPTY_STRING;
            ViewUpdate();
        }

        private void tbKey_KeyPress(object sender, KeyPressEventArgs e)
        {
            TextBox tbTextBox = sender as TextBox;
            int maxTextLength = tbTextBox.Equals(tbKey) ? REGISTER_SIZE : 4 * REGISTER_SIZE;

            bool isAllowed;
            isAllowed = IsLengthSuitable(EraseSpliters(tbTextBox.Text).Length, maxTextLength) &&
                        IsKeyBinaryDigit(e.KeyChar) ||
                        e.KeyChar == '\b';

            e.Handled = !isAllowed; //если не разрешено к обработке - значит считаем что уже обработали
        }

        private void tbKey_KeyDown(object sender, KeyEventArgs e)
        {
            bool isAllowed;
            isAllowed = e.KeyCode == Keys.Delete;

            e.Handled = !isAllowed; //если не разрешено к обработке - значит считаем что уже обработали                
        }

        private void tbKey_KeyUp(object sender, KeyEventArgs e)
        {
            TextBox tbTextBox = sender as TextBox;

            int cursorPosition = tbTextBox.SelectionStart;
            string text = tbTextBox.Text;

            int spaceBeforeCursorCount = text.Substring(0, cursorPosition).Count(c => c == SPLITER);
            int necessarySpaceBeforeCount = EraseSpliters(text.Substring(0, cursorPosition)).Length / 8;
            tbTextBox.Text = ConvertTextToBytes(text);

            tbTextBox.SelectionStart = cursorPosition + (necessarySpaceBeforeCount - spaceBeforeCursorCount);
        }

        private void btnEncryption_Click(object sender, EventArgs e)
        {
            _key = tbKey.Text;
            if (EraseSpliters(_key).Length == REGISTER_SIZE)
            {
                if (_sourceDataText != EMPTY_STRING)
                {
                    StartEncryption();
                    ProcessData();
                    ViewUpdate();
                }
                else 
                {
                    MessageBox.Show($"Не выбран файл для шифрования (дешифрования)!", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else 
            {
                MessageBox.Show($"Недостаточная длина ключа!", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void tbKey_TextChanged(object sender, EventArgs e)
        {
            _key = tbKey.Text;
        }
    }
}
