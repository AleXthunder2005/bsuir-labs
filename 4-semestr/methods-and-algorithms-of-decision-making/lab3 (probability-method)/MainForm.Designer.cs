namespace lab3
{
    partial class MainForm
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
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
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            lDetectionPass = new Label();
            lFalseAlarm = new Label();
            lSumError = new Label();
            pSide = new Panel();
            lProbabilityTitle2 = new Label();
            udProbability2 = new NumericUpDown();
            lProbabilityTitle1 = new Label();
            udProbability1 = new NumericUpDown();
            Chart = new System.Windows.Forms.DataVisualization.Charting.Chart();
            pSide.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)udProbability2).BeginInit();
            ((System.ComponentModel.ISupportInitialize)udProbability1).BeginInit();
            ((System.ComponentModel.ISupportInitialize)Chart).BeginInit();
            SuspendLayout();
            // 
            // lDetectionPass
            // 
            lDetectionPass.AutoSize = true;
            lDetectionPass.Font = new Font("Segoe UI", 11F, FontStyle.Regular, GraphicsUnit.Point);
            lDetectionPass.Location = new Point(12, 221);
            lDetectionPass.Name = "lDetectionPass";
            lDetectionPass.Size = new Size(214, 25);
            lDetectionPass.TabIndex = 4;
            lDetectionPass.Text = "Пропуск обнаружения:";
            // 
            // lFalseAlarm
            // 
            lFalseAlarm.AutoSize = true;
            lFalseAlarm.Font = new Font("Segoe UI", 11F, FontStyle.Regular, GraphicsUnit.Point);
            lFalseAlarm.Location = new Point(12, 196);
            lFalseAlarm.Name = "lFalseAlarm";
            lFalseAlarm.Size = new Size(162, 25);
            lFalseAlarm.TabIndex = 7;
            lFalseAlarm.Text = "Ложная тревога: ";
            // 
            // lSumError
            // 
            lSumError.AutoSize = true;
            lSumError.Font = new Font("Segoe UI", 11F, FontStyle.Regular, GraphicsUnit.Point);
            lSumError.Location = new Point(12, 246);
            lSumError.Name = "lSumError";
            lSumError.Size = new Size(187, 25);
            lSumError.TabIndex = 8;
            lSumError.Text = "Суммарная ошибка:";
            // 
            // pSide
            // 
            pSide.BackColor = Color.Bisque;
            pSide.Controls.Add(lProbabilityTitle2);
            pSide.Controls.Add(lSumError);
            pSide.Controls.Add(udProbability2);
            pSide.Controls.Add(lDetectionPass);
            pSide.Controls.Add(lProbabilityTitle1);
            pSide.Controls.Add(udProbability1);
            pSide.Controls.Add(lFalseAlarm);
            pSide.Dock = DockStyle.Left;
            pSide.Location = new Point(0, 0);
            pSide.Name = "pSide";
            pSide.Size = new Size(299, 746);
            pSide.TabIndex = 12;
            // 
            // lProbabilityTitle2
            // 
            lProbabilityTitle2.AutoSize = true;
            lProbabilityTitle2.Font = new Font("Segoe UI", 11F, FontStyle.Regular, GraphicsUnit.Point);
            lProbabilityTitle2.Location = new Point(12, 85);
            lProbabilityTitle2.Name = "lProbabilityTitle2";
            lProbabilityTitle2.Size = new Size(176, 25);
            lProbabilityTitle2.TabIndex = 14;
            lProbabilityTitle2.Text = "Вероятность P(C2):";
            // 
            // udProbability2
            // 
            udProbability2.DecimalPlaces = 2;
            udProbability2.Font = new Font("Segoe UI", 11F, FontStyle.Regular, GraphicsUnit.Point);
            udProbability2.Location = new Point(12, 113);
            udProbability2.Name = "udProbability2";
            udProbability2.Size = new Size(275, 32);
            udProbability2.TabIndex = 13;
            udProbability2.Value = new decimal(new int[] { 5000, 0, 0, 131072 });
            udProbability2.ValueChanged += udProbability2_ValueChanged;
            // 
            // lProbabilityTitle1
            // 
            lProbabilityTitle1.AutoSize = true;
            lProbabilityTitle1.Font = new Font("Segoe UI", 11F, FontStyle.Regular, GraphicsUnit.Point);
            lProbabilityTitle1.Location = new Point(12, 16);
            lProbabilityTitle1.Name = "lProbabilityTitle1";
            lProbabilityTitle1.Size = new Size(176, 25);
            lProbabilityTitle1.TabIndex = 12;
            lProbabilityTitle1.Text = "Вероятность P(C1):";
            // 
            // udProbability1
            // 
            udProbability1.DecimalPlaces = 2;
            udProbability1.Font = new Font("Segoe UI", 11F, FontStyle.Regular, GraphicsUnit.Point);
            udProbability1.Location = new Point(12, 44);
            udProbability1.Name = "udProbability1";
            udProbability1.Size = new Size(275, 32);
            udProbability1.TabIndex = 11;
            udProbability1.Value = new decimal(new int[] { 5000, 0, 0, 131072 });
            udProbability1.ValueChanged += udProbability1_ValueChanged;
            // 
            // Chart
            // 
            chartArea1.Name = "ChartArea1";
            Chart.ChartAreas.Add(chartArea1);
            Chart.Cursor = Cursors.Hand;
            Chart.Dock = DockStyle.Fill;
            legend1.Name = "Legend1";
            Chart.Legends.Add(legend1);
            Chart.Location = new Point(299, 0);
            Chart.Name = "Chart";
            Chart.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.SeaGreen;
            Chart.Size = new Size(1058, 746);
            Chart.TabIndex = 13;
            // 
            // MainForm
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1357, 746);
            Controls.Add(Chart);
            Controls.Add(pSide);
            Name = "MainForm";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Лабораторная работа 3, Наривончик Александр, 351004";
            pSide.ResumeLayout(false);
            pSide.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)udProbability2).EndInit();
            ((System.ComponentModel.ISupportInitialize)udProbability1).EndInit();
            ((System.ComponentModel.ISupportInitialize)Chart).EndInit();
            ResumeLayout(false);
        }

        #endregion
        private Label lDetectionPass;
        private Label lFalseAlarm;
        private Label lSumError;
        private Panel pSide;
        private Label lProbabilityTitle1;
        private NumericUpDown udProbability1;
        private Label lProbabilityTitle2;
        private NumericUpDown udProbability2;
        private System.Windows.Forms.DataVisualization.Charting.Chart Chart;
    }
}