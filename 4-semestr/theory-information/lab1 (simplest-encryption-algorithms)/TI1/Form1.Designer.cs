namespace TI1
{
    partial class Form1
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.pRailway = new System.Windows.Forms.Panel();
            this.pResultText = new System.Windows.Forms.Panel();
            this.tbResultText = new System.Windows.Forms.TextBox();
            this.lResultText = new System.Windows.Forms.Label();
            this.pSourceText = new System.Windows.Forms.Panel();
            this.tbSourceText = new System.Windows.Forms.TextBox();
            this.lSourceText = new System.Windows.Forms.Label();
            this.pSideMenu = new System.Windows.Forms.Panel();
            this.btnClearKey = new System.Windows.Forms.Button();
            this.gbAlgorithm = new System.Windows.Forms.GroupBox();
            this.rbtnVigenera = new System.Windows.Forms.RadioButton();
            this.rbtnRailway = new System.Windows.Forms.RadioButton();
            this.btnSaveFile = new System.Windows.Forms.Button();
            this.btnOpenFile = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.btnClear = new System.Windows.Forms.Button();
            this.btnDecrypt = new System.Windows.Forms.Button();
            this.btnEncrypt = new System.Windows.Forms.Button();
            this.lRailwayKey = new System.Windows.Forms.Label();
            this.tbKey = new System.Windows.Forms.TextBox();
            this.tbOutput = new System.Windows.Forms.TextBox();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.pRailway.SuspendLayout();
            this.pResultText.SuspendLayout();
            this.pSourceText.SuspendLayout();
            this.pSideMenu.SuspendLayout();
            this.gbAlgorithm.SuspendLayout();
            this.SuspendLayout();
            // 
            // pRailway
            // 
            this.pRailway.BackColor = System.Drawing.Color.Cornsilk;
            this.pRailway.Controls.Add(this.pResultText);
            this.pRailway.Controls.Add(this.pSourceText);
            this.pRailway.Controls.Add(this.pSideMenu);
            this.pRailway.Controls.Add(this.tbOutput);
            this.pRailway.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pRailway.Location = new System.Drawing.Point(0, 0);
            this.pRailway.Name = "pRailway";
            this.pRailway.Size = new System.Drawing.Size(1382, 853);
            this.pRailway.TabIndex = 1;
            // 
            // pResultText
            // 
            this.pResultText.AutoSize = true;
            this.pResultText.BackColor = System.Drawing.SystemColors.Window;
            this.pResultText.Controls.Add(this.tbResultText);
            this.pResultText.Controls.Add(this.lResultText);
            this.pResultText.Dock = System.Windows.Forms.DockStyle.Right;
            this.pResultText.Location = new System.Drawing.Point(861, 0);
            this.pResultText.Name = "pResultText";
            this.pResultText.Size = new System.Drawing.Size(521, 515);
            this.pResultText.TabIndex = 3;
            // 
            // tbResultText
            // 
            this.tbResultText.BackColor = System.Drawing.Color.White;
            this.tbResultText.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tbResultText.Location = new System.Drawing.Point(10, 33);
            this.tbResultText.Multiline = true;
            this.tbResultText.Name = "tbResultText";
            this.tbResultText.ReadOnly = true;
            this.tbResultText.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.tbResultText.Size = new System.Drawing.Size(508, 462);
            this.tbResultText.TabIndex = 9;
            // 
            // lResultText
            // 
            this.lResultText.AutoSize = true;
            this.lResultText.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lResultText.Location = new System.Drawing.Point(13, 9);
            this.lResultText.Name = "lResultText";
            this.lResultText.Size = new System.Drawing.Size(180, 20);
            this.lResultText.TabIndex = 8;
            this.lResultText.Text = "Результат работы";
            // 
            // pSourceText
            // 
            this.pSourceText.BackColor = System.Drawing.SystemColors.Window;
            this.pSourceText.Controls.Add(this.tbSourceText);
            this.pSourceText.Controls.Add(this.lSourceText);
            this.pSourceText.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSourceText.Location = new System.Drawing.Point(318, 0);
            this.pSourceText.Name = "pSourceText";
            this.pSourceText.Size = new System.Drawing.Size(530, 515);
            this.pSourceText.TabIndex = 2;
            // 
            // tbSourceText
            // 
            this.tbSourceText.BackColor = System.Drawing.Color.White;
            this.tbSourceText.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tbSourceText.Location = new System.Drawing.Point(10, 32);
            this.tbSourceText.Multiline = true;
            this.tbSourceText.Name = "tbSourceText";
            this.tbSourceText.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.tbSourceText.Size = new System.Drawing.Size(508, 463);
            this.tbSourceText.TabIndex = 8;
            // 
            // lSourceText
            // 
            this.lSourceText.AutoSize = true;
            this.lSourceText.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lSourceText.Location = new System.Drawing.Point(6, 9);
            this.lSourceText.Name = "lSourceText";
            this.lSourceText.Size = new System.Drawing.Size(158, 20);
            this.lSourceText.TabIndex = 7;
            this.lSourceText.Text = "Исходный текст";
            // 
            // pSideMenu
            // 
            this.pSideMenu.BackColor = System.Drawing.Color.Coral;
            this.pSideMenu.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.pSideMenu.Controls.Add(this.btnClearKey);
            this.pSideMenu.Controls.Add(this.gbAlgorithm);
            this.pSideMenu.Controls.Add(this.btnSaveFile);
            this.pSideMenu.Controls.Add(this.btnOpenFile);
            this.pSideMenu.Controls.Add(this.btnExit);
            this.pSideMenu.Controls.Add(this.btnClear);
            this.pSideMenu.Controls.Add(this.btnDecrypt);
            this.pSideMenu.Controls.Add(this.btnEncrypt);
            this.pSideMenu.Controls.Add(this.lRailwayKey);
            this.pSideMenu.Controls.Add(this.tbKey);
            this.pSideMenu.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSideMenu.Location = new System.Drawing.Point(0, 0);
            this.pSideMenu.Name = "pSideMenu";
            this.pSideMenu.Size = new System.Drawing.Size(318, 515);
            this.pSideMenu.TabIndex = 1;
            // 
            // btnClearKey
            // 
            this.btnClearKey.BackColor = System.Drawing.Color.White;
            this.btnClearKey.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnClearKey.Location = new System.Drawing.Point(8, 156);
            this.btnClearKey.Name = "btnClearKey";
            this.btnClearKey.Size = new System.Drawing.Size(297, 30);
            this.btnClearKey.TabIndex = 8;
            this.btnClearKey.Text = "Очистить ключ";
            this.btnClearKey.UseVisualStyleBackColor = false;
            this.btnClearKey.Click += new System.EventHandler(this.btnClearKey_Click);
            // 
            // gbAlgorithm
            // 
            this.gbAlgorithm.Controls.Add(this.rbtnVigenera);
            this.gbAlgorithm.Controls.Add(this.rbtnRailway);
            this.gbAlgorithm.Cursor = System.Windows.Forms.Cursors.Hand;
            this.gbAlgorithm.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.gbAlgorithm.Location = new System.Drawing.Point(8, 10);
            this.gbAlgorithm.Margin = new System.Windows.Forms.Padding(10);
            this.gbAlgorithm.Name = "gbAlgorithm";
            this.gbAlgorithm.Size = new System.Drawing.Size(297, 85);
            this.gbAlgorithm.TabIndex = 7;
            this.gbAlgorithm.TabStop = false;
            this.gbAlgorithm.Text = "Алгоритм";
            // 
            // rbtnVigenera
            // 
            this.rbtnVigenera.AutoSize = true;
            this.rbtnVigenera.Location = new System.Drawing.Point(4, 49);
            this.rbtnVigenera.Name = "rbtnVigenera";
            this.rbtnVigenera.Size = new System.Drawing.Size(122, 24);
            this.rbtnVigenera.TabIndex = 1;
            this.rbtnVigenera.Text = "Виженера";
            this.rbtnVigenera.UseVisualStyleBackColor = true;
            this.rbtnVigenera.CheckedChanged += new System.EventHandler(this.rbtnAlgorithm_CheckedChanged);
            // 
            // rbtnRailway
            // 
            this.rbtnRailway.AutoSize = true;
            this.rbtnRailway.Checked = true;
            this.rbtnRailway.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.rbtnRailway.Location = new System.Drawing.Point(4, 21);
            this.rbtnRailway.Name = "rbtnRailway";
            this.rbtnRailway.Size = new System.Drawing.Size(256, 22);
            this.rbtnRailway.TabIndex = 0;
            this.rbtnRailway.TabStop = true;
            this.rbtnRailway.Text = "Железнодорожная изгородь";
            this.rbtnRailway.UseVisualStyleBackColor = true;
            this.rbtnRailway.CheckedChanged += new System.EventHandler(this.rbtnAlgorithm_CheckedChanged);
            // 
            // btnSaveFile
            // 
            this.btnSaveFile.BackColor = System.Drawing.Color.White;
            this.btnSaveFile.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnSaveFile.Location = new System.Drawing.Point(8, 367);
            this.btnSaveFile.Name = "btnSaveFile";
            this.btnSaveFile.Size = new System.Drawing.Size(297, 30);
            this.btnSaveFile.TabIndex = 4;
            this.btnSaveFile.Text = "Сохранить результат в файл";
            this.btnSaveFile.UseVisualStyleBackColor = false;
            this.btnSaveFile.Click += new System.EventHandler(this.btnSaveFile_Click);
            // 
            // btnOpenFile
            // 
            this.btnOpenFile.BackColor = System.Drawing.Color.White;
            this.btnOpenFile.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnOpenFile.Location = new System.Drawing.Point(8, 331);
            this.btnOpenFile.Name = "btnOpenFile";
            this.btnOpenFile.Size = new System.Drawing.Size(297, 30);
            this.btnOpenFile.TabIndex = 3;
            this.btnOpenFile.Text = "Открыть текст из файла";
            this.btnOpenFile.UseVisualStyleBackColor = false;
            this.btnOpenFile.Click += new System.EventHandler(this.btnOpenFile_Click);
            // 
            // btnExit
            // 
            this.btnExit.BackColor = System.Drawing.Color.White;
            this.btnExit.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnExit.Location = new System.Drawing.Point(8, 454);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(297, 30);
            this.btnExit.TabIndex = 6;
            this.btnExit.Text = "Выйти";
            this.btnExit.UseVisualStyleBackColor = false;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.White;
            this.btnClear.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnClear.Location = new System.Drawing.Point(8, 418);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(297, 30);
            this.btnClear.TabIndex = 5;
            this.btnClear.Text = "Очистить все";
            this.btnClear.UseVisualStyleBackColor = false;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // btnDecrypt
            // 
            this.btnDecrypt.BackColor = System.Drawing.Color.White;
            this.btnDecrypt.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnDecrypt.Location = new System.Drawing.Point(3, 264);
            this.btnDecrypt.Name = "btnDecrypt";
            this.btnDecrypt.Size = new System.Drawing.Size(297, 30);
            this.btnDecrypt.TabIndex = 2;
            this.btnDecrypt.Text = "Дешифровать";
            this.btnDecrypt.UseVisualStyleBackColor = false;
            this.btnDecrypt.Click += new System.EventHandler(this.btnDecrypt_Click);
            // 
            // btnEncrypt
            // 
            this.btnEncrypt.BackColor = System.Drawing.Color.White;
            this.btnEncrypt.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnEncrypt.Location = new System.Drawing.Point(3, 228);
            this.btnEncrypt.Name = "btnEncrypt";
            this.btnEncrypt.Size = new System.Drawing.Size(297, 30);
            this.btnEncrypt.TabIndex = 1;
            this.btnEncrypt.Text = "Шифровать";
            this.btnEncrypt.UseVisualStyleBackColor = false;
            this.btnEncrypt.Click += new System.EventHandler(this.btnEncrypt_Click);
            // 
            // lRailwayKey
            // 
            this.lRailwayKey.AutoSize = true;
            this.lRailwayKey.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lRailwayKey.Location = new System.Drawing.Point(4, 105);
            this.lRailwayKey.Name = "lRailwayKey";
            this.lRailwayKey.Size = new System.Drawing.Size(57, 20);
            this.lRailwayKey.TabIndex = 1;
            this.lRailwayKey.Text = "Ключ";
            // 
            // tbKey
            // 
            this.tbKey.Location = new System.Drawing.Point(8, 128);
            this.tbKey.Name = "tbKey";
            this.tbKey.Size = new System.Drawing.Size(297, 22);
            this.tbKey.TabIndex = 0;
            // 
            // tbOutput
            // 
            this.tbOutput.BackColor = System.Drawing.Color.White;
            this.tbOutput.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tbOutput.Cursor = System.Windows.Forms.Cursors.Hand;
            this.tbOutput.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.tbOutput.Font = new System.Drawing.Font("Courier New", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tbOutput.Location = new System.Drawing.Point(0, 515);
            this.tbOutput.Multiline = true;
            this.tbOutput.Name = "tbOutput";
            this.tbOutput.ReadOnly = true;
            this.tbOutput.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.tbOutput.Size = new System.Drawing.Size(1382, 338);
            this.tbOutput.TabIndex = 1;
            this.tbOutput.WordWrap = false;
            // 
            // openFileDialog
            // 
            this.openFileDialog.DefaultExt = "txt";
            this.openFileDialog.Filter = "Текстовые файлы|*.txt";
            // 
            // saveFileDialog
            // 
            this.saveFileDialog.Filter = "Текстовые файлы|*.txt";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1382, 853);
            this.Controls.Add(this.pRailway);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(1400, 1300);
            this.MinimumSize = new System.Drawing.Size(1400, 700);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Лабораторная работа 1, Вариант 2, 351004, Наривончик Александр";
            this.pRailway.ResumeLayout(false);
            this.pRailway.PerformLayout();
            this.pResultText.ResumeLayout(false);
            this.pResultText.PerformLayout();
            this.pSourceText.ResumeLayout(false);
            this.pSourceText.PerformLayout();
            this.pSideMenu.ResumeLayout(false);
            this.pSideMenu.PerformLayout();
            this.gbAlgorithm.ResumeLayout(false);
            this.gbAlgorithm.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Panel pRailway;
        private System.Windows.Forms.TextBox tbOutput;
        private System.Windows.Forms.Panel pSideMenu;
        private System.Windows.Forms.Label lRailwayKey;
        private System.Windows.Forms.TextBox tbKey;
        private System.Windows.Forms.Button btnDecrypt;
        private System.Windows.Forms.Button btnEncrypt;
        private System.Windows.Forms.Button btnSaveFile;
        private System.Windows.Forms.Button btnOpenFile;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Panel pSourceText;
        private System.Windows.Forms.Panel pResultText;
        private System.Windows.Forms.Label lSourceText;
        private System.Windows.Forms.TextBox tbResultText;
        private System.Windows.Forms.Label lResultText;
        private System.Windows.Forms.TextBox tbSourceText;
        private System.Windows.Forms.GroupBox gbAlgorithm;
        private System.Windows.Forms.RadioButton rbtnVigenera;
        private System.Windows.Forms.RadioButton rbtnRailway;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.SaveFileDialog saveFileDialog;
        private System.Windows.Forms.Button btnClearKey;
    }
}

