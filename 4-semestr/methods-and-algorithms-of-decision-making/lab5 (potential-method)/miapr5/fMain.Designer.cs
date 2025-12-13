namespace miapr5
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
            this.btnStartClassification = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.btnGenerateObjects = new System.Windows.Forms.Button();
            this.lClassPresenterCount = new System.Windows.Forms.Label();
            this.udClassPresenterCount = new System.Windows.Forms.NumericUpDown();
            this.pContent = new System.Windows.Forms.Panel();
            this.pSide.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.udClassPresenterCount)).BeginInit();
            this.SuspendLayout();
            // 
            // pSide
            // 
            this.pSide.BackColor = System.Drawing.Color.SeaGreen;
            this.pSide.Controls.Add(this.btnStartClassification);
            this.pSide.Controls.Add(this.btnExit);
            this.pSide.Controls.Add(this.btnGenerateObjects);
            this.pSide.Controls.Add(this.lClassPresenterCount);
            this.pSide.Controls.Add(this.udClassPresenterCount);
            this.pSide.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSide.Location = new System.Drawing.Point(0, 0);
            this.pSide.Name = "pSide";
            this.pSide.Size = new System.Drawing.Size(334, 666);
            this.pSide.TabIndex = 0;
            // 
            // btnStartClassification
            // 
            this.btnStartClassification.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnStartClassification.Location = new System.Drawing.Point(12, 170);
            this.btnStartClassification.Name = "btnStartClassification";
            this.btnStartClassification.Size = new System.Drawing.Size(298, 44);
            this.btnStartClassification.TabIndex = 4;
            this.btnStartClassification.Text = "Начать классификацию";
            this.btnStartClassification.UseVisualStyleBackColor = true;
            this.btnStartClassification.Click += new System.EventHandler(this.btnStartClassification_Click);
            // 
            // btnExit
            // 
            this.btnExit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnExit.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Location = new System.Drawing.Point(17, 610);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(298, 44);
            this.btnExit.TabIndex = 3;
            this.btnExit.Text = "Выход";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnGenerateObjects
            // 
            this.btnGenerateObjects.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnGenerateObjects.Location = new System.Drawing.Point(12, 120);
            this.btnGenerateObjects.Name = "btnGenerateObjects";
            this.btnGenerateObjects.Size = new System.Drawing.Size(298, 44);
            this.btnGenerateObjects.TabIndex = 2;
            this.btnGenerateObjects.Text = "Сгенерировать объекты";
            this.btnGenerateObjects.UseVisualStyleBackColor = true;
            this.btnGenerateObjects.Click += new System.EventHandler(this.btnGenerateObjects_Click);
            // 
            // lClassPresenterCount
            // 
            this.lClassPresenterCount.AutoSize = true;
            this.lClassPresenterCount.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lClassPresenterCount.ForeColor = System.Drawing.SystemColors.Control;
            this.lClassPresenterCount.Location = new System.Drawing.Point(8, 20);
            this.lClassPresenterCount.MaximumSize = new System.Drawing.Size(350, 0);
            this.lClassPresenterCount.Name = "lClassPresenterCount";
            this.lClassPresenterCount.Size = new System.Drawing.Size(298, 56);
            this.lClassPresenterCount.TabIndex = 1;
            this.lClassPresenterCount.Text = "Количество представителей каждого класса:";
            // 
            // udClassPresenterCount
            // 
            this.udClassPresenterCount.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.udClassPresenterCount.Location = new System.Drawing.Point(12, 79);
            this.udClassPresenterCount.Maximum = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.udClassPresenterCount.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.udClassPresenterCount.Name = "udClassPresenterCount";
            this.udClassPresenterCount.Size = new System.Drawing.Size(298, 34);
            this.udClassPresenterCount.TabIndex = 0;
            this.udClassPresenterCount.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // pContent
            // 
            this.pContent.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pContent.Location = new System.Drawing.Point(334, 0);
            this.pContent.Name = "pContent";
            this.pContent.Size = new System.Drawing.Size(1016, 666);
            this.pContent.TabIndex = 1;
            this.pContent.Paint += new System.Windows.Forms.PaintEventHandler(this.pContent_Paint);
            // 
            // fMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1350, 666);
            this.Controls.Add(this.pContent);
            this.Controls.Add(this.pSide);
            this.Name = "fMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Лабораторная работа 5, Наривончик Александр, 351004";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.pSide.ResumeLayout(false);
            this.pSide.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.udClassPresenterCount)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pSide;
        private System.Windows.Forms.Label lClassPresenterCount;
        private System.Windows.Forms.NumericUpDown udClassPresenterCount;
        private System.Windows.Forms.Button btnGenerateObjects;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnStartClassification;
        private System.Windows.Forms.Panel pContent;
    }
}

