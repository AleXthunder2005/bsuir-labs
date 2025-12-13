using System;
using System.Drawing;
using System.Windows.Forms;
using static task_manager.Settings;
using static task_manager.mTaskManager;
using System.IO;
using task_manager.Tasks;

namespace task_manager
{
    public partial class fTaskManager: Form
    {
        private readonly CommandManager _commandManager = new CommandManager();

        public fTaskManager()
        {
            InitializeComponent();
            mTaskManager.Initialize();
            InitializeUserComponent();
            this.pMainContent.Paint += new PaintEventHandler(MainFormPaint);
        }

        //view
        private void MainFormPaint(object sender, PaintEventArgs e)
        {
            int y = TASK_MARGIN;
            int scrollOffset = pMainContent.AutoScrollPosition.Y;

            foreach (Task currTask in mTaskManager.Tasks)
            {
                currTask.Options.Y = y + scrollOffset;
                currTask.Options.X = currTask.Options.Margin;
                currTask.Options.Width = Settings.TaskWidthSetting;
                currTask.Options.Height = Settings.TaskHeightSetting;

                currTask.Draw(e.Graphics, currTask.Options);
                y += currTask.Options.Height + currTask.Options.Margin;
            }
        }

        //model
        private void ShowTaskCreator() {
            fTaskCreator taskCreator = new fTaskCreator(mTaskManager.TaskTypes);
            if (taskCreator.ShowDialog() == DialogResult.OK)
            {
                var command = new AddTaskCommand(taskCreator._createdTask);
                _commandManager.ExecuteCommand(command);
                UpdateAutoScrollMinSize();
                pMainContent.Invalidate();
            }
        }
        private void CloseApplication() {
            this.Close();
        }

        private void InitializeUserComponent()
        {
            Settings.TaskWidthSetting = this.ClientSize.Width - this.pSideMenu.Width - 2 * TASK_MARGIN - SCROLLBAR_WIDTH;
        }
        private void UpdateAutoScrollMinSize()
        {
            int y = TASK_MARGIN;

            foreach (Task currTask in mTaskManager.Tasks)
            {
                y += currTask.Options.Height + currTask.Options.Margin;
            }
            pMainContent.AutoScrollMinSize = new System.Drawing.Size(0, y);
        }


        //controllers
        private void btnAddTask_Click(object sender, EventArgs e)
        {
            this.ShowTaskCreator();
        }
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.CloseApplication();
        }

        private void fTaskManager_Resize(object sender, EventArgs e)
        {
            Settings.TaskWidthSetting = this.ClientSize.Width - this.pSideMenu.Width - 2 * TASK_MARGIN - SCROLLBAR_WIDTH;
            pMainContent.Invalidate();
        }

        private void pMainContent_MouseMove(object sender, MouseEventArgs e)
        {
            int y = e.Y - pMainContent.AutoScrollPosition.Y;
            int newSelectedTaskIndex = y / (TaskHeightSetting + TASK_MARGIN);

            if (newSelectedTaskIndex >= 0 && newSelectedTaskIndex < mTaskManager.Tasks.Count)
            {
                if (SelectedTaskIndex != newSelectedTaskIndex)
                {
                    // Сбрасываем выделение только у старого элемента (если он был)
                    if (SelectedTaskIndex != RESETED_TASK_INDEX)
                    {
                        mTaskManager.Tasks[SelectedTaskIndex].Options.IsSelected = false;
                        InvalidateTaskRect(SelectedTaskIndex); 
                    }
                    mTaskManager.Tasks[newSelectedTaskIndex].Options.IsSelected = true;
                    SelectedTaskIndex = newSelectedTaskIndex;
                    InvalidateTaskRect(newSelectedTaskIndex); 
                }
            }
            else if (SelectedTaskIndex != RESETED_TASK_INDEX)
            {
                if (SelectedTaskIndex >= mTaskManager.Tasks.Count)
                {
                    for (int i = 0; i < mTaskManager.Tasks.Count; i++)
                        mTaskManager.Tasks[i].Options.IsSelected = false;
                    SelectedTaskIndex = RESETED_TASK_INDEX;
                }
                else
                {
                    mTaskManager.Tasks[SelectedTaskIndex].Options.IsSelected = false;
                    InvalidateTaskRect(SelectedTaskIndex);
                    SelectedTaskIndex = RESETED_TASK_INDEX;
                }
            }
        }

        // Перерисовывает только область конкретной задачи
        private void InvalidateTaskRect(int taskIndex)
        {
            int yPos = taskIndex * (TaskHeightSetting + TASK_MARGIN) + TASK_MARGIN + pMainContent.AutoScrollPosition.Y;
            pMainContent.Invalidate(new Rectangle(0, yPos, pMainContent.Width, TaskHeightSetting));
        }

        private void pMainContent_MouseLeave(object sender, EventArgs e)
        {
            if (SelectedTaskIndex != RESETED_TASK_INDEX)
            {
                mTaskManager.Tasks[SelectedTaskIndex].Options.IsSelected = false;
                InvalidateTaskRect(SelectedTaskIndex);
                SelectedTaskIndex = RESETED_TASK_INDEX;
            }
        }

        private void pMainContent_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                int y = e.Y - pMainContent.AutoScrollPosition.Y;
                int newSelectedTaskIndex = y / (TaskHeightSetting + TASK_MARGIN);

                if (newSelectedTaskIndex >= 0 && newSelectedTaskIndex < mTaskManager.Tasks.Count)
                {
                    SelectedTaskIndex = newSelectedTaskIndex;

                    ContextMenuStrip contextMenu = new ContextMenuStrip();
                    // Создаем пункт "Delete Task"
                    ToolStripMenuItem deleteItem = new ToolStripMenuItem("Delete Task");
                    deleteItem.Click += (s, args) => DeleteTask(newSelectedTaskIndex);

                    // Добавляем пункты в меню
                    contextMenu.Items.Add(deleteItem);

                    // Создаем пункт "Complete Task"
                    if (!mTaskManager.Tasks[newSelectedTaskIndex].IsCompleted)
                    {
                        // Создаем пункт "Edit Task"
                        ToolStripMenuItem editItem = new ToolStripMenuItem("Edit Task");
                        editItem.Click += (s, args) => EditTask(newSelectedTaskIndex);
                        contextMenu.Items.Add(editItem);

                        ToolStripMenuItem completeItem = new ToolStripMenuItem("Complete Task");
                        completeItem.Click += (s, args) => CompleteTask(newSelectedTaskIndex);
                        contextMenu.Items.Add(completeItem);
                    }

                    contextMenu.Show(pMainContent, e.Location);
                }
            }
        }

        private void DeleteTask(int index)
        {
            if (index >= 0 && index < mTaskManager.Tasks.Count)
            {
                var command = new DeleteTaskCommand(index);
                _commandManager.ExecuteCommand(command);
                UpdateAutoScrollMinSize();
                pMainContent.Invalidate();
            }
        }

        private void CompleteTask(int index)
        {
            if (index >= 0 && index < mTaskManager.Tasks.Count)
            {
                var command = new CompleteTaskCommand(index);
                _commandManager.ExecuteCommand(command);
                UpdateAutoScrollMinSize();
                pMainContent.Invalidate();
            }
        }

        private void EditTask(int index)
        {
            if (index >= 0 && index < mTaskManager.Tasks.Count)
            {
                if (SelectedTaskIndex != RESETED_TASK_INDEX) {
                    mTaskManager.Tasks[SelectedTaskIndex].Options.IsSelected = false;
                }

                var taskToEdit = mTaskManager.Tasks[index];
                fTaskCreator editForm = new fTaskCreator(mTaskManager.TaskTypes, taskToEdit);
                if (editForm.ShowDialog() == DialogResult.OK)
                {
                    var command = new EditTaskCommand(index, editForm._createdTask);
                    _commandManager.ExecuteCommand(command);
                    pMainContent.Invalidate();
                }
            }
        }

        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == (Keys.Control | Keys.Z))
            {
                bool canUndo = _commandManager.CanUndo();
                _commandManager.Undo();

                if (canUndo) 
                    pMainContent.Invalidate();
                return true;
            }
            else if (keyData == (Keys.Control | Keys.Y) || keyData == (Keys.Control | Keys.Alt | Keys.Z))
            {
                bool canRedo = _commandManager.CanRedo();
                _commandManager.Redo();
                
                if (canRedo)
                    pMainContent.Invalidate();
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }

        private void miExit_Click(object sender, EventArgs e)
        {
            CloseApplication();
        }

        private void miSaveAsJSON_Click(object sender, EventArgs e)
        {
            saveFileDialog.FilterIndex = 1;
            saveFileDialog.DefaultExt = "json";
            saveFileDialog.FileName = Settings.DEFAULT_FILE_NAME;
            if (saveFileDialog.ShowDialog() == DialogResult.OK) 
            {
                string json = JsonHandler.BuildJson(mTaskManager.Tasks, Settings.haveToSaveChecksum);
                if (json != null)
                {
                    try
                    {
                        File.WriteAllText(saveFileDialog.FileName, json);
                        MessageBox.Show("Succesful saving!", "Saving", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    catch (Exception ex) 
                    {
                        MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }

        private void miSaveAsBinaryFile_Click(object sender, EventArgs e)
        {
            saveFileDialog.FilterIndex = 2;
            saveFileDialog.DefaultExt = "bin";
            saveFileDialog.FileName = Settings.DEFAULT_FILE_NAME;
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                BinaryHandler.SerializeTasks(mTaskManager.Tasks, saveFileDialog.FileName, Settings.haveToSaveChecksum);
            }
        }

        private void miOpenJSON_Click(object sender, EventArgs e)
        {
            openFileDialog.FilterIndex = 1;
            openFileDialog.DefaultExt= "json";
            openFileDialog.FileName = Settings.DEFAULT_FILE_NAME;
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                string json = null;
                try
                {
                    json = File.ReadAllText(openFileDialog.FileName);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }

                if (json != null)
                {
                    TaskList<Task> tasks = JsonHandler.ReadJson(json, Settings.haveToSaveChecksum);
                    mTaskManager.Tasks = tasks;

                    UpdateAutoScrollMinSize();
                    pMainContent.Invalidate();
                }
            }
        }

        private void miOpenBinaryFile_Click(object sender, EventArgs e)
        {
            openFileDialog.FilterIndex = 2;
            openFileDialog.DefaultExt = "bin";
            openFileDialog.FileName = Settings.DEFAULT_FILE_NAME;

            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                TaskList<Task> tasks = BinaryHandler.DeserializeTasks(openFileDialog.FileName, Settings.haveToSaveChecksum);
                mTaskManager.Tasks = tasks;

                UpdateAutoScrollMinSize();
                pMainContent.Invalidate();
            }
        }

        private void miChecksumSavingEnable_Click(object sender, EventArgs e)
        {
            Settings.haveToSaveChecksum = true;

            miChecksumSavingEnable.Enabled = false;
            miChecksumSavingDisable.Enabled = true;
        }

        private void miChecksumSavingDisable_Click(object sender, EventArgs e)
        {
            Settings.haveToSaveChecksum = false;

            miChecksumSavingEnable.Enabled = true;
            miChecksumSavingDisable.Enabled = false;
        }

        private void miLoadTask_Click(object sender, EventArgs e)
        {
            openFileDialog.FilterIndex = 3;
            openFileDialog.DefaultExt = "dll";
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                mTaskManager.LoadAssembly(openFileDialog.FileName);
            }
        }
    }
}
