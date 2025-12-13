namespace theory_information_lab4
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
            this.lOpenDegreeValue = new System.Windows.Forms.Label();
            this.lOpenDegree = new System.Windows.Forms.Label();
            this.lPhiValue = new System.Windows.Forms.Label();
            this.lRValue = new System.Windows.Forms.Label();
            this.cbD = new System.Windows.Forms.ComboBox();
            this.cbE = new System.Windows.Forms.ComboBox();
            this.lE = new System.Windows.Forms.Label();
            this.lR = new System.Windows.Forms.Label();
            this.lPhi = new System.Windows.Forms.Label();
            this.btnAccept = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.btnSaveFile = new System.Windows.Forms.Button();
            this.btnOpenFile = new System.Windows.Forms.Button();
            this.btnSignature = new System.Windows.Forms.Button();
            this.btnCheckSignature = new System.Windows.Forms.Button();
            this.lD = new System.Windows.Forms.Label();
            this.lQ = new System.Windows.Forms.Label();
            this.tbQ = new System.Windows.Forms.TextBox();
            this.lP = new System.Windows.Forms.Label();
            this.tbP = new System.Windows.Forms.TextBox();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.tbData = new System.Windows.Forms.TextBox();
            this.lHashValue = new System.Windows.Forms.Label();
            this.lHash = new System.Windows.Forms.Label();
            this.btnClear = new System.Windows.Forms.Button();
            this.pSide.SuspendLayout();
            this.SuspendLayout();
            // 
            // pSide
            // 
            this.pSide.BackColor = System.Drawing.Color.MediumOrchid;
            this.pSide.Controls.Add(this.btnClear);
            this.pSide.Controls.Add(this.lHashValue);
            this.pSide.Controls.Add(this.lHash);
            this.pSide.Controls.Add(this.lOpenDegreeValue);
            this.pSide.Controls.Add(this.lOpenDegree);
            this.pSide.Controls.Add(this.lPhiValue);
            this.pSide.Controls.Add(this.lRValue);
            this.pSide.Controls.Add(this.cbD);
            this.pSide.Controls.Add(this.cbE);
            this.pSide.Controls.Add(this.lE);
            this.pSide.Controls.Add(this.lR);
            this.pSide.Controls.Add(this.lPhi);
            this.pSide.Controls.Add(this.btnAccept);
            this.pSide.Controls.Add(this.btnExit);
            this.pSide.Controls.Add(this.btnSaveFile);
            this.pSide.Controls.Add(this.btnOpenFile);
            this.pSide.Controls.Add(this.btnSignature);
            this.pSide.Controls.Add(this.btnCheckSignature);
            this.pSide.Controls.Add(this.lD);
            this.pSide.Controls.Add(this.lQ);
            this.pSide.Controls.Add(this.tbQ);
            this.pSide.Controls.Add(this.lP);
            this.pSide.Controls.Add(this.tbP);
            this.pSide.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSide.Location = new System.Drawing.Point(0, 0);
            this.pSide.Name = "pSide";
            this.pSide.Size = new System.Drawing.Size(377, 703);
            this.pSide.TabIndex = 0;
            // 
            // lOpenDegreeValue
            // 
            this.lOpenDegreeValue.AutoSize = true;
            this.lOpenDegreeValue.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lOpenDegreeValue.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lOpenDegreeValue.Location = new System.Drawing.Point(192, 238);
            this.lOpenDegreeValue.Name = "lOpenDegreeValue";
            this.lOpenDegreeValue.Size = new System.Drawing.Size(27, 28);
            this.lOpenDegreeValue.TabIndex = 21;
            this.lOpenDegreeValue.Text = "...";
            // 
            // lOpenDegree
            // 
            this.lOpenDegree.AutoSize = true;
            this.lOpenDegree.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lOpenDegree.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lOpenDegree.Location = new System.Drawing.Point(158, 238);
            this.lOpenDegree.Name = "lOpenDegree";
            this.lOpenDegree.Size = new System.Drawing.Size(28, 28);
            this.lOpenDegree.TabIndex = 20;
            this.lOpenDegree.Text = "E:";
            // 
            // lPhiValue
            // 
            this.lPhiValue.AutoSize = true;
            this.lPhiValue.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lPhiValue.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lPhiValue.Location = new System.Drawing.Point(65, 205);
            this.lPhiValue.Name = "lPhiValue";
            this.lPhiValue.Size = new System.Drawing.Size(27, 28);
            this.lPhiValue.TabIndex = 19;
            this.lPhiValue.Text = "...";
            // 
            // lRValue
            // 
            this.lRValue.AutoSize = true;
            this.lRValue.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lRValue.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lRValue.Location = new System.Drawing.Point(66, 181);
            this.lRValue.Name = "lRValue";
            this.lRValue.Size = new System.Drawing.Size(27, 28);
            this.lRValue.TabIndex = 18;
            this.lRValue.Text = "...";
            // 
            // cbD
            // 
            this.cbD.Cursor = System.Windows.Forms.Cursors.Hand;
            this.cbD.Enabled = false;
            this.cbD.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbD.FormattingEnabled = true;
            this.cbD.Location = new System.Drawing.Point(10, 269);
            this.cbD.Name = "cbD";
            this.cbD.Size = new System.Drawing.Size(349, 36);
            this.cbD.TabIndex = 17;
            // 
            // cbE
            // 
            this.cbE.Cursor = System.Windows.Forms.Cursors.Hand;
            this.cbE.Enabled = false;
            this.cbE.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbE.FormattingEnabled = true;
            this.cbE.Location = new System.Drawing.Point(12, 380);
            this.cbE.Name = "cbE";
            this.cbE.Size = new System.Drawing.Size(349, 36);
            this.cbE.TabIndex = 16;
            // 
            // lE
            // 
            this.lE.AutoSize = true;
            this.lE.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lE.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lE.Location = new System.Drawing.Point(7, 349);
            this.lE.Name = "lE";
            this.lE.Size = new System.Drawing.Size(115, 28);
            this.lE.TabIndex = 15;
            this.lE.Text = "Введите E:";
            // 
            // lR
            // 
            this.lR.AutoSize = true;
            this.lR.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lR.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lR.Location = new System.Drawing.Point(9, 181);
            this.lR.Name = "lR";
            this.lR.Size = new System.Drawing.Size(30, 28);
            this.lR.TabIndex = 13;
            this.lR.Text = "R:";
            // 
            // lPhi
            // 
            this.lPhi.AutoSize = true;
            this.lPhi.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lPhi.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lPhi.Location = new System.Drawing.Point(7, 205);
            this.lPhi.Name = "lPhi";
            this.lPhi.Size = new System.Drawing.Size(56, 28);
            this.lPhi.TabIndex = 12;
            this.lPhi.Text = "Ф(r):";
            // 
            // btnAccept
            // 
            this.btnAccept.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnAccept.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnAccept.Location = new System.Drawing.Point(12, 144);
            this.btnAccept.Name = "btnAccept";
            this.btnAccept.Size = new System.Drawing.Size(349, 37);
            this.btnAccept.TabIndex = 11;
            this.btnAccept.Text = "Подтвердить";
            this.btnAccept.UseVisualStyleBackColor = true;
            this.btnAccept.Click += new System.EventHandler(this.btnAccept_Click);
            // 
            // btnExit
            // 
            this.btnExit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnExit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnExit.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Location = new System.Drawing.Point(12, 654);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(349, 37);
            this.btnExit.TabIndex = 10;
            this.btnExit.Text = "Выход";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnSaveFile
            // 
            this.btnSaveFile.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnSaveFile.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSaveFile.Location = new System.Drawing.Point(12, 540);
            this.btnSaveFile.Name = "btnSaveFile";
            this.btnSaveFile.Size = new System.Drawing.Size(349, 37);
            this.btnSaveFile.TabIndex = 9;
            this.btnSaveFile.Text = "Сохранить файл";
            this.btnSaveFile.UseVisualStyleBackColor = true;
            this.btnSaveFile.Click += new System.EventHandler(this.btnSaveFile_Click);
            // 
            // btnOpenFile
            // 
            this.btnOpenFile.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnOpenFile.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnOpenFile.Location = new System.Drawing.Point(12, 500);
            this.btnOpenFile.Name = "btnOpenFile";
            this.btnOpenFile.Size = new System.Drawing.Size(349, 37);
            this.btnOpenFile.TabIndex = 8;
            this.btnOpenFile.Text = "Открыть файл";
            this.btnOpenFile.UseVisualStyleBackColor = true;
            this.btnOpenFile.Click += new System.EventHandler(this.btnOpenFile_Click);
            // 
            // btnSignature
            // 
            this.btnSignature.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnSignature.Enabled = false;
            this.btnSignature.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSignature.Location = new System.Drawing.Point(10, 310);
            this.btnSignature.Name = "btnSignature";
            this.btnSignature.Size = new System.Drawing.Size(349, 37);
            this.btnSignature.TabIndex = 7;
            this.btnSignature.Text = "Подписать";
            this.btnSignature.UseVisualStyleBackColor = true;
            this.btnSignature.Click += new System.EventHandler(this.btnSignature_Click);
            // 
            // btnCheckSignature
            // 
            this.btnCheckSignature.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnCheckSignature.Enabled = false;
            this.btnCheckSignature.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCheckSignature.Location = new System.Drawing.Point(12, 421);
            this.btnCheckSignature.Name = "btnCheckSignature";
            this.btnCheckSignature.Size = new System.Drawing.Size(349, 37);
            this.btnCheckSignature.TabIndex = 6;
            this.btnCheckSignature.Text = "Проверить подпись";
            this.btnCheckSignature.UseVisualStyleBackColor = true;
            this.btnCheckSignature.Click += new System.EventHandler(this.btnCheckSignature_Click);
            // 
            // lD
            // 
            this.lD.AutoSize = true;
            this.lD.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lD.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lD.Location = new System.Drawing.Point(4, 238);
            this.lD.Name = "lD";
            this.lD.Size = new System.Drawing.Size(119, 28);
            this.lD.TabIndex = 5;
            this.lD.Text = "Введите D:";
            // 
            // lQ
            // 
            this.lQ.AutoSize = true;
            this.lQ.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lQ.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lQ.Location = new System.Drawing.Point(7, 72);
            this.lQ.Name = "lQ";
            this.lQ.Size = new System.Drawing.Size(119, 28);
            this.lQ.TabIndex = 3;
            this.lQ.Text = "Введите Q:";
            // 
            // tbQ
            // 
            this.tbQ.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.tbQ.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbQ.Location = new System.Drawing.Point(12, 104);
            this.tbQ.Name = "tbQ";
            this.tbQ.Size = new System.Drawing.Size(349, 34);
            this.tbQ.TabIndex = 2;
            // 
            // lP
            // 
            this.lP.AutoSize = true;
            this.lP.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lP.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lP.Location = new System.Drawing.Point(7, 9);
            this.lP.Name = "lP";
            this.lP.Size = new System.Drawing.Size(116, 28);
            this.lP.TabIndex = 1;
            this.lP.Text = "Введите P:";
            // 
            // tbP
            // 
            this.tbP.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.tbP.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbP.Location = new System.Drawing.Point(12, 36);
            this.tbP.Name = "tbP";
            this.tbP.Size = new System.Drawing.Size(349, 34);
            this.tbP.TabIndex = 0;
            // 
            // openFileDialog
            // 
            this.openFileDialog.DefaultExt = "txt";
            this.openFileDialog.FileName = "test";
            this.openFileDialog.Filter = "Текстовые файлы |*.txt";
            // 
            // saveFileDialog
            // 
            this.saveFileDialog.DefaultExt = "txt";
            this.saveFileDialog.FileName = "test";
            this.saveFileDialog.Filter = "Текстовые файлы |*.txt";
            // 
            // tbData
            // 
            this.tbData.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.tbData.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tbData.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbData.Location = new System.Drawing.Point(377, 0);
            this.tbData.Multiline = true;
            this.tbData.Name = "tbData";
            this.tbData.ReadOnly = true;
            this.tbData.Size = new System.Drawing.Size(693, 703);
            this.tbData.TabIndex = 1;
            // 
            // lHashValue
            // 
            this.lHashValue.AutoSize = true;
            this.lHashValue.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lHashValue.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lHashValue.Location = new System.Drawing.Point(214, 461);
            this.lHashValue.Name = "lHashValue";
            this.lHashValue.Size = new System.Drawing.Size(27, 28);
            this.lHashValue.TabIndex = 23;
            this.lHashValue.Text = "...";
            // 
            // lHash
            // 
            this.lHash.AutoSize = true;
            this.lHash.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lHash.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.lHash.Location = new System.Drawing.Point(7, 461);
            this.lHash.Name = "lHash";
            this.lHash.Size = new System.Drawing.Size(201, 28);
            this.lHash.TabIndex = 22;
            this.lHash.Text = "Вычисленный хэш:";
            // 
            // btnClear
            // 
            this.btnClear.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnClear.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClear.Location = new System.Drawing.Point(14, 611);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(349, 37);
            this.btnClear.TabIndex = 24;
            this.btnClear.Text = "Очистить";
            this.btnClear.UseVisualStyleBackColor = true;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // fMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1070, 703);
            this.Controls.Add(this.tbData);
            this.Controls.Add(this.pSide);
            this.Name = "fMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Лабораторная работа 4, 351004, Наривончик Александр";
            this.pSide.ResumeLayout(false);
            this.pSide.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel pSide;
        private System.Windows.Forms.Label lD;
        private System.Windows.Forms.Label lQ;
        private System.Windows.Forms.TextBox tbQ;
        private System.Windows.Forms.Label lP;
        private System.Windows.Forms.TextBox tbP;
        private System.Windows.Forms.Button btnSignature;
        private System.Windows.Forms.Button btnCheckSignature;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnSaveFile;
        private System.Windows.Forms.Button btnOpenFile;
        private System.Windows.Forms.Label lR;
        private System.Windows.Forms.Label lPhi;
        private System.Windows.Forms.Button btnAccept;
        private System.Windows.Forms.Label lPhiValue;
        private System.Windows.Forms.Label lRValue;
        private System.Windows.Forms.ComboBox cbD;
        private System.Windows.Forms.ComboBox cbE;
        private System.Windows.Forms.Label lE;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.SaveFileDialog saveFileDialog;
        private System.Windows.Forms.TextBox tbData;
        private System.Windows.Forms.Label lOpenDegreeValue;
        private System.Windows.Forms.Label lOpenDegree;
        private System.Windows.Forms.Label lHashValue;
        private System.Windows.Forms.Label lHash;
        private System.Windows.Forms.Button btnClear;
    }
}

