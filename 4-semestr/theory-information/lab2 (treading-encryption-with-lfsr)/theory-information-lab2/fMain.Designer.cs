namespace theory_information_lab2
{
    partial class fMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.pSide = new System.Windows.Forms.Panel();
            this.btnEncryption = new System.Windows.Forms.Button();
            this.btnClearAll = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.btnSaveFile = new System.Windows.Forms.Button();
            this.btnOpenFile = new System.Windows.Forms.Button();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.lResultKey = new System.Windows.Forms.Label();
            this.tbResultKey = new System.Windows.Forms.TextBox();
            this.tbSourceData = new System.Windows.Forms.TextBox();
            this.lSourceData = new System.Windows.Forms.Label();
            this.tbResultData = new System.Windows.Forms.TextBox();
            this.lResultData = new System.Windows.Forms.Label();
            this.lKey = new System.Windows.Forms.Label();
            this.tbKey = new System.Windows.Forms.TextBox();
            this.lRegisterSizeTitle = new System.Windows.Forms.Label();
            this.lPolynomTitle = new System.Windows.Forms.Label();
            this.lRegisterSize = new System.Windows.Forms.Label();
            this.lPolynom = new System.Windows.Forms.Label();
            this.btnClearKey = new System.Windows.Forms.Button();
            this.pSide.SuspendLayout();
            this.SuspendLayout();
            // 
            // pSide
            // 
            this.pSide.BackColor = System.Drawing.Color.Plum;
            this.pSide.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pSide.Controls.Add(this.btnEncryption);
            this.pSide.Controls.Add(this.btnClearAll);
            this.pSide.Controls.Add(this.btnExit);
            this.pSide.Controls.Add(this.btnSaveFile);
            this.pSide.Controls.Add(this.btnOpenFile);
            this.pSide.Dock = System.Windows.Forms.DockStyle.Top;
            this.pSide.Location = new System.Drawing.Point(0, 0);
            this.pSide.Name = "pSide";
            this.pSide.Size = new System.Drawing.Size(1182, 99);
            this.pSide.TabIndex = 0;
            // 
            // btnEncryption
            // 
            this.btnEncryption.BackColor = System.Drawing.Color.AliceBlue;
            this.btnEncryption.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnEncryption.Location = new System.Drawing.Point(339, 10);
            this.btnEncryption.Name = "btnEncryption";
            this.btnEncryption.Size = new System.Drawing.Size(291, 79);
            this.btnEncryption.TabIndex = 4;
            this.btnEncryption.Text = "Шифровать / Дешифровать";
            this.btnEncryption.UseVisualStyleBackColor = false;
            this.btnEncryption.Click += new System.EventHandler(this.btnEncryption_Click);
            // 
            // btnClearAll
            // 
            this.btnClearAll.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnClearAll.BackColor = System.Drawing.Color.AliceBlue;
            this.btnClearAll.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClearAll.Location = new System.Drawing.Point(878, 10);
            this.btnClearAll.Name = "btnClearAll";
            this.btnClearAll.Size = new System.Drawing.Size(291, 36);
            this.btnClearAll.TabIndex = 3;
            this.btnClearAll.Text = "Очистить всё";
            this.btnClearAll.UseVisualStyleBackColor = false;
            this.btnClearAll.Click += new System.EventHandler(this.btnClearAll_Click);
            // 
            // btnExit
            // 
            this.btnExit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnExit.BackColor = System.Drawing.Color.AliceBlue;
            this.btnExit.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Location = new System.Drawing.Point(878, 53);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(291, 36);
            this.btnExit.TabIndex = 2;
            this.btnExit.Text = "Выйти";
            this.btnExit.UseVisualStyleBackColor = false;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnSaveFile
            // 
            this.btnSaveFile.BackColor = System.Drawing.Color.AliceBlue;
            this.btnSaveFile.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSaveFile.Location = new System.Drawing.Point(11, 54);
            this.btnSaveFile.Name = "btnSaveFile";
            this.btnSaveFile.Size = new System.Drawing.Size(293, 36);
            this.btnSaveFile.TabIndex = 1;
            this.btnSaveFile.Text = "Сохранить результат ";
            this.btnSaveFile.UseVisualStyleBackColor = false;
            this.btnSaveFile.Click += new System.EventHandler(this.btnSaveFile_Click);
            // 
            // btnOpenFile
            // 
            this.btnOpenFile.BackColor = System.Drawing.Color.AliceBlue;
            this.btnOpenFile.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnOpenFile.Location = new System.Drawing.Point(11, 10);
            this.btnOpenFile.Name = "btnOpenFile";
            this.btnOpenFile.Size = new System.Drawing.Size(293, 37);
            this.btnOpenFile.TabIndex = 0;
            this.btnOpenFile.Text = "Открыть исходный файл";
            this.btnOpenFile.UseVisualStyleBackColor = false;
            this.btnOpenFile.Click += new System.EventHandler(this.btnOpenFile_Click);
            // 
            // saveFileDialog
            // 
            this.saveFileDialog.DefaultExt = "enc";
            // 
            // lResultKey
            // 
            this.lResultKey.AutoSize = true;
            this.lResultKey.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lResultKey.Location = new System.Drawing.Point(12, 267);
            this.lResultKey.Name = "lResultKey";
            this.lResultKey.Size = new System.Drawing.Size(234, 20);
            this.lResultKey.TabIndex = 7;
            this.lResultKey.Text = "Сгенерированный ключ:";
            // 
            // tbResultKey
            // 
            this.tbResultKey.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbResultKey.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbResultKey.Location = new System.Drawing.Point(16, 290);
            this.tbResultKey.Name = "tbResultKey";
            this.tbResultKey.ReadOnly = true;
            this.tbResultKey.Size = new System.Drawing.Size(1154, 26);
            this.tbResultKey.TabIndex = 8;
            // 
            // tbSourceData
            // 
            this.tbSourceData.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbSourceData.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbSourceData.Location = new System.Drawing.Point(16, 357);
            this.tbSourceData.Name = "tbSourceData";
            this.tbSourceData.ReadOnly = true;
            this.tbSourceData.Size = new System.Drawing.Size(1154, 26);
            this.tbSourceData.TabIndex = 10;
            this.tbSourceData.KeyDown += new System.Windows.Forms.KeyEventHandler(this.tbKey_KeyDown);
            this.tbSourceData.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tbKey_KeyPress);
            this.tbSourceData.KeyUp += new System.Windows.Forms.KeyEventHandler(this.tbKey_KeyUp);
            // 
            // lSourceData
            // 
            this.lSourceData.AutoSize = true;
            this.lSourceData.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lSourceData.Location = new System.Drawing.Point(12, 334);
            this.lSourceData.Name = "lSourceData";
            this.lSourceData.Size = new System.Drawing.Size(181, 20);
            this.lSourceData.TabIndex = 9;
            this.lSourceData.Text = "Исходные данные:";
            // 
            // tbResultData
            // 
            this.tbResultData.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbResultData.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbResultData.Location = new System.Drawing.Point(16, 426);
            this.tbResultData.Name = "tbResultData";
            this.tbResultData.ReadOnly = true;
            this.tbResultData.Size = new System.Drawing.Size(1154, 26);
            this.tbResultData.TabIndex = 12;
            // 
            // lResultData
            // 
            this.lResultData.AutoSize = true;
            this.lResultData.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lResultData.Location = new System.Drawing.Point(12, 403);
            this.lResultData.Name = "lResultData";
            this.lResultData.Size = new System.Drawing.Size(186, 20);
            this.lResultData.TabIndex = 11;
            this.lResultData.Text = "Результат работы:";
            // 
            // lKey
            // 
            this.lKey.AutoSize = true;
            this.lKey.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lKey.Location = new System.Drawing.Point(12, 196);
            this.lKey.Name = "lKey";
            this.lKey.Size = new System.Drawing.Size(57, 20);
            this.lKey.TabIndex = 13;
            this.lKey.Text = "Ключ";
            // 
            // tbKey
            // 
            this.tbKey.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbKey.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbKey.Location = new System.Drawing.Point(16, 219);
            this.tbKey.Name = "tbKey";
            this.tbKey.Size = new System.Drawing.Size(967, 26);
            this.tbKey.TabIndex = 14;
            this.tbKey.TextChanged += new System.EventHandler(this.tbKey_TextChanged);
            this.tbKey.KeyDown += new System.Windows.Forms.KeyEventHandler(this.tbKey_KeyDown);
            this.tbKey.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tbKey_KeyPress);
            this.tbKey.KeyUp += new System.Windows.Forms.KeyEventHandler(this.tbKey_KeyUp);
            // 
            // lRegisterSizeTitle
            // 
            this.lRegisterSizeTitle.AutoSize = true;
            this.lRegisterSizeTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lRegisterSizeTitle.Location = new System.Drawing.Point(12, 133);
            this.lRegisterSizeTitle.Name = "lRegisterSizeTitle";
            this.lRegisterSizeTitle.Size = new System.Drawing.Size(174, 20);
            this.lRegisterSizeTitle.TabIndex = 15;
            this.lRegisterSizeTitle.Text = "Размер регистра:";
            // 
            // lPolynomTitle
            // 
            this.lPolynomTitle.AutoSize = true;
            this.lPolynomTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lPolynomTitle.Location = new System.Drawing.Point(12, 160);
            this.lPolynomTitle.Name = "lPolynomTitle";
            this.lPolynomTitle.Size = new System.Drawing.Size(248, 20);
            this.lPolynomTitle.TabIndex = 16;
            this.lPolynomTitle.Text = "Примитивный многочлен:";
            // 
            // lRegisterSize
            // 
            this.lRegisterSize.AutoSize = true;
            this.lRegisterSize.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lRegisterSize.Location = new System.Drawing.Point(291, 133);
            this.lRegisterSize.Name = "lRegisterSize";
            this.lRegisterSize.Size = new System.Drawing.Size(70, 20);
            this.lRegisterSize.TabIndex = 17;
            this.lRegisterSize.Text = "размер";
            // 
            // lPolynom
            // 
            this.lPolynom.AutoSize = true;
            this.lPolynom.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lPolynom.Location = new System.Drawing.Point(291, 160);
            this.lPolynom.Name = "lPolynom";
            this.lPolynom.Size = new System.Drawing.Size(99, 20);
            this.lPolynom.TabIndex = 18;
            this.lPolynom.Text = "многочлен";
            // 
            // btnClearKey
            // 
            this.btnClearKey.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnClearKey.BackColor = System.Drawing.Color.AliceBlue;
            this.btnClearKey.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClearKey.Location = new System.Drawing.Point(989, 219);
            this.btnClearKey.Name = "btnClearKey";
            this.btnClearKey.Size = new System.Drawing.Size(181, 30);
            this.btnClearKey.TabIndex = 19;
            this.btnClearKey.Text = "Очистить";
            this.btnClearKey.UseVisualStyleBackColor = false;
            this.btnClearKey.Click += new System.EventHandler(this.btnClearKey_Click);
            // 
            // fMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ClientSize = new System.Drawing.Size(1182, 653);
            this.Controls.Add(this.btnClearKey);
            this.Controls.Add(this.lPolynom);
            this.Controls.Add(this.lRegisterSize);
            this.Controls.Add(this.lPolynomTitle);
            this.Controls.Add(this.lRegisterSizeTitle);
            this.Controls.Add(this.tbKey);
            this.Controls.Add(this.lKey);
            this.Controls.Add(this.tbResultData);
            this.Controls.Add(this.lResultData);
            this.Controls.Add(this.tbSourceData);
            this.Controls.Add(this.lSourceData);
            this.Controls.Add(this.tbResultKey);
            this.Controls.Add(this.lResultKey);
            this.Controls.Add(this.pSide);
            this.HelpButton = true;
            this.MinimumSize = new System.Drawing.Size(1200, 700);
            this.Name = "fMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Лабораторная работа №2, 351004, Наривончик Александр, вариант 18";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.pSide.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel pSide;
        private System.Windows.Forms.Button btnOpenFile;
        private System.Windows.Forms.Button btnEncryption;
        private System.Windows.Forms.Button btnClearAll;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnSaveFile;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.SaveFileDialog saveFileDialog;
        private System.Windows.Forms.Label lResultKey;
        private System.Windows.Forms.TextBox tbResultKey;
        private System.Windows.Forms.TextBox tbSourceData;
        private System.Windows.Forms.Label lSourceData;
        private System.Windows.Forms.TextBox tbResultData;
        private System.Windows.Forms.Label lResultData;
        private System.Windows.Forms.Label lKey;
        private System.Windows.Forms.TextBox tbKey;
        private System.Windows.Forms.Label lRegisterSizeTitle;
        private System.Windows.Forms.Label lPolynomTitle;
        private System.Windows.Forms.Label lRegisterSize;
        private System.Windows.Forms.Label lPolynom;
        private System.Windows.Forms.Button btnClearKey;
    }
}

