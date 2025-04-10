namespace miapr4_new
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
            this.btnGenerateTestSet = new System.Windows.Forms.Button();
            this.lTestObjectCount = new System.Windows.Forms.Label();
            this.udTestObjectCount = new System.Windows.Forms.NumericUpDown();
            this.btnClearAll = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.bthGenerateTrainingSet = new System.Windows.Forms.Button();
            this.lTrainingSetTitle = new System.Windows.Forms.Label();
            this.lSignCount = new System.Windows.Forms.Label();
            this.lTrainingObjectCount = new System.Windows.Forms.Label();
            this.lClassCount = new System.Windows.Forms.Label();
            this.udSignCount = new System.Windows.Forms.NumericUpDown();
            this.udClassObjectCount = new System.Windows.Forms.NumericUpDown();
            this.udClassCount = new System.Windows.Forms.NumericUpDown();
            this.pTrainingSet = new System.Windows.Forms.Panel();
            this.lTrainingSet = new System.Windows.Forms.Label();
            this.lbTrainingSet = new System.Windows.Forms.ListBox();
            this.pDecisionFunctions = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.lbDecisionFunctions = new System.Windows.Forms.ListBox();
            this.lbTestSet = new System.Windows.Forms.ListBox();
            this.pTestSet = new System.Windows.Forms.Panel();
            this.lTestSet = new System.Windows.Forms.Label();
            this.lSubstitution = new System.Windows.Forms.Label();
            this.lbSubstitution = new System.Windows.Forms.ListBox();
            this.pSubstitution = new System.Windows.Forms.Panel();
            this.pSide.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.udTestObjectCount)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.udSignCount)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.udClassObjectCount)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.udClassCount)).BeginInit();
            this.pTrainingSet.SuspendLayout();
            this.pDecisionFunctions.SuspendLayout();
            this.pTestSet.SuspendLayout();
            this.pSubstitution.SuspendLayout();
            this.SuspendLayout();
            // 
            // pSide
            // 
            this.pSide.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.pSide.Controls.Add(this.btnGenerateTestSet);
            this.pSide.Controls.Add(this.lTestObjectCount);
            this.pSide.Controls.Add(this.udTestObjectCount);
            this.pSide.Controls.Add(this.btnClearAll);
            this.pSide.Controls.Add(this.btnExit);
            this.pSide.Controls.Add(this.bthGenerateTrainingSet);
            this.pSide.Controls.Add(this.lTrainingSetTitle);
            this.pSide.Controls.Add(this.lSignCount);
            this.pSide.Controls.Add(this.lTrainingObjectCount);
            this.pSide.Controls.Add(this.lClassCount);
            this.pSide.Controls.Add(this.udSignCount);
            this.pSide.Controls.Add(this.udClassObjectCount);
            this.pSide.Controls.Add(this.udClassCount);
            this.pSide.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSide.Location = new System.Drawing.Point(0, 0);
            this.pSide.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pSide.Name = "pSide";
            this.pSide.Size = new System.Drawing.Size(358, 650);
            this.pSide.TabIndex = 0;
            // 
            // btnGenerateTestSet
            // 
            this.btnGenerateTestSet.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnGenerateTestSet.Location = new System.Drawing.Point(18, 444);
            this.btnGenerateTestSet.Name = "btnGenerateTestSet";
            this.btnGenerateTestSet.Size = new System.Drawing.Size(323, 38);
            this.btnGenerateTestSet.TabIndex = 19;
            this.btnGenerateTestSet.Text = "Создать тестовую выборку";
            this.btnGenerateTestSet.UseVisualStyleBackColor = true;
            this.btnGenerateTestSet.Click += new System.EventHandler(this.btnGenerateTestSet_Click);
            // 
            // lTestObjectCount
            // 
            this.lTestObjectCount.AutoSize = true;
            this.lTestObjectCount.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lTestObjectCount.Location = new System.Drawing.Point(13, 379);
            this.lTestObjectCount.Name = "lTestObjectCount";
            this.lTestObjectCount.Size = new System.Drawing.Size(259, 23);
            this.lTestObjectCount.TabIndex = 18;
            this.lTestObjectCount.Text = "Количество тестовых объектов:";
            // 
            // udTestObjectCount
            // 
            this.udTestObjectCount.Cursor = System.Windows.Forms.Cursors.Hand;
            this.udTestObjectCount.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.udTestObjectCount.Location = new System.Drawing.Point(18, 407);
            this.udTestObjectCount.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.udTestObjectCount.Minimum = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.udTestObjectCount.Name = "udTestObjectCount";
            this.udTestObjectCount.Size = new System.Drawing.Size(323, 32);
            this.udTestObjectCount.TabIndex = 17;
            this.udTestObjectCount.Value = new decimal(new int[] {
            2,
            0,
            0,
            0});
            // 
            // btnClearAll
            // 
            this.btnClearAll.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClearAll.Location = new System.Drawing.Point(18, 287);
            this.btnClearAll.Name = "btnClearAll";
            this.btnClearAll.Size = new System.Drawing.Size(323, 38);
            this.btnClearAll.TabIndex = 16;
            this.btnClearAll.Text = "Очистить всё";
            this.btnClearAll.UseVisualStyleBackColor = true;
            this.btnClearAll.Click += new System.EventHandler(this.btnClearAll_Click);
            // 
            // btnExit
            // 
            this.btnExit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnExit.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Location = new System.Drawing.Point(16, 600);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(323, 38);
            this.btnExit.TabIndex = 15;
            this.btnExit.Text = "Выход";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // bthGenerateTrainingSet
            // 
            this.bthGenerateTrainingSet.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.bthGenerateTrainingSet.Location = new System.Drawing.Point(16, 243);
            this.bthGenerateTrainingSet.Name = "bthGenerateTrainingSet";
            this.bthGenerateTrainingSet.Size = new System.Drawing.Size(323, 38);
            this.bthGenerateTrainingSet.TabIndex = 14;
            this.bthGenerateTrainingSet.Text = "Создать обучающую выборку";
            this.bthGenerateTrainingSet.UseVisualStyleBackColor = true;
            this.bthGenerateTrainingSet.Click += new System.EventHandler(this.bthGenerateTrainingSet_Click);
            // 
            // lTrainingSetTitle
            // 
            this.lTrainingSetTitle.AutoSize = true;
            this.lTrainingSetTitle.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lTrainingSetTitle.Location = new System.Drawing.Point(8, 11);
            this.lTrainingSetTitle.Name = "lTrainingSetTitle";
            this.lTrainingSetTitle.Size = new System.Drawing.Size(296, 23);
            this.lTrainingSetTitle.TabIndex = 13;
            this.lTrainingSetTitle.Text = "Параметры обучающей выборки:";
            // 
            // lSignCount
            // 
            this.lSignCount.AutoSize = true;
            this.lSignCount.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lSignCount.Location = new System.Drawing.Point(11, 178);
            this.lSignCount.Name = "lSignCount";
            this.lSignCount.Size = new System.Drawing.Size(195, 23);
            this.lSignCount.TabIndex = 12;
            this.lSignCount.Text = "Количество признаков:";
            // 
            // lTrainingObjectCount
            // 
            this.lTrainingObjectCount.AutoSize = true;
            this.lTrainingObjectCount.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lTrainingObjectCount.Location = new System.Drawing.Point(11, 111);
            this.lTrainingObjectCount.Name = "lTrainingObjectCount";
            this.lTrainingObjectCount.Size = new System.Drawing.Size(311, 23);
            this.lTrainingObjectCount.TabIndex = 11;
            this.lTrainingObjectCount.Text = "Количество объектов каждого класса:";
            // 
            // lClassCount
            // 
            this.lClassCount.AutoSize = true;
            this.lClassCount.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lClassCount.Location = new System.Drawing.Point(11, 46);
            this.lClassCount.Name = "lClassCount";
            this.lClassCount.Size = new System.Drawing.Size(172, 23);
            this.lClassCount.TabIndex = 10;
            this.lClassCount.Text = "Количество классов:";
            // 
            // udSignCount
            // 
            this.udSignCount.Cursor = System.Windows.Forms.Cursors.Hand;
            this.udSignCount.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.udSignCount.Location = new System.Drawing.Point(16, 206);
            this.udSignCount.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.udSignCount.Minimum = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.udSignCount.Name = "udSignCount";
            this.udSignCount.Size = new System.Drawing.Size(323, 32);
            this.udSignCount.TabIndex = 9;
            this.udSignCount.Value = new decimal(new int[] {
            2,
            0,
            0,
            0});
            // 
            // udClassObjectCount
            // 
            this.udClassObjectCount.Cursor = System.Windows.Forms.Cursors.Hand;
            this.udClassObjectCount.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.udClassObjectCount.Location = new System.Drawing.Point(16, 139);
            this.udClassObjectCount.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.udClassObjectCount.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.udClassObjectCount.Name = "udClassObjectCount";
            this.udClassObjectCount.Size = new System.Drawing.Size(323, 32);
            this.udClassObjectCount.TabIndex = 8;
            this.udClassObjectCount.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // udClassCount
            // 
            this.udClassCount.Cursor = System.Windows.Forms.Cursors.Hand;
            this.udClassCount.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.udClassCount.Location = new System.Drawing.Point(16, 74);
            this.udClassCount.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.udClassCount.Maximum = new decimal(new int[] {
            20,
            0,
            0,
            0});
            this.udClassCount.Minimum = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.udClassCount.Name = "udClassCount";
            this.udClassCount.Size = new System.Drawing.Size(323, 32);
            this.udClassCount.TabIndex = 7;
            this.udClassCount.Value = new decimal(new int[] {
            2,
            0,
            0,
            0});
            // 
            // pTrainingSet
            // 
            this.pTrainingSet.BackColor = System.Drawing.SystemColors.Window;
            this.pTrainingSet.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pTrainingSet.Controls.Add(this.lTrainingSet);
            this.pTrainingSet.Controls.Add(this.lbTrainingSet);
            this.pTrainingSet.Dock = System.Windows.Forms.DockStyle.Left;
            this.pTrainingSet.Location = new System.Drawing.Point(358, 0);
            this.pTrainingSet.Name = "pTrainingSet";
            this.pTrainingSet.Size = new System.Drawing.Size(353, 650);
            this.pTrainingSet.TabIndex = 1;
            // 
            // lTrainingSet
            // 
            this.lTrainingSet.AutoSize = true;
            this.lTrainingSet.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lTrainingSet.Location = new System.Drawing.Point(58, 11);
            this.lTrainingSet.Name = "lTrainingSet";
            this.lTrainingSet.Size = new System.Drawing.Size(223, 28);
            this.lTrainingSet.TabIndex = 17;
            this.lTrainingSet.Text = "Обучающая выборка";
            // 
            // lbTrainingSet
            // 
            this.lbTrainingSet.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbTrainingSet.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawFixed;
            this.lbTrainingSet.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbTrainingSet.FormattingEnabled = true;
            this.lbTrainingSet.ItemHeight = 25;
            this.lbTrainingSet.Location = new System.Drawing.Point(15, 54);
            this.lbTrainingSet.Name = "lbTrainingSet";
            this.lbTrainingSet.Size = new System.Drawing.Size(321, 579);
            this.lbTrainingSet.TabIndex = 16;
            this.lbTrainingSet.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.lbTrainingSet_DrawItem);
            // 
            // pDecisionFunctions
            // 
            this.pDecisionFunctions.BackColor = System.Drawing.SystemColors.Window;
            this.pDecisionFunctions.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pDecisionFunctions.Controls.Add(this.label1);
            this.pDecisionFunctions.Controls.Add(this.lbDecisionFunctions);
            this.pDecisionFunctions.Dock = System.Windows.Forms.DockStyle.Left;
            this.pDecisionFunctions.Location = new System.Drawing.Point(711, 0);
            this.pDecisionFunctions.Name = "pDecisionFunctions";
            this.pDecisionFunctions.Size = new System.Drawing.Size(436, 650);
            this.pDecisionFunctions.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(76, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(245, 28);
            this.label1.TabIndex = 18;
            this.label1.Text = "Разделяющие функции";
            // 
            // lbDecisionFunctions
            // 
            this.lbDecisionFunctions.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbDecisionFunctions.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawFixed;
            this.lbDecisionFunctions.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbDecisionFunctions.FormattingEnabled = true;
            this.lbDecisionFunctions.ItemHeight = 25;
            this.lbDecisionFunctions.Location = new System.Drawing.Point(15, 54);
            this.lbDecisionFunctions.Name = "lbDecisionFunctions";
            this.lbDecisionFunctions.Size = new System.Drawing.Size(401, 579);
            this.lbDecisionFunctions.TabIndex = 17;
            this.lbDecisionFunctions.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.lbTrainingSet_DrawItem);
            // 
            // lbTestSet
            // 
            this.lbTestSet.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbTestSet.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawFixed;
            this.lbTestSet.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbTestSet.FormattingEnabled = true;
            this.lbTestSet.ItemHeight = 25;
            this.lbTestSet.Location = new System.Drawing.Point(15, 54);
            this.lbTestSet.Name = "lbTestSet";
            this.lbTestSet.Size = new System.Drawing.Size(321, 579);
            this.lbTestSet.TabIndex = 16;
            this.lbTestSet.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.lbTestSet_DrawItem);
            this.lbTestSet.SelectedIndexChanged += new System.EventHandler(this.lbTestSet_SelectedIndexChanged);
            // 
            // pTestSet
            // 
            this.pTestSet.BackColor = System.Drawing.SystemColors.Window;
            this.pTestSet.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pTestSet.Controls.Add(this.lTestSet);
            this.pTestSet.Controls.Add(this.lbTestSet);
            this.pTestSet.Dock = System.Windows.Forms.DockStyle.Left;
            this.pTestSet.Location = new System.Drawing.Point(1147, 0);
            this.pTestSet.Name = "pTestSet";
            this.pTestSet.Size = new System.Drawing.Size(353, 650);
            this.pTestSet.TabIndex = 3;
            // 
            // lTestSet
            // 
            this.lTestSet.AutoSize = true;
            this.lTestSet.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lTestSet.Location = new System.Drawing.Point(81, 10);
            this.lTestSet.Name = "lTestSet";
            this.lTestSet.Size = new System.Drawing.Size(190, 28);
            this.lTestSet.TabIndex = 17;
            this.lTestSet.Text = "Тестовая выборка";
            // 
            // lSubstitution
            // 
            this.lSubstitution.AutoSize = true;
            this.lSubstitution.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lSubstitution.Location = new System.Drawing.Point(105, 11);
            this.lSubstitution.Name = "lSubstitution";
            this.lSubstitution.Size = new System.Drawing.Size(397, 28);
            this.lSubstitution.TabIndex = 17;
            this.lSubstitution.Text = "Подстановка в разделяющие функции";
            // 
            // lbSubstitution
            // 
            this.lbSubstitution.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbSubstitution.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawFixed;
            this.lbSubstitution.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbSubstitution.FormattingEnabled = true;
            this.lbSubstitution.ItemHeight = 25;
            this.lbSubstitution.Location = new System.Drawing.Point(15, 54);
            this.lbSubstitution.Name = "lbSubstitution";
            this.lbSubstitution.Size = new System.Drawing.Size(231, 579);
            this.lbSubstitution.TabIndex = 16;
            this.lbSubstitution.DrawItem += new System.Windows.Forms.DrawItemEventHandler(this.lbSubstitution_DrawItem);
            // 
            // pSubstitution
            // 
            this.pSubstitution.BackColor = System.Drawing.SystemColors.Window;
            this.pSubstitution.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pSubstitution.Controls.Add(this.lSubstitution);
            this.pSubstitution.Controls.Add(this.lbSubstitution);
            this.pSubstitution.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pSubstitution.Location = new System.Drawing.Point(1500, 0);
            this.pSubstitution.Name = "pSubstitution";
            this.pSubstitution.Size = new System.Drawing.Size(263, 650);
            this.pSubstitution.TabIndex = 4;
            // 
            // fMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1763, 650);
            this.Controls.Add(this.pSubstitution);
            this.Controls.Add(this.pTestSet);
            this.Controls.Add(this.pDecisionFunctions);
            this.Controls.Add(this.pTrainingSet);
            this.Controls.Add(this.pSide);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "fMain";
            this.Text = "Лабораторная работа 4, Наривончик Александр, 351004";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.pSide.ResumeLayout(false);
            this.pSide.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.udTestObjectCount)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.udSignCount)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.udClassObjectCount)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.udClassCount)).EndInit();
            this.pTrainingSet.ResumeLayout(false);
            this.pTrainingSet.PerformLayout();
            this.pDecisionFunctions.ResumeLayout(false);
            this.pDecisionFunctions.PerformLayout();
            this.pTestSet.ResumeLayout(false);
            this.pTestSet.PerformLayout();
            this.pSubstitution.ResumeLayout(false);
            this.pSubstitution.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pSide;
        private System.Windows.Forms.Label lTrainingSetTitle;
        private System.Windows.Forms.Label lSignCount;
        private System.Windows.Forms.Label lTrainingObjectCount;
        private System.Windows.Forms.Label lClassCount;
        private System.Windows.Forms.NumericUpDown udSignCount;
        private System.Windows.Forms.NumericUpDown udClassObjectCount;
        private System.Windows.Forms.NumericUpDown udClassCount;
        private System.Windows.Forms.Button bthGenerateTrainingSet;
        private System.Windows.Forms.Panel pTrainingSet;
        private System.Windows.Forms.ListBox lbTrainingSet;
        private System.Windows.Forms.Panel pDecisionFunctions;
        private System.Windows.Forms.ListBox lbDecisionFunctions;
        private System.Windows.Forms.Button btnClearAll;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Label lTrainingSet;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnGenerateTestSet;
        private System.Windows.Forms.Label lTestObjectCount;
        private System.Windows.Forms.NumericUpDown udTestObjectCount;
        private System.Windows.Forms.ListBox lbTestSet;
        private System.Windows.Forms.Panel pTestSet;
        private System.Windows.Forms.Label lTestSet;
        private System.Windows.Forms.Label lSubstitution;
        private System.Windows.Forms.ListBox lbSubstitution;
        private System.Windows.Forms.Panel pSubstitution;
    }
}

