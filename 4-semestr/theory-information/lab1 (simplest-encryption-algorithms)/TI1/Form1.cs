using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace TI1
{
    public partial class Form1: Form
    {
        private const string EMPTY_STRING = "";
        private const string ALPHABET = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ";

        private static string m_key = EMPTY_STRING;
        private static string m_sourceText = EMPTY_STRING;
        private static string m_resultText = EMPTY_STRING;
        private static string m_output = EMPTY_STRING;
        private static bool   m_isRailway = true;


        public Form1()
        {
            InitializeComponent();
        }

        //properties
        public string Key {
            get { return m_key; }
            set { m_key = this.IsRailway ? SelectNumberFromString(value) : ProcessingString(value); this.ViewUpdate(); }
        }
        public string SourceText
        {
            get { return m_sourceText; }
            set { m_sourceText = value; this.ViewUpdate(); }
        }
        public string ResultText
        {
            get { return m_resultText; }
            set { m_resultText = value; this.ViewUpdate(); }
        }
        public bool IsRailway
        {
            get { return m_isRailway; }
            set { m_isRailway = value; this.ViewUpdate(); }
        }
        public string Output
        {
            get { return m_output; }
            set { m_output = value; this.ViewUpdate(); }
        }

        //model
        private void CloseApp() {
            this.Close();
        }

        private void ReadSourceFile() {
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                try 
                { 
                    string filePath = openFileDialog.FileName;
                    this.SourceText = File.ReadAllText(filePath);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка при чтении файла: " + ex.Message);
                }
            }
        }
        private void SaveResultFile() {
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    string filePath = saveFileDialog.FileName;
                    File.WriteAllText(filePath, this.ResultText);
                    MessageBox.Show("Файл успешно сохранен.");
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка при сохранении файла: " + ex.Message);
                }
            }
        }

        private string ProcessingString(string src) 
        {
            string result = EMPTY_STRING;
            src = src.ToUpper();
            foreach (char ch in src) {
                if (((ch >= 'А') && (ch <= 'Я')) || (ch == 'Ё')) 
                {
                    result += ch;
                }
            }
            return result;
        }
        private string SelectNumberFromString(string src) 
        {
            string result = EMPTY_STRING;
            foreach (char ch in src)
            {
                if ((ch >= '0') && (ch <= '9'))
                {
                    result += ch;
                }
            }
            return result;
        }
        private void ClearAll() {
            this.SourceText = EMPTY_STRING;
            this.ResultText = EMPTY_STRING;
            this.Key = EMPTY_STRING;
            this.Output = EMPTY_STRING;
        }
        private void ClearOutputData()
        {
            this.ResultText = EMPTY_STRING;
            this.Output = EMPTY_STRING;
        }
        private void ClearKey() 
        {
            this.Key = EMPTY_STRING;
        }

        private void InitializeModel(string sourceText, string key) 
        {
            this.SourceText = sourceText;
            this.Key = key;
            ClearOutputData();
        }

        private void EncryptPlainText(bool isRailway, string plainText, string key) 
        {
            string processedPlainText = this.ProcessingString(plainText);
            string cipherText = EMPTY_STRING;
            if (isRailway)
            {
                int iKey;
                try
                {
                    iKey = Int32.Parse(key);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка! Ключ для алгоритма 'Железнодорожная изгородь' должен являться целым числом");
                    return;
                }

                if (iKey <= 0) 
                {
                    MessageBox.Show("Ошибка! Ключ для алгоритма 'Железнодорожная изгородь' должен быть положительным числом");
                    return;
                }

                this.Output += $"Исходный текст: {Environment.NewLine}" +
                    $"{this.SourceText}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}" +
                    $"Обработанный исходный текст: {Environment.NewLine}" +
                    $"{processedPlainText}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}";


                if (iKey == 1) 
                {
                    this.ResultText = processedPlainText;
                    this.Output +=  $"Железнодорожная изгородь: {Environment.NewLine}" +
                        $"{processedPlainText}";
                    return;
                }

                //encryption
                string[] railwayFence = new string[iKey];
                for (int i = 0; i < iKey; i++)
                {
                    railwayFence[i] = EMPTY_STRING;
                }

                int str = 0;
                int direction = 1; // Направление: 1 (вниз), -1 (вверх)

                for (int col = 0; col < processedPlainText.Length; col++)
                {
                    railwayFence[str] += processedPlainText[col];
                    str += direction;
                    if (str == 0 || str == iKey - 1)
                    {
                        direction *= -1; // Меняем направление
                    }
                }
                foreach (string line in railwayFence) cipherText += line;


                //output buid
                string[] outputRailwayFence = new string[iKey];
                for (int i = 0; i < iKey; i++)
                {
                    outputRailwayFence[i] = EMPTY_STRING;
                }

                str = 0;
                direction = 1;

                for (int col = 0; col < processedPlainText.Length; col++)
                {
                    for (int i = 0; i < iKey; i++)
                    {
                        outputRailwayFence[i] += (i == str) ? processedPlainText[col] : ' ';
                    }
                    str += direction;
                    if (str == 0 || str == iKey - 1)
                    {
                        direction *= -1;
                    }
                }

                this.Output += $"Железнодорожная изгородь: {Environment.NewLine}";
                foreach (string line in outputRailwayFence) this.Output += $"{line}{Environment.NewLine}";

                this.ResultText = cipherText;
            }
            else
            {
                if (key.Length == 0)
                {
                    MessageBox.Show("Ошибка! Ключ для алгоритма Виженера не может быть пустым");
                    return;
                }

                this.Output += $"Исходный текст: {Environment.NewLine}" +
                    $"{this.SourceText}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}" +
                    $"Обработанный исходный текст: {Environment.NewLine}" +
                    $"{processedPlainText}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}";

                int textLength = processedPlainText.Length;
                int keyLength = key.Length;
                int counter = 0;
                string newKey = "";


                while (counter < textLength) 
                {
                    var currSymb = key[counter % keyLength];
                    int symbIndex = GetSymbIndex(currSymb);
                    newKey += ALPHABET[(symbIndex + counter / keyLength) % 33]; 
                    counter++;
                }

                this.Output += $"Прогрессивный ключ:{Environment.NewLine}" +
                    $"{newKey}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}";
                for (int i = 0; i < textLength; i++) 
                {
                    cipherText += ALPHABET[(GetSymbIndex(processedPlainText[i]) + GetSymbIndex(newKey[i])) % 33];
                }
                this.Output += cipherText;
                this.ResultText = cipherText;
            }
        }

        private void DecryptCipherText(bool isRailway, string cipherText, string key)
        {
            string processedCipherText = this.ProcessingString(cipherText);
            string resultPlainText = EMPTY_STRING;
            if (isRailway)
            {
                int iKey;
                try
                {
                    iKey = Int32.Parse(key);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка! Ключ для алгоритма 'Железнодорожная изгородь' должен являться целым числом");
                    return;
                }

                if (iKey <= 0)
                {
                    MessageBox.Show("Ошибка! Ключ для алгоритма 'Железнодорожная изгородь' должен быть положительным числом");
                    return;
                }

                this.Output += $"Исходный текст: {Environment.NewLine}" +
                    $"{this.SourceText}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}" +
                    $"Обработанный исходный текст: {Environment.NewLine}" +
                    $"{processedCipherText}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}";

                if (iKey == 1)
                {
                    this.ResultText = processedCipherText;
                    this.Output += processedCipherText;
                    return;
                }

                //decryption
                string[] railwayFence = new string[iKey];
                for (int i = 0; i < iKey; i++)
                {
                    railwayFence[i] = new string(' ', cipherText.Length);
                }

                int str = 0;
                int direction = 1; // Направление: 1 (вниз), -1 (вверх)
                for (int col = 0; col < cipherText.Length; col++)
                {
                    railwayFence[str] = railwayFence[str].Remove(col, 1).Insert(col, "*");
                    str += direction;
                    if (str == 0 || str == iKey - 1)
                    {
                        direction *= -1; // Меняем направление
                    }
                }

                int index = 0;
                for (int i = 0; i < iKey; i++)
                {
                    for (int j = 0; j < cipherText.Length; j++)
                    {
                        if (railwayFence[i][j] == '*' && index < cipherText.Length)
                        {
                            railwayFence[i] = railwayFence[i].Remove(j, 1).Insert(j, cipherText[index].ToString());
                            index++;
                        }
                    }
                }
                
                this.Output += $"Железнодорожная изгородь: {Environment.NewLine}";
                foreach (string line in railwayFence) this.Output += $"{line}{Environment.NewLine}";

                // Восстановление исходного текста
                str = 0;
                direction = 1;
                for (int col = 0; col < cipherText.Length; col++)
                {
                    resultPlainText += railwayFence[str][col];
                    str += direction;
                    if (str == 0 || str == iKey - 1)
                    {
                        direction *= -1; // Меняем направление
                    }
                }

                this.ResultText = resultPlainText;
            }
            else
            {
                if (key.Length == 0)
                {
                    MessageBox.Show("Ошибка! Ключ для алгоритма Виженера не может быть пустым");
                    return;
                }

                this.Output += $"Исходный текст: {Environment.NewLine}" +
                    $"{this.SourceText}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}" +
                    $"Обработанный исходный текст: {Environment.NewLine}" +
                    $"{processedCipherText}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}";

                int textLength = processedCipherText.Length;
                int keyLength = key.Length;
                int counter = 0;
                string newKey = "";

                while (counter < textLength)
                {
                    var currSymb = key[counter % keyLength];
                    int symbIndex = GetSymbIndex(currSymb);
                    newKey += ALPHABET[(symbIndex + counter / keyLength) % 33];
                    counter++;
                }
                this.Output += $"Прогрессивный ключ:{Environment.NewLine}" +
                    $"{newKey}{Environment.NewLine}" +
                    $"------------------------------------------------------------------------------------------------{Environment.NewLine}";

                for (int i = 0; i < textLength; i++)
                {
                    resultPlainText += ALPHABET[(GetSymbIndex(processedCipherText[i]) - GetSymbIndex(newKey[i]) + 33) % 33];
                }
                this.Output += resultPlainText;
                this.ResultText = resultPlainText;
            }
        }

        private int GetSymbIndex(int ch) 
        {
            int symbIndex = ((ch - 'А') + ((ch == 'Ё') ? 21 : (ch > 'Е') ? 1 : 0));
            return symbIndex;
        }

        private void ChangeAlgorithm(bool rbtnRailwayValue) {
            if (this.IsRailway != rbtnRailwayValue) 
            {
                IsRailway = rbtnRailwayValue;
                this.ClearOutputData();
            }
        }

        //view
        private void ViewUpdate() {
            tbKey.Text = this.Key;
            tbSourceText.Text = this.SourceText;
            tbResultText.Text = this.ResultText;
            tbOutput.Text = this.Output;
        }

        //controllers
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.CloseApp();
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            this.ClearAll();
        }

        private void btnOpenFile_Click(object sender, EventArgs e)
        {
            this.ReadSourceFile();
        }

        private void btnSaveFile_Click(object sender, EventArgs e)
        {
            this.SaveResultFile();
        }

        private void btnEncrypt_Click(object sender, EventArgs e)
        {
            this.InitializeModel(tbSourceText.Text, tbKey.Text);
            this.EncryptPlainText(this.IsRailway, this.SourceText, this.Key);
        }

        private void rbtnAlgorithm_CheckedChanged(object sender, EventArgs e)
        {
            this.ChangeAlgorithm(rbtnRailway.Checked);
        }

        private void btnClearKey_Click(object sender, EventArgs e)
        {
            this.ClearKey();
        }

        private void btnDecrypt_Click(object sender, EventArgs e)
        {
            this.InitializeModel(tbSourceText.Text, tbKey.Text);
            this.DecryptCipherText(this.IsRailway, this.SourceText, this.Key);
        }
    }
}
