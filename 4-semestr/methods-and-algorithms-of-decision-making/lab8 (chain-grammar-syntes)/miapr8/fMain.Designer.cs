namespace miapr8
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
            this.pDown = new System.Windows.Forms.Panel();
            this.btnExit = new System.Windows.Forms.Button();
            this.btnGenerate = new System.Windows.Forms.Button();
            this.btnTrain = new System.Windows.Forms.Button();
            this.pUp = new System.Windows.Forms.Panel();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.lTrainingLines = new System.Windows.Forms.Label();
            this.tbTrainingLines = new System.Windows.Forms.TextBox();
            this.pLeftSeparator = new System.Windows.Forms.Panel();
            this.tbGrammarLines = new System.Windows.Forms.TextBox();
            this.pRightSeparator = new System.Windows.Forms.Panel();
            this.tbGeneratedLines = new System.Windows.Forms.TextBox();
            this.pDown.SuspendLayout();
            this.pUp.SuspendLayout();
            this.SuspendLayout();
            // 
            // pDown
            // 
            this.pDown.BackColor = System.Drawing.Color.LightCoral;
            this.pDown.Controls.Add(this.btnExit);
            this.pDown.Controls.Add(this.btnGenerate);
            this.pDown.Controls.Add(this.btnTrain);
            this.pDown.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.pDown.Location = new System.Drawing.Point(0, 566);
            this.pDown.Name = "pDown";
            this.pDown.Size = new System.Drawing.Size(1394, 70);
            this.pDown.TabIndex = 0;
            // 
            // btnExit
            // 
            this.btnExit.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Location = new System.Drawing.Point(999, 20);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(359, 38);
            this.btnExit.TabIndex = 5;
            this.btnExit.Text = "Выход";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnGenerate
            // 
            this.btnGenerate.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnGenerate.Location = new System.Drawing.Point(534, 20);
            this.btnGenerate.Name = "btnGenerate";
            this.btnGenerate.Size = new System.Drawing.Size(359, 38);
            this.btnGenerate.TabIndex = 4;
            this.btnGenerate.Text = "Сгенерировать строку";
            this.btnGenerate.UseVisualStyleBackColor = true;
            this.btnGenerate.Click += new System.EventHandler(this.btnGenerate_Click);
            // 
            // btnTrain
            // 
            this.btnTrain.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnTrain.Location = new System.Drawing.Point(38, 20);
            this.btnTrain.Name = "btnTrain";
            this.btnTrain.Size = new System.Drawing.Size(359, 38);
            this.btnTrain.TabIndex = 3;
            this.btnTrain.Text = "Начать обучение";
            this.btnTrain.UseVisualStyleBackColor = true;
            this.btnTrain.Click += new System.EventHandler(this.btnTrain_Click);
            // 
            // pUp
            // 
            this.pUp.BackColor = System.Drawing.Color.LightCoral;
            this.pUp.Controls.Add(this.label2);
            this.pUp.Controls.Add(this.label1);
            this.pUp.Controls.Add(this.lTrainingLines);
            this.pUp.Dock = System.Windows.Forms.DockStyle.Top;
            this.pUp.Location = new System.Drawing.Point(0, 0);
            this.pUp.Name = "pUp";
            this.pUp.Size = new System.Drawing.Size(1394, 67);
            this.pUp.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(1060, 23);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(262, 28);
            this.label2.TabIndex = 2;
            this.label2.Text = "Сгенерированные строки";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(634, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(133, 28);
            this.label1.TabIndex = 1;
            this.label1.Text = "Грамматики";
            // 
            // lTrainingLines
            // 
            this.lTrainingLines.AutoSize = true;
            this.lTrainingLines.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lTrainingLines.Location = new System.Drawing.Point(103, 23);
            this.lTrainingLines.Name = "lTrainingLines";
            this.lTrainingLines.Size = new System.Drawing.Size(222, 28);
            this.lTrainingLines.TabIndex = 0;
            this.lTrainingLines.Text = "Строки для обучения";
            // 
            // tbTrainingLines
            // 
            this.tbTrainingLines.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tbTrainingLines.Cursor = System.Windows.Forms.Cursors.Hand;
            this.tbTrainingLines.Dock = System.Windows.Forms.DockStyle.Left;
            this.tbTrainingLines.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbTrainingLines.Location = new System.Drawing.Point(0, 67);
            this.tbTrainingLines.Multiline = true;
            this.tbTrainingLines.Name = "tbTrainingLines";
            this.tbTrainingLines.Size = new System.Drawing.Size(441, 499);
            this.tbTrainingLines.TabIndex = 2;
            // 
            // pLeftSeparator
            // 
            this.pLeftSeparator.BackColor = System.Drawing.Color.LightCoral;
            this.pLeftSeparator.Dock = System.Windows.Forms.DockStyle.Left;
            this.pLeftSeparator.Location = new System.Drawing.Point(441, 67);
            this.pLeftSeparator.Name = "pLeftSeparator";
            this.pLeftSeparator.Size = new System.Drawing.Size(44, 499);
            this.pLeftSeparator.TabIndex = 3;
            // 
            // tbGrammarLines
            // 
            this.tbGrammarLines.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tbGrammarLines.Cursor = System.Windows.Forms.Cursors.Hand;
            this.tbGrammarLines.Dock = System.Windows.Forms.DockStyle.Left;
            this.tbGrammarLines.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbGrammarLines.Location = new System.Drawing.Point(485, 67);
            this.tbGrammarLines.Multiline = true;
            this.tbGrammarLines.Name = "tbGrammarLines";
            this.tbGrammarLines.ReadOnly = true;
            this.tbGrammarLines.Size = new System.Drawing.Size(442, 499);
            this.tbGrammarLines.TabIndex = 4;
            // 
            // pRightSeparator
            // 
            this.pRightSeparator.BackColor = System.Drawing.Color.LightCoral;
            this.pRightSeparator.Dock = System.Windows.Forms.DockStyle.Left;
            this.pRightSeparator.Location = new System.Drawing.Point(927, 67);
            this.pRightSeparator.Name = "pRightSeparator";
            this.pRightSeparator.Size = new System.Drawing.Size(44, 499);
            this.pRightSeparator.TabIndex = 5;
            // 
            // tbGeneratedLines
            // 
            this.tbGeneratedLines.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tbGeneratedLines.Cursor = System.Windows.Forms.Cursors.Hand;
            this.tbGeneratedLines.Dock = System.Windows.Forms.DockStyle.Left;
            this.tbGeneratedLines.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbGeneratedLines.Location = new System.Drawing.Point(971, 67);
            this.tbGeneratedLines.Multiline = true;
            this.tbGeneratedLines.Name = "tbGeneratedLines";
            this.tbGeneratedLines.ReadOnly = true;
            this.tbGeneratedLines.Size = new System.Drawing.Size(423, 499);
            this.tbGeneratedLines.TabIndex = 6;
            // 
            // fMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1394, 636);
            this.Controls.Add(this.tbGeneratedLines);
            this.Controls.Add(this.pRightSeparator);
            this.Controls.Add(this.tbGrammarLines);
            this.Controls.Add(this.pLeftSeparator);
            this.Controls.Add(this.tbTrainingLines);
            this.Controls.Add(this.pUp);
            this.Controls.Add(this.pDown);
            this.Name = "fMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Лабораторная работа 8, 351004, Наривончик Александр";
            this.pDown.ResumeLayout(false);
            this.pUp.ResumeLayout(false);
            this.pUp.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel pDown;
        private System.Windows.Forms.Panel pUp;
        private System.Windows.Forms.TextBox tbTrainingLines;
        private System.Windows.Forms.Panel pLeftSeparator;
        private System.Windows.Forms.TextBox tbGrammarLines;
        private System.Windows.Forms.Panel pRightSeparator;
        private System.Windows.Forms.TextBox tbGeneratedLines;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lTrainingLines;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnGenerate;
        private System.Windows.Forms.Button btnTrain;
    }
}

