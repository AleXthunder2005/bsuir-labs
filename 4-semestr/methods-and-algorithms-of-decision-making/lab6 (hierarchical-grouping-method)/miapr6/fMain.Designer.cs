namespace miapr6
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
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            this.pSide = new System.Windows.Forms.Panel();
            this.lObjectCount = new System.Windows.Forms.Label();
            this.udObjectCount = new System.Windows.Forms.NumericUpDown();
            this.btnGrouping = new System.Windows.Forms.Button();
            this.btnGenerateDistanceTable = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.pDistanseTable = new System.Windows.Forms.Panel();
            this.dgvDistanceTable = new System.Windows.Forms.DataGridView();
            this.chart = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.cbMaxCritery = new System.Windows.Forms.CheckBox();
            this.pSide.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.udObjectCount)).BeginInit();
            this.pDistanseTable.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDistanceTable)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.chart)).BeginInit();
            this.SuspendLayout();
            // 
            // pSide
            // 
            this.pSide.BackColor = System.Drawing.Color.DodgerBlue;
            this.pSide.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pSide.Controls.Add(this.cbMaxCritery);
            this.pSide.Controls.Add(this.lObjectCount);
            this.pSide.Controls.Add(this.udObjectCount);
            this.pSide.Controls.Add(this.btnGrouping);
            this.pSide.Controls.Add(this.btnGenerateDistanceTable);
            this.pSide.Controls.Add(this.btnExit);
            this.pSide.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSide.Location = new System.Drawing.Point(0, 0);
            this.pSide.Name = "pSide";
            this.pSide.Size = new System.Drawing.Size(285, 627);
            this.pSide.TabIndex = 0;
            // 
            // lObjectCount
            // 
            this.lObjectCount.AutoSize = true;
            this.lObjectCount.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lObjectCount.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.lObjectCount.Location = new System.Drawing.Point(13, 28);
            this.lObjectCount.Name = "lObjectCount";
            this.lObjectCount.Size = new System.Drawing.Size(231, 28);
            this.lObjectCount.TabIndex = 4;
            this.lObjectCount.Text = "Количество объектов:";
            // 
            // udObjectCount
            // 
            this.udObjectCount.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.udObjectCount.Location = new System.Drawing.Point(12, 65);
            this.udObjectCount.Minimum = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.udObjectCount.Name = "udObjectCount";
            this.udObjectCount.Size = new System.Drawing.Size(260, 34);
            this.udObjectCount.TabIndex = 3;
            this.udObjectCount.Value = new decimal(new int[] {
            2,
            0,
            0,
            0});
            // 
            // btnGrouping
            // 
            this.btnGrouping.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnGrouping.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnGrouping.Location = new System.Drawing.Point(12, 153);
            this.btnGrouping.Name = "btnGrouping";
            this.btnGrouping.Size = new System.Drawing.Size(260, 37);
            this.btnGrouping.TabIndex = 2;
            this.btnGrouping.Text = "Сгруппировать";
            this.btnGrouping.UseVisualStyleBackColor = true;
            this.btnGrouping.Click += new System.EventHandler(this.btnGrouping_Click);
            // 
            // btnGenerateDistanceTable
            // 
            this.btnGenerateDistanceTable.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnGenerateDistanceTable.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnGenerateDistanceTable.Location = new System.Drawing.Point(12, 110);
            this.btnGenerateDistanceTable.Name = "btnGenerateDistanceTable";
            this.btnGenerateDistanceTable.Size = new System.Drawing.Size(260, 37);
            this.btnGenerateDistanceTable.TabIndex = 1;
            this.btnGenerateDistanceTable.Text = "Сгенерировать таблицу";
            this.btnGenerateDistanceTable.UseVisualStyleBackColor = true;
            this.btnGenerateDistanceTable.Click += new System.EventHandler(this.btnGenerateDistanceTable_Click);
            // 
            // btnExit
            // 
            this.btnExit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnExit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnExit.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Location = new System.Drawing.Point(12, 576);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(260, 37);
            this.btnExit.TabIndex = 0;
            this.btnExit.Text = "Выход";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // pDistanseTable
            // 
            this.pDistanseTable.BackColor = System.Drawing.Color.DodgerBlue;
            this.pDistanseTable.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pDistanseTable.Controls.Add(this.dgvDistanceTable);
            this.pDistanseTable.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.pDistanseTable.Location = new System.Drawing.Point(285, 321);
            this.pDistanseTable.Name = "pDistanseTable";
            this.pDistanseTable.Size = new System.Drawing.Size(1051, 306);
            this.pDistanseTable.TabIndex = 1;
            // 
            // dgvDistanceTable
            // 
            this.dgvDistanceTable.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgvDistanceTable.BackgroundColor = System.Drawing.Color.LightBlue;
            this.dgvDistanceTable.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDistanceTable.Location = new System.Drawing.Point(12, 8);
            this.dgvDistanceTable.Name = "dgvDistanceTable";
            this.dgvDistanceTable.RowHeadersWidth = 51;
            this.dgvDistanceTable.RowTemplate.Height = 24;
            this.dgvDistanceTable.Size = new System.Drawing.Size(1024, 288);
            this.dgvDistanceTable.TabIndex = 0;
            // 
            // chart
            // 
            chartArea1.Name = "ChartArea1";
            this.chart.ChartAreas.Add(chartArea1);
            this.chart.Dock = System.Windows.Forms.DockStyle.Fill;
            legend1.Name = "Legend1";
            this.chart.Legends.Add(legend1);
            this.chart.Location = new System.Drawing.Point(285, 0);
            this.chart.Name = "chart";
            this.chart.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Bright;
            this.chart.Size = new System.Drawing.Size(1051, 321);
            this.chart.TabIndex = 2;
            this.chart.Text = "chart1";
            // 
            // cbMaxCritery
            // 
            this.cbMaxCritery.AutoSize = true;
            this.cbMaxCritery.Cursor = System.Windows.Forms.Cursors.Hand;
            this.cbMaxCritery.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbMaxCritery.Location = new System.Drawing.Point(12, 208);
            this.cbMaxCritery.Name = "cbMaxCritery";
            this.cbMaxCritery.Size = new System.Drawing.Size(265, 32);
            this.cbMaxCritery.TabIndex = 5;
            this.cbMaxCritery.Text = "По критерию максимума";
            this.cbMaxCritery.UseVisualStyleBackColor = true;
            // 
            // fMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1336, 627);
            this.Controls.Add(this.chart);
            this.Controls.Add(this.pDistanseTable);
            this.Controls.Add(this.pSide);
            this.Name = "fMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Лабораторная работа 6, Наривончик Александр, 351004";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.pSide.ResumeLayout(false);
            this.pSide.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.udObjectCount)).EndInit();
            this.pDistanseTable.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvDistanceTable)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.chart)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pSide;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Panel pDistanseTable;
        private System.Windows.Forms.DataVisualization.Charting.Chart chart;
        private System.Windows.Forms.Label lObjectCount;
        private System.Windows.Forms.NumericUpDown udObjectCount;
        private System.Windows.Forms.Button btnGrouping;
        private System.Windows.Forms.Button btnGenerateDistanceTable;
        private System.Windows.Forms.DataGridView dgvDistanceTable;
        private System.Windows.Forms.CheckBox cbMaxCritery;
    }
}

