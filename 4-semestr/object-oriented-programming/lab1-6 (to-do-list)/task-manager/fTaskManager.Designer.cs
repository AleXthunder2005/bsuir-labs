namespace task_manager
{
    partial class fTaskManager
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
            this.btnExit = new System.Windows.Forms.Button();
            this.btnAddTask = new System.Windows.Forms.Button();
            this.pTop = new System.Windows.Forms.Panel();
            this.lTitile = new System.Windows.Forms.Label();
            this.pMainContent = new System.Windows.Forms.Panel();
            this.msMenu = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.miSaveAsJSON = new System.Windows.Forms.ToolStripMenuItem();
            this.miSaveAsBinaryFile = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.miOpenJSON = new System.Windows.Forms.ToolStripMenuItem();
            this.miOpenBinaryFile = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem2 = new System.Windows.Forms.ToolStripSeparator();
            this.miExit = new System.Windows.Forms.ToolStripMenuItem();
            this.settingsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.miChecksumSavingEnable = new System.Windows.Forms.ToolStripMenuItem();
            this.miChecksumSavingDisable = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem3 = new System.Windows.Forms.ToolStripSeparator();
            this.miLoadTask = new System.Windows.Forms.ToolStripMenuItem();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.pSideMenu.SuspendLayout();
            this.pTop.SuspendLayout();
            this.msMenu.SuspendLayout();
            this.SuspendLayout();
            // 
            // pSideMenu
            // 
            this.pSideMenu.BackColor = System.Drawing.Color.SlateGray;
            this.pSideMenu.Controls.Add(this.btnExit);
            this.pSideMenu.Controls.Add(this.btnAddTask);
            this.pSideMenu.Dock = System.Windows.Forms.DockStyle.Left;
            this.pSideMenu.Location = new System.Drawing.Point(0, 28);
            this.pSideMenu.Name = "pSideMenu";
            this.pSideMenu.Size = new System.Drawing.Size(220, 741);
            this.pSideMenu.TabIndex = 0;
            // 
            // btnExit
            // 
            this.btnExit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnExit.BackColor = System.Drawing.Color.White;
            this.btnExit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnExit.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Location = new System.Drawing.Point(12, 689);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(199, 40);
            this.btnExit.TabIndex = 3;
            this.btnExit.Text = "Exit";
            this.btnExit.UseVisualStyleBackColor = false;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnAddTask
            // 
            this.btnAddTask.BackColor = System.Drawing.Color.White;
            this.btnAddTask.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnAddTask.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnAddTask.Location = new System.Drawing.Point(12, 59);
            this.btnAddTask.Name = "btnAddTask";
            this.btnAddTask.Size = new System.Drawing.Size(199, 40);
            this.btnAddTask.TabIndex = 1;
            this.btnAddTask.Text = "Add task";
            this.btnAddTask.UseVisualStyleBackColor = false;
            this.btnAddTask.Click += new System.EventHandler(this.btnAddTask_Click);
            // 
            // pTop
            // 
            this.pTop.BackColor = System.Drawing.Color.SlateGray;
            this.pTop.Controls.Add(this.lTitile);
            this.pTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.pTop.Location = new System.Drawing.Point(220, 28);
            this.pTop.Name = "pTop";
            this.pTop.Size = new System.Drawing.Size(1023, 59);
            this.pTop.TabIndex = 1;
            // 
            // lTitile
            // 
            this.lTitile.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lTitile.Font = new System.Drawing.Font("MS PGothic", 25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lTitile.ForeColor = System.Drawing.SystemColors.Control;
            this.lTitile.Location = new System.Drawing.Point(6, 9);
            this.lTitile.Name = "lTitile";
            this.lTitile.Size = new System.Drawing.Size(1014, 47);
            this.lTitile.TabIndex = 0;
            this.lTitile.Text = "Task list";
            this.lTitile.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // pMainContent
            // 
            this.pMainContent.AutoScroll = true;
            this.pMainContent.BackColor = System.Drawing.SystemColors.ScrollBar;
            this.pMainContent.Cursor = System.Windows.Forms.Cursors.Default;
            this.pMainContent.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pMainContent.Location = new System.Drawing.Point(220, 87);
            this.pMainContent.Name = "pMainContent";
            this.pMainContent.Size = new System.Drawing.Size(1023, 682);
            this.pMainContent.TabIndex = 2;
            this.pMainContent.MouseDown += new System.Windows.Forms.MouseEventHandler(this.pMainContent_MouseDown);
            this.pMainContent.MouseLeave += new System.EventHandler(this.pMainContent_MouseLeave);
            this.pMainContent.MouseMove += new System.Windows.Forms.MouseEventHandler(this.pMainContent_MouseMove);
            // 
            // msMenu
            // 
            this.msMenu.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.msMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.settingsToolStripMenuItem});
            this.msMenu.Location = new System.Drawing.Point(0, 0);
            this.msMenu.Name = "msMenu";
            this.msMenu.Size = new System.Drawing.Size(1243, 28);
            this.msMenu.TabIndex = 3;
            this.msMenu.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.miSaveAsJSON,
            this.miSaveAsBinaryFile,
            this.toolStripMenuItem1,
            this.miOpenJSON,
            this.miOpenBinaryFile,
            this.toolStripMenuItem2,
            this.miExit});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(46, 24);
            this.fileToolStripMenuItem.Text = "File";
            // 
            // miSaveAsJSON
            // 
            this.miSaveAsJSON.Name = "miSaveAsJSON";
            this.miSaveAsJSON.Size = new System.Drawing.Size(211, 26);
            this.miSaveAsJSON.Text = "Save as JSON";
            this.miSaveAsJSON.Click += new System.EventHandler(this.miSaveAsJSON_Click);
            // 
            // miSaveAsBinaryFile
            // 
            this.miSaveAsBinaryFile.Name = "miSaveAsBinaryFile";
            this.miSaveAsBinaryFile.Size = new System.Drawing.Size(211, 26);
            this.miSaveAsBinaryFile.Text = "Save as Binary file";
            this.miSaveAsBinaryFile.Click += new System.EventHandler(this.miSaveAsBinaryFile_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(208, 6);
            // 
            // miOpenJSON
            // 
            this.miOpenJSON.Name = "miOpenJSON";
            this.miOpenJSON.Size = new System.Drawing.Size(211, 26);
            this.miOpenJSON.Text = "Open JSON";
            this.miOpenJSON.Click += new System.EventHandler(this.miOpenJSON_Click);
            // 
            // miOpenBinaryFile
            // 
            this.miOpenBinaryFile.Name = "miOpenBinaryFile";
            this.miOpenBinaryFile.Size = new System.Drawing.Size(211, 26);
            this.miOpenBinaryFile.Text = "Open Binary file";
            this.miOpenBinaryFile.Click += new System.EventHandler(this.miOpenBinaryFile_Click);
            // 
            // toolStripMenuItem2
            // 
            this.toolStripMenuItem2.Name = "toolStripMenuItem2";
            this.toolStripMenuItem2.Size = new System.Drawing.Size(208, 6);
            // 
            // miExit
            // 
            this.miExit.Name = "miExit";
            this.miExit.Size = new System.Drawing.Size(211, 26);
            this.miExit.Text = "Exit";
            this.miExit.Click += new System.EventHandler(this.miExit_Click);
            // 
            // settingsToolStripMenuItem
            // 
            this.settingsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.miChecksumSavingEnable,
            this.miChecksumSavingDisable,
            this.toolStripMenuItem3,
            this.miLoadTask});
            this.settingsToolStripMenuItem.Name = "settingsToolStripMenuItem";
            this.settingsToolStripMenuItem.Size = new System.Drawing.Size(76, 24);
            this.settingsToolStripMenuItem.Text = "Settings";
            // 
            // miChecksumSavingEnable
            // 
            this.miChecksumSavingEnable.Name = "miChecksumSavingEnable";
            this.miChecksumSavingEnable.Size = new System.Drawing.Size(256, 26);
            this.miChecksumSavingEnable.Text = "Checksum saving enable";
            this.miChecksumSavingEnable.Click += new System.EventHandler(this.miChecksumSavingEnable_Click);
            // 
            // miChecksumSavingDisable
            // 
            this.miChecksumSavingDisable.Enabled = false;
            this.miChecksumSavingDisable.Name = "miChecksumSavingDisable";
            this.miChecksumSavingDisable.Size = new System.Drawing.Size(256, 26);
            this.miChecksumSavingDisable.Text = "Checksum saving disable";
            this.miChecksumSavingDisable.Click += new System.EventHandler(this.miChecksumSavingDisable_Click);
            // 
            // toolStripMenuItem3
            // 
            this.toolStripMenuItem3.Name = "toolStripMenuItem3";
            this.toolStripMenuItem3.Size = new System.Drawing.Size(253, 6);
            // 
            // miLoadTask
            // 
            this.miLoadTask.Name = "miLoadTask";
            this.miLoadTask.Size = new System.Drawing.Size(256, 26);
            this.miLoadTask.Text = "Load task (*.dll)";
            this.miLoadTask.Click += new System.EventHandler(this.miLoadTask_Click);
            // 
            // saveFileDialog
            // 
            this.saveFileDialog.DefaultExt = "json";
            this.saveFileDialog.FileName = "save";
            this.saveFileDialog.Filter = "JSON files (*.json)|*.json|Binary files (*.bin)|*.bin";
            // 
            // openFileDialog
            // 
            this.openFileDialog.DefaultExt = "json";
            this.openFileDialog.FileName = "save";
            this.openFileDialog.Filter = "JSON files (*.json)|*.json|Binary files (*.bin)|*.bin|Task type (*.dll)|*.dll";
            // 
            // fTaskManager
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1243, 769);
            this.Controls.Add(this.pMainContent);
            this.Controls.Add(this.pTop);
            this.Controls.Add(this.pSideMenu);
            this.Controls.Add(this.msMenu);
            this.DoubleBuffered = true;
            this.MainMenuStrip = this.msMenu;
            this.Name = "fTaskManager";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Task Manager";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Resize += new System.EventHandler(this.fTaskManager_Resize);
            this.pSideMenu.ResumeLayout(false);
            this.pTop.ResumeLayout(false);
            this.msMenu.ResumeLayout(false);
            this.msMenu.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel pSideMenu;
        private System.Windows.Forms.Panel pTop;
        private System.Windows.Forms.Label lTitile;
        private System.Windows.Forms.Panel pMainContent;
        private System.Windows.Forms.Button btnAddTask;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.MenuStrip msMenu;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem miSaveAsJSON;
        private System.Windows.Forms.ToolStripMenuItem miSaveAsBinaryFile;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem miOpenJSON;
        private System.Windows.Forms.ToolStripMenuItem miOpenBinaryFile;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem2;
        private System.Windows.Forms.ToolStripMenuItem miExit;
        private System.Windows.Forms.SaveFileDialog saveFileDialog;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.ToolStripMenuItem settingsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem miChecksumSavingEnable;
        private System.Windows.Forms.ToolStripMenuItem miChecksumSavingDisable;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem3;
        private System.Windows.Forms.ToolStripMenuItem miLoadTask;
    }
}

