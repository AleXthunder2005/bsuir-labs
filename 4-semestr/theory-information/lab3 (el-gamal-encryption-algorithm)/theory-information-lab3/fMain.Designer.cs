namespace theory_information_lab3
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
            this.lDecryptionTitle = new System.Windows.Forms.Label();
            this.lEncryptionTitle = new System.Windows.Forms.Label();
            this.btnOpenEncryptedFile = new System.Windows.Forms.Button();
            this.cbK = new System.Windows.Forms.ComboBox();
            this.lEilerValue = new System.Windows.Forms.Label();
            this.lEilerTitle = new System.Windows.Forms.Label();
            this.btnSaveFile = new System.Windows.Forms.Button();
            this.btnOpenSourceFile = new System.Windows.Forms.Button();
            this.btnDecryption = new System.Windows.Forms.Button();
            this.lYValue = new System.Windows.Forms.Label();
            this.lYTitle = new System.Windows.Forms.Label();
            this.btnEncryption = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.lKTitle = new System.Windows.Forms.Label();
            this.lXTitle = new System.Windows.Forms.Label();
            this.tbX = new System.Windows.Forms.TextBox();
            this.lGTitle = new System.Windows.Forms.Label();
            this.cbG = new System.Windows.Forms.ComboBox();
            this.btnAcceptP = new System.Windows.Forms.Button();
            this.lPTitle = new System.Windows.Forms.Label();
            this.tbP = new System.Windows.Forms.TextBox();
            this.tbOpenedFile = new System.Windows.Forms.TextBox();
            this.lOpenedFile = new System.Windows.Forms.Label();
            this.tbResult = new System.Windows.Forms.TextBox();
            this.lResult = new System.Windows.Forms.Label();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.pSide.SuspendLayout();
            this.SuspendLayout();
            // 
            // pSide
            // 
            this.pSide.BackColor = System.Drawing.Color.WhiteSmoke;
            this.pSide.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pSide.Controls.Add(this.lDecryptionTitle);
            this.pSide.Controls.Add(this.lEncryptionTitle);
            this.pSide.Controls.Add(this.btnOpenEncryptedFile);
            this.pSide.Controls.Add(this.cbK);
            this.pSide.Controls.Add(this.lEilerValue);
            this.pSide.Controls.Add(this.lEilerTitle);
            this.pSide.Controls.Add(this.btnSaveFile);
            this.pSide.Controls.Add(this.btnOpenSourceFile);
            this.pSide.Controls.Add(this.btnDecryption);
            this.pSide.Controls.Add(this.lYValue);
            this.pSide.Controls.Add(this.lYTitle);
            this.pSide.Controls.Add(this.btnEncryption);
            this.pSide.Controls.Add(this.btnExit);
            this.pSide.Controls.Add(this.lKTitle);
            this.pSide.Controls.Add(this.lXTitle);
            this.pSide.Controls.Add(this.tbX);
            this.pSide.Controls.Add(this.lGTitle);
            this.pSide.Controls.Add(this.cbG);
            this.pSide.Controls.Add(this.btnAcceptP);
            this.pSide.Controls.Add(this.lPTitle);
            this.pSide.Controls.Add(this.tbP);
            this.pSide.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSide.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pSide.Location = new System.Drawing.Point(0, 0);
            this.pSide.Name = "pSide";
            this.pSide.Size = new System.Drawing.Size(407, 802);
            this.pSide.TabIndex = 0;
            // 
            // lDecryptionTitle
            // 
            this.lDecryptionTitle.AutoSize = true;
            this.lDecryptionTitle.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lDecryptionTitle.Location = new System.Drawing.Point(114, 531);
            this.lDecryptionTitle.Name = "lDecryptionTitle";
            this.lDecryptionTitle.Size = new System.Drawing.Size(168, 28);
            this.lDecryptionTitle.TabIndex = 21;
            this.lDecryptionTitle.Text = "Дешифрование";
            // 
            // lEncryptionTitle
            // 
            this.lEncryptionTitle.AutoSize = true;
            this.lEncryptionTitle.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lEncryptionTitle.Location = new System.Drawing.Point(126, 413);
            this.lEncryptionTitle.Name = "lEncryptionTitle";
            this.lEncryptionTitle.Size = new System.Drawing.Size(144, 28);
            this.lEncryptionTitle.TabIndex = 20;
            this.lEncryptionTitle.Text = "Шифрование";
            // 
            // btnOpenEncryptedFile
            // 
            this.btnOpenEncryptedFile.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnOpenEncryptedFile.Location = new System.Drawing.Point(10, 562);
            this.btnOpenEncryptedFile.Name = "btnOpenEncryptedFile";
            this.btnOpenEncryptedFile.Size = new System.Drawing.Size(382, 36);
            this.btnOpenEncryptedFile.TabIndex = 18;
            this.btnOpenEncryptedFile.Text = "Открыть зашифрованный файл";
            this.btnOpenEncryptedFile.UseVisualStyleBackColor = true;
            this.btnOpenEncryptedFile.Click += new System.EventHandler(this.btnOpenEncryptedFile_Click);
            // 
            // cbK
            // 
            this.cbK.Enabled = false;
            this.cbK.FormattingEnabled = true;
            this.cbK.Location = new System.Drawing.Point(12, 318);
            this.cbK.Name = "cbK";
            this.cbK.Size = new System.Drawing.Size(381, 36);
            this.cbK.TabIndex = 17;
            // 
            // lEilerValue
            // 
            this.lEilerValue.AutoSize = true;
            this.lEilerValue.Location = new System.Drawing.Point(264, 379);
            this.lEilerValue.Name = "lEilerValue";
            this.lEilerValue.Size = new System.Drawing.Size(28, 28);
            this.lEilerValue.TabIndex = 16;
            this.lEilerValue.Text = "\"\"";
            // 
            // lEilerTitle
            // 
            this.lEilerTitle.AutoSize = true;
            this.lEilerTitle.Location = new System.Drawing.Point(11, 379);
            this.lEilerTitle.Name = "lEilerTitle";
            this.lEilerTitle.Size = new System.Drawing.Size(166, 28);
            this.lEilerTitle.TabIndex = 15;
            this.lEilerTitle.Text = "Функция эйлера:";
            // 
            // btnSaveFile
            // 
            this.btnSaveFile.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnSaveFile.Location = new System.Drawing.Point(11, 677);
            this.btnSaveFile.Name = "btnSaveFile";
            this.btnSaveFile.Size = new System.Drawing.Size(382, 36);
            this.btnSaveFile.TabIndex = 14;
            this.btnSaveFile.Text = "Сохранить файл";
            this.btnSaveFile.UseVisualStyleBackColor = true;
            this.btnSaveFile.Click += new System.EventHandler(this.btnSaveFile_Click);
            // 
            // btnOpenSourceFile
            // 
            this.btnOpenSourceFile.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnOpenSourceFile.Location = new System.Drawing.Point(9, 445);
            this.btnOpenSourceFile.Name = "btnOpenSourceFile";
            this.btnOpenSourceFile.Size = new System.Drawing.Size(382, 36);
            this.btnOpenSourceFile.TabIndex = 13;
            this.btnOpenSourceFile.Text = "Открыть исходный файл";
            this.btnOpenSourceFile.UseVisualStyleBackColor = true;
            this.btnOpenSourceFile.Click += new System.EventHandler(this.btnOpenSourceFile_Click);
            // 
            // btnDecryption
            // 
            this.btnDecryption.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnDecryption.Enabled = false;
            this.btnDecryption.Location = new System.Drawing.Point(11, 604);
            this.btnDecryption.Name = "btnDecryption";
            this.btnDecryption.Size = new System.Drawing.Size(382, 36);
            this.btnDecryption.TabIndex = 12;
            this.btnDecryption.Text = "Дешифровать";
            this.btnDecryption.UseVisualStyleBackColor = true;
            this.btnDecryption.Click += new System.EventHandler(this.btnDecryption_Click);
            // 
            // lYValue
            // 
            this.lYValue.AutoSize = true;
            this.lYValue.Location = new System.Drawing.Point(264, 351);
            this.lYValue.Name = "lYValue";
            this.lYValue.Size = new System.Drawing.Size(28, 28);
            this.lYValue.TabIndex = 11;
            this.lYValue.Text = "\"\"";
            // 
            // lYTitle
            // 
            this.lYTitle.AutoSize = true;
            this.lYTitle.Location = new System.Drawing.Point(11, 351);
            this.lYTitle.Name = "lYTitle";
            this.lYTitle.Size = new System.Drawing.Size(247, 28);
            this.lYTitle.TabIndex = 10;
            this.lYTitle.Text = "Вычисленное значение Y:";
            // 
            // btnEncryption
            // 
            this.btnEncryption.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnEncryption.Enabled = false;
            this.btnEncryption.Location = new System.Drawing.Point(10, 487);
            this.btnEncryption.Name = "btnEncryption";
            this.btnEncryption.Size = new System.Drawing.Size(382, 36);
            this.btnEncryption.TabIndex = 9;
            this.btnEncryption.Text = "Зашифровать";
            this.btnEncryption.UseVisualStyleBackColor = true;
            this.btnEncryption.Click += new System.EventHandler(this.btnEncryption_Click);
            // 
            // btnExit
            // 
            this.btnExit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnExit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnExit.Location = new System.Drawing.Point(10, 753);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(382, 36);
            this.btnExit.TabIndex = 8;
            this.btnExit.Text = "Выход";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // lKTitle
            // 
            this.lKTitle.AutoSize = true;
            this.lKTitle.Location = new System.Drawing.Point(7, 283);
            this.lKTitle.Name = "lKTitle";
            this.lKTitle.Size = new System.Drawing.Size(147, 28);
            this.lKTitle.TabIndex = 7;
            this.lKTitle.Text = "Компонента K:";
            // 
            // lXTitle
            // 
            this.lXTitle.AutoSize = true;
            this.lXTitle.Location = new System.Drawing.Point(6, 215);
            this.lXTitle.Name = "lXTitle";
            this.lXTitle.Size = new System.Drawing.Size(147, 28);
            this.lXTitle.TabIndex = 5;
            this.lXTitle.Text = "Компонента X:";
            // 
            // tbX
            // 
            this.tbX.Enabled = false;
            this.tbX.Location = new System.Drawing.Point(11, 246);
            this.tbX.Name = "tbX";
            this.tbX.Size = new System.Drawing.Size(382, 34);
            this.tbX.TabIndex = 4;
            // 
            // lGTitle
            // 
            this.lGTitle.AutoSize = true;
            this.lGTitle.Location = new System.Drawing.Point(6, 143);
            this.lGTitle.Name = "lGTitle";
            this.lGTitle.Size = new System.Drawing.Size(149, 28);
            this.lGTitle.TabIndex = 3;
            this.lGTitle.Text = "Компонента G:";
            // 
            // cbG
            // 
            this.cbG.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbG.Enabled = false;
            this.cbG.FormattingEnabled = true;
            this.cbG.Location = new System.Drawing.Point(11, 174);
            this.cbG.Name = "cbG";
            this.cbG.Size = new System.Drawing.Size(381, 36);
            this.cbG.TabIndex = 2;
            // 
            // btnAcceptP
            // 
            this.btnAcceptP.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnAcceptP.Location = new System.Drawing.Point(11, 86);
            this.btnAcceptP.Name = "btnAcceptP";
            this.btnAcceptP.Size = new System.Drawing.Size(382, 36);
            this.btnAcceptP.TabIndex = 1;
            this.btnAcceptP.Text = "Подтвердить";
            this.btnAcceptP.UseVisualStyleBackColor = true;
            this.btnAcceptP.Click += new System.EventHandler(this.btnAcceptP_Click);
            // 
            // lPTitle
            // 
            this.lPTitle.AutoSize = true;
            this.lPTitle.Location = new System.Drawing.Point(6, 15);
            this.lPTitle.Name = "lPTitle";
            this.lPTitle.Size = new System.Drawing.Size(146, 28);
            this.lPTitle.TabIndex = 1;
            this.lPTitle.Text = "Компонента P:";
            // 
            // tbP
            // 
            this.tbP.Location = new System.Drawing.Point(11, 46);
            this.tbP.Name = "tbP";
            this.tbP.Size = new System.Drawing.Size(382, 34);
            this.tbP.TabIndex = 0;
            // 
            // tbOpenedFile
            // 
            this.tbOpenedFile.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbOpenedFile.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbOpenedFile.Location = new System.Drawing.Point(413, 30);
            this.tbOpenedFile.Multiline = true;
            this.tbOpenedFile.Name = "tbOpenedFile";
            this.tbOpenedFile.ReadOnly = true;
            this.tbOpenedFile.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.tbOpenedFile.Size = new System.Drawing.Size(944, 350);
            this.tbOpenedFile.TabIndex = 1;
            // 
            // lOpenedFile
            // 
            this.lOpenedFile.AutoSize = true;
            this.lOpenedFile.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lOpenedFile.ForeColor = System.Drawing.SystemColors.Control;
            this.lOpenedFile.Location = new System.Drawing.Point(413, -1);
            this.lOpenedFile.Name = "lOpenedFile";
            this.lOpenedFile.Size = new System.Drawing.Size(321, 28);
            this.lOpenedFile.TabIndex = 16;
            this.lOpenedFile.Text = "Содержимое открытого файла:";
            // 
            // tbResult
            // 
            this.tbResult.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbResult.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbResult.Location = new System.Drawing.Point(413, 411);
            this.tbResult.Multiline = true;
            this.tbResult.Name = "tbResult";
            this.tbResult.ReadOnly = true;
            this.tbResult.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.tbResult.Size = new System.Drawing.Size(944, 379);
            this.tbResult.TabIndex = 17;
            // 
            // lResult
            // 
            this.lResult.AutoSize = true;
            this.lResult.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lResult.ForeColor = System.Drawing.SystemColors.Control;
            this.lResult.Location = new System.Drawing.Point(413, 380);
            this.lResult.Name = "lResult";
            this.lResult.Size = new System.Drawing.Size(110, 28);
            this.lResult.TabIndex = 18;
            this.lResult.Text = "Результат:";
            // 
            // openFileDialog
            // 
            this.openFileDialog.FileName = "save";
            // 
            // saveFileDialog
            // 
            this.saveFileDialog.FileName = "save";
            // 
            // fMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.ClientSize = new System.Drawing.Size(1369, 802);
            this.Controls.Add(this.lResult);
            this.Controls.Add(this.tbResult);
            this.Controls.Add(this.lOpenedFile);
            this.Controls.Add(this.tbOpenedFile);
            this.Controls.Add(this.pSide);
            this.Cursor = System.Windows.Forms.Cursors.Hand;
            this.Name = "fMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Лабораторная работа 3 (вариант 2), 351004, Наривончик Александр";
            this.pSide.ResumeLayout(false);
            this.pSide.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel pSide;
        private System.Windows.Forms.Button btnAcceptP;
        private System.Windows.Forms.Label lPTitle;
        private System.Windows.Forms.TextBox tbP;
        private System.Windows.Forms.Label lKTitle;
        private System.Windows.Forms.Label lXTitle;
        private System.Windows.Forms.TextBox tbX;
        private System.Windows.Forms.Label lGTitle;
        private System.Windows.Forms.ComboBox cbG;
        private System.Windows.Forms.Button btnEncryption;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Label lYTitle;
        private System.Windows.Forms.Label lYValue;
        private System.Windows.Forms.Button btnDecryption;
        private System.Windows.Forms.Button btnSaveFile;
        private System.Windows.Forms.Button btnOpenSourceFile;
        private System.Windows.Forms.Label lEilerValue;
        private System.Windows.Forms.Label lEilerTitle;
        private System.Windows.Forms.TextBox tbOpenedFile;
        private System.Windows.Forms.Label lOpenedFile;
        private System.Windows.Forms.TextBox tbResult;
        private System.Windows.Forms.Label lResult;
        private System.Windows.Forms.ComboBox cbK;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.SaveFileDialog saveFileDialog;
        private System.Windows.Forms.Label lDecryptionTitle;
        private System.Windows.Forms.Label lEncryptionTitle;
        private System.Windows.Forms.Button btnOpenEncryptedFile;
    }
}

