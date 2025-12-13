namespace miapr7
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
            this.btnExit = new System.Windows.Forms.Button();
            this.btnClean = new System.Windows.Forms.Button();
            this.btnRecognize = new System.Windows.Forms.Button();
            this.pContent = new System.Windows.Forms.Panel();
            this.pSide.SuspendLayout();
            this.SuspendLayout();
            // 
            // pSide
            // 
            this.pSide.BackColor = System.Drawing.SystemColors.Highlight;
            this.pSide.Controls.Add(this.btnExit);
            this.pSide.Controls.Add(this.btnClean);
            this.pSide.Controls.Add(this.btnRecognize);
            this.pSide.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSide.Location = new System.Drawing.Point(0, 0);
            this.pSide.Name = "pSide";
            this.pSide.Size = new System.Drawing.Size(290, 586);
            this.pSide.TabIndex = 0;
            // 
            // btnExit
            // 
            this.btnExit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnExit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnExit.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Location = new System.Drawing.Point(12, 538);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(262, 36);
            this.btnExit.TabIndex = 3;
            this.btnExit.Text = "Выход";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnClean
            // 
            this.btnClean.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnClean.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClean.Location = new System.Drawing.Point(12, 54);
            this.btnClean.Name = "btnClean";
            this.btnClean.Size = new System.Drawing.Size(262, 36);
            this.btnClean.TabIndex = 2;
            this.btnClean.Text = "Очистить";
            this.btnClean.UseVisualStyleBackColor = true;
            this.btnClean.Click += new System.EventHandler(this.btnClean_Click);
            // 
            // btnRecognize
            // 
            this.btnRecognize.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnRecognize.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnRecognize.Location = new System.Drawing.Point(12, 12);
            this.btnRecognize.Name = "btnRecognize";
            this.btnRecognize.Size = new System.Drawing.Size(262, 36);
            this.btnRecognize.TabIndex = 1;
            this.btnRecognize.Text = "Распознать";
            this.btnRecognize.UseVisualStyleBackColor = true;
            this.btnRecognize.Click += new System.EventHandler(this.btnRecognize_Click);
            // 
            // pContent
            // 
            this.pContent.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pContent.Location = new System.Drawing.Point(290, 0);
            this.pContent.Name = "pContent";
            this.pContent.Size = new System.Drawing.Size(951, 586);
            this.pContent.TabIndex = 1;
            this.pContent.MouseClick += new System.Windows.Forms.MouseEventHandler(this.pContent_MouseClick);
            // 
            // fMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1241, 586);
            this.Controls.Add(this.pContent);
            this.Controls.Add(this.pSide);
            this.Name = "fMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Лабораторная работа 7, 351004, Наривончик Александр";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.pSide.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pSide;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnClean;
        private System.Windows.Forms.Button btnRecognize;
        private System.Windows.Forms.Panel pContent;
    }
}

