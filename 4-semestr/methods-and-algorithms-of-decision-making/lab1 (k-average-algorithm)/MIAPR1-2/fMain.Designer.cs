namespace MIAPR1_2
{
    partial class fMain
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
            this.pSideMenu = new System.Windows.Forms.Panel();
            this.udObjectCount = new System.Windows.Forms.NumericUpDown();
            this.udClassCount = new System.Windows.Forms.NumericUpDown();
            this.btnExit = new System.Windows.Forms.Button();
            this.gbAlgorithm = new System.Windows.Forms.GroupBox();
            this.rbtnMaximin = new System.Windows.Forms.RadioButton();
            this.rbtnKAverage = new System.Windows.Forms.RadioButton();
            this.btnObjectGeneration = new System.Windows.Forms.Button();
            this.btnStartRecognition = new System.Windows.Forms.Button();
            this.lObjectCount = new System.Windows.Forms.Label();
            this.lTitle = new System.Windows.Forms.Label();
            this.lClassCount = new System.Windows.Forms.Label();
            this.pContent = new System.Windows.Forms.Panel();
            this.pSideMenu.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.udObjectCount)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.udClassCount)).BeginInit();
            this.gbAlgorithm.SuspendLayout();
            this.SuspendLayout();
            // 
            // pSideMenu
            // 
            this.pSideMenu.BackColor = System.Drawing.Color.Coral;
            this.pSideMenu.Controls.Add(this.udObjectCount);
            this.pSideMenu.Controls.Add(this.udClassCount);
            this.pSideMenu.Controls.Add(this.btnExit);
            this.pSideMenu.Controls.Add(this.gbAlgorithm);
            this.pSideMenu.Controls.Add(this.btnObjectGeneration);
            this.pSideMenu.Controls.Add(this.btnStartRecognition);
            this.pSideMenu.Controls.Add(this.lObjectCount);
            this.pSideMenu.Controls.Add(this.lTitle);
            this.pSideMenu.Controls.Add(this.lClassCount);
            this.pSideMenu.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSideMenu.Location = new System.Drawing.Point(0, 0);
            this.pSideMenu.Name = "pSideMenu";
            this.pSideMenu.Size = new System.Drawing.Size(318, 753);
            this.pSideMenu.TabIndex = 0;
            // 
            // udObjectCount
            // 
            this.udObjectCount.Cursor = System.Windows.Forms.Cursors.Hand;
            this.udObjectCount.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.udObjectCount.Increment = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            this.udObjectCount.Location = new System.Drawing.Point(16, 125);
            this.udObjectCount.Maximum = new decimal(new int[] {
            100000,
            0,
            0,
            0});
            this.udObjectCount.Minimum = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            this.udObjectCount.Name = "udObjectCount";
            this.udObjectCount.Size = new System.Drawing.Size(287, 26);
            this.udObjectCount.TabIndex = 10;
            this.udObjectCount.Value = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            // 
            // udClassCount
            // 
            this.udClassCount.Cursor = System.Windows.Forms.Cursors.Hand;
            this.udClassCount.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.udClassCount.Location = new System.Drawing.Point(234, 57);
            this.udClassCount.Name = "udClassCount";
            this.udClassCount.Size = new System.Drawing.Size(69, 26);
            this.udClassCount.TabIndex = 9;
            this.udClassCount.Value = new decimal(new int[] {
            2,
            0,
            0,
            0});
            // 
            // btnExit
            // 
            this.btnExit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnExit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnExit.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnExit.Location = new System.Drawing.Point(16, 698);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(287, 29);
            this.btnExit.TabIndex = 8;
            this.btnExit.Text = "Выход";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // gbAlgorithm
            // 
            this.gbAlgorithm.Controls.Add(this.rbtnMaximin);
            this.gbAlgorithm.Controls.Add(this.rbtnKAverage);
            this.gbAlgorithm.Cursor = System.Windows.Forms.Cursors.Hand;
            this.gbAlgorithm.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.gbAlgorithm.Location = new System.Drawing.Point(16, 287);
            this.gbAlgorithm.Name = "gbAlgorithm";
            this.gbAlgorithm.Size = new System.Drawing.Size(287, 86);
            this.gbAlgorithm.TabIndex = 7;
            this.gbAlgorithm.TabStop = false;
            this.gbAlgorithm.Text = "Использовать алгоритм";
            // 
            // rbtnMaximin
            // 
            this.rbtnMaximin.AutoSize = true;
            this.rbtnMaximin.Location = new System.Drawing.Point(7, 49);
            this.rbtnMaximin.Name = "rbtnMaximin";
            this.rbtnMaximin.Size = new System.Drawing.Size(122, 24);
            this.rbtnMaximin.TabIndex = 1;
            this.rbtnMaximin.TabStop = true;
            this.rbtnMaximin.Text = "Максимин";
            this.rbtnMaximin.UseVisualStyleBackColor = true;
            // 
            // rbtnKAverage
            // 
            this.rbtnKAverage.AutoSize = true;
            this.rbtnKAverage.Checked = true;
            this.rbtnKAverage.Location = new System.Drawing.Point(7, 22);
            this.rbtnKAverage.Name = "rbtnKAverage";
            this.rbtnKAverage.Size = new System.Drawing.Size(125, 24);
            this.rbtnKAverage.TabIndex = 0;
            this.rbtnKAverage.TabStop = true;
            this.rbtnKAverage.Text = "K-средних";
            this.rbtnKAverage.UseVisualStyleBackColor = true;
            // 
            // btnObjectGeneration
            // 
            this.btnObjectGeneration.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnObjectGeneration.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnObjectGeneration.Location = new System.Drawing.Point(16, 157);
            this.btnObjectGeneration.Name = "btnObjectGeneration";
            this.btnObjectGeneration.Size = new System.Drawing.Size(287, 29);
            this.btnObjectGeneration.TabIndex = 6;
            this.btnObjectGeneration.Text = "Сгенерировать образы";
            this.btnObjectGeneration.UseVisualStyleBackColor = true;
            this.btnObjectGeneration.Click += new System.EventHandler(this.btnObjectGeneration_Click);
            // 
            // btnStartRecognition
            // 
            this.btnStartRecognition.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnStartRecognition.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btnStartRecognition.Location = new System.Drawing.Point(16, 236);
            this.btnStartRecognition.Name = "btnStartRecognition";
            this.btnStartRecognition.Size = new System.Drawing.Size(287, 29);
            this.btnStartRecognition.TabIndex = 5;
            this.btnStartRecognition.Text = "Начать распознавание";
            this.btnStartRecognition.UseVisualStyleBackColor = true;
            this.btnStartRecognition.Click += new System.EventHandler(this.btnStartRecognition_Click);
            // 
            // lObjectCount
            // 
            this.lObjectCount.AutoSize = true;
            this.lObjectCount.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lObjectCount.Location = new System.Drawing.Point(12, 95);
            this.lObjectCount.Name = "lObjectCount";
            this.lObjectCount.Size = new System.Drawing.Size(207, 20);
            this.lObjectCount.TabIndex = 3;
            this.lObjectCount.Text = "Количество образов:";
            // 
            // lTitle
            // 
            this.lTitle.AutoSize = true;
            this.lTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lTitle.Location = new System.Drawing.Point(12, 9);
            this.lTitle.Name = "lTitle";
            this.lTitle.Size = new System.Drawing.Size(278, 20);
            this.lTitle.TabIndex = 2;
            this.lTitle.Text = "РАСПОЗНАВАНИЕ ОБРАЗОВ";
            // 
            // lClassCount
            // 
            this.lClassCount.AutoSize = true;
            this.lClassCount.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lClassCount.Location = new System.Drawing.Point(12, 59);
            this.lClassCount.Name = "lClassCount";
            this.lClassCount.Size = new System.Drawing.Size(205, 20);
            this.lClassCount.TabIndex = 1;
            this.lClassCount.Text = "Количество классов:";
            // 
            // pContent
            // 
            this.pContent.AutoScroll = true;
            this.pContent.BackColor = System.Drawing.Color.White;
            this.pContent.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pContent.Location = new System.Drawing.Point(318, 0);
            this.pContent.Name = "pContent";
            this.pContent.Size = new System.Drawing.Size(1164, 753);
            this.pContent.TabIndex = 1;
            // 
            // fMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1482, 753);
            this.Controls.Add(this.pContent);
            this.Controls.Add(this.pSideMenu);
            this.MinimumSize = new System.Drawing.Size(1500, 800);
            this.Name = "fMain";
            this.Text = "Лабораторная работа 1-2, 351004, Наривончик Александр";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.pSideMenu.ResumeLayout(false);
            this.pSideMenu.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.udObjectCount)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.udClassCount)).EndInit();
            this.gbAlgorithm.ResumeLayout(false);
            this.gbAlgorithm.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pSideMenu;
        private System.Windows.Forms.Label lClassCount;
        private System.Windows.Forms.Label lTitle;
        private System.Windows.Forms.Label lObjectCount;
        private System.Windows.Forms.Button btnObjectGeneration;
        private System.Windows.Forms.Button btnStartRecognition;
        private System.Windows.Forms.GroupBox gbAlgorithm;
        private System.Windows.Forms.RadioButton rbtnMaximin;
        private System.Windows.Forms.RadioButton rbtnKAverage;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.NumericUpDown udClassCount;
        private System.Windows.Forms.NumericUpDown udObjectCount;
        private System.Windows.Forms.Panel pContent;
    }
}

