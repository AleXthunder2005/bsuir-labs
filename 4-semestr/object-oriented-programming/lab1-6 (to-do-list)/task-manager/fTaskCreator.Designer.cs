using System;
using System.Reflection;

namespace task_manager
{
    partial class fTaskCreator
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
            this.cbTaskType = new System.Windows.Forms.ComboBox();
            this.lTaskType = new System.Windows.Forms.Label();
            this.tbTitle = new System.Windows.Forms.TextBox();
            this.tbDescription = new System.Windows.Forms.TextBox();
            this.lTaskName = new System.Windows.Forms.Label();
            this.lDescription = new System.Windows.Forms.Label();
            this.lTitile = new System.Windows.Forms.Label();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnClear = new System.Windows.Forms.Button();
            this.btnConfirm = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // cbTaskType
            // 
            this.cbTaskType.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cbTaskType.BackColor = System.Drawing.SystemColors.Control;
            this.cbTaskType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbTaskType.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbTaskType.FormattingEnabled = true;
            this.cbTaskType.Location = new System.Drawing.Point(189, 60);
            this.cbTaskType.Name = "cbTaskType";
            this.cbTaskType.Size = new System.Drawing.Size(362, 28);
            this.cbTaskType.Sorted = true;
            this.cbTaskType.TabIndex = 0;
            this.cbTaskType.SelectedIndexChanged += new System.EventHandler(this.cbTaskType_SelectedIndexChanged);
            // 
            // lTaskType
            // 
            this.lTaskType.AutoSize = true;
            this.lTaskType.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lTaskType.Location = new System.Drawing.Point(52, 60);
            this.lTaskType.Name = "lTaskType";
            this.lTaskType.Size = new System.Drawing.Size(90, 20);
            this.lTaskType.TabIndex = 1;
            this.lTaskType.Text = "Task type";
            // 
            // tbTitle
            // 
            this.tbTitle.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbTitle.Location = new System.Drawing.Point(189, 106);
            this.tbTitle.Name = "tbTitle";
            this.tbTitle.Size = new System.Drawing.Size(362, 26);
            this.tbTitle.TabIndex = 2;
            // 
            // tbDescription
            // 
            this.tbDescription.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbDescription.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbDescription.Location = new System.Drawing.Point(189, 138);
            this.tbDescription.Multiline = true;
            this.tbDescription.Name = "tbDescription";
            this.tbDescription.Size = new System.Drawing.Size(362, 96);
            this.tbDescription.TabIndex = 3;
            // 
            // lTaskName
            // 
            this.lTaskName.AutoSize = true;
            this.lTaskName.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lTaskName.Location = new System.Drawing.Point(52, 106);
            this.lTaskName.Name = "lTaskName";
            this.lTaskName.Size = new System.Drawing.Size(100, 20);
            this.lTaskName.TabIndex = 4;
            this.lTaskName.Text = "Task name";
            // 
            // lDescription
            // 
            this.lDescription.AutoSize = true;
            this.lDescription.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lDescription.Location = new System.Drawing.Point(52, 138);
            this.lDescription.Name = "lDescription";
            this.lDescription.Size = new System.Drawing.Size(106, 20);
            this.lDescription.TabIndex = 5;
            this.lDescription.Text = "Description";
            // 
            // lTitile
            // 
            this.lTitile.AutoSize = true;
            this.lTitile.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lTitile.Location = new System.Drawing.Point(198, 9);
            this.lTitile.Name = "lTitile";
            this.lTitile.Size = new System.Drawing.Size(200, 29);
            this.lTitile.TabIndex = 6;
            this.lTitile.Text = "Create new task";
            // 
            // btnCancel
            // 
            this.btnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCancel.Location = new System.Drawing.Point(25, 528);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(133, 27);
            this.btnCancel.TabIndex = 7;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnClear
            // 
            this.btnClear.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnClear.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClear.Location = new System.Drawing.Point(164, 528);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(133, 27);
            this.btnClear.TabIndex = 8;
            this.btnClear.Text = "Clear";
            this.btnClear.UseVisualStyleBackColor = true;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // btnConfirm
            // 
            this.btnConfirm.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnConfirm.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnConfirm.Location = new System.Drawing.Point(470, 528);
            this.btnConfirm.Name = "btnConfirm";
            this.btnConfirm.Size = new System.Drawing.Size(133, 27);
            this.btnConfirm.TabIndex = 9;
            this.btnConfirm.Text = "Confirm";
            this.btnConfirm.UseVisualStyleBackColor = true;
            this.btnConfirm.Click += new System.EventHandler(this.btnConfirm_Click);
            // 
            // fTaskCreator
            // 
            this.AcceptButton = this.btnConfirm;
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.CancelButton = this.btnCancel;
            this.ClientSize = new System.Drawing.Size(615, 567);
            this.Controls.Add(this.btnConfirm);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.lTitile);
            this.Controls.Add(this.lDescription);
            this.Controls.Add(this.lTaskName);
            this.Controls.Add(this.tbDescription);
            this.Controls.Add(this.tbTitle);
            this.Controls.Add(this.lTaskType);
            this.Controls.Add(this.cbTaskType);
            this.Name = "fTaskCreator";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Task creator";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox cbTaskType;
        private System.Windows.Forms.Label lTaskType;
        private System.Windows.Forms.TextBox tbTitle;
        private System.Windows.Forms.TextBox tbDescription;
        private System.Windows.Forms.Label lTaskName;
        private System.Windows.Forms.Label lDescription;
        private System.Windows.Forms.Label lTitile;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnConfirm;
    }
}