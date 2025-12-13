using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using task_manager.Tasks;
using static task_manager.Settings;

namespace task_manager
{
    public partial class fTaskCreator: Form
    {
        private const string EMPTY_STRING = "";
        
        private string _selectedClassName = EMPTY_STRING;
        public Task _createdTask;
        public Type _createdTaskType;

        private Factory _factory;


        private Task _editingTask;
        public Task EditingTask { get { return _editingTask; } }

        //controllers
        public fTaskCreator(List<Type> taskTypes)
        {
            InitializeComponent();
            InitializeUserComponent();
            _factory = new Factory(mTaskManager.LoadedAssemblies, this);
        }

        public fTaskCreator(List<Type> taskTypes, Task editingTask) : this(taskTypes)
        {
            _editingTask = editingTask;
            InitializeEditMode();
        }


        //model
        private void InitializeEditMode() {
            cbTaskType.Text = (string)_editingTask.GetType().GetField("taskTypeName").GetValue(null);
            tbTitle.Text = _editingTask.Title;
            tbDescription.Text = _editingTask.Description;

            string className = _editingTask.GetType().Name;

            var taskEditor = _factory.CreateTaskCreatorInitializer(className);
            taskEditor.InitializeCreator(_editingTask);

        }

        private void InitializeUserComponent() 
        {
            foreach (var type in mTaskManager.TaskTypes)
            {
                this.cbTaskType.Items.Add((string)type.GetField("taskTypeName").GetValue(null));
            }
        }
        private void CloseTaskCreator()
        {
            this.Clear();
            this.Close();
        }

        private string GetSelectedClassName() 
        {
            string className = "";
            foreach (var type in mTaskManager.TaskTypes)
            {
                if (cbTaskType.Text == (string)type.GetField("taskTypeName").GetValue(null))
                {
                    className = type.Name;
                    return className;
                }
            }
            return null;
        }

        private Type GetSelectedClass()
        {
            foreach (var type in mTaskManager.TaskTypes)
            {
                if (cbTaskType.Text == (string)type.GetField("taskTypeName").GetValue(null))
                {
                    return type;
                }
            }
            return null;
        }

        private bool IsFormCorrect(out string message) 
        {
            if (cbTaskType.Text == EMPTY_STRING) { message = "Task was not selected!"; return false; } //ничего не выбрал - бан
            if (tbTitle.Text == EMPTY_STRING) { message = "Task name can't be empty!"; return false; } //пустое заглавие - бан


            if ((Controls.Find("dtpStartDate", true).FirstOrDefault() is DateTimePicker dtpStartDate) &&        //дедлайн раньше старта кринж
               (Controls.Find("dtpDeadlineDate", true).FirstOrDefault() is DateTimePicker dtpDeadlineDate))
             {
                if (dtpDeadlineDate.Value.CompareTo(dtpStartDate.Value) < 0) 
                {
                    message = "Deadline must be later, than start date!";
                    return false;
                }

                if (dtpStartDate.Value.Date.CompareTo(DateTime.Now.Date) < 0)     //Время старта раньше, чем сейчас
                {
                    message = "Start time must be later, than now!";
                    return false;
                }
            }
            
            if (Controls.Find("dtpSheduledTime", true).FirstOrDefault() is DateTimePicker dtpSheduledTime) //запланированное время меньше, чем сейчас
            {
                if (dtpSheduledTime.Value.Date.CompareTo(DateTime.Now.Date) < 0)
                {
                    message = "Sheduled time must be later, than now!";
                    return false;
                }

            }
            if (Controls.Find("cbInterval", true).FirstOrDefault() is ComboBox cbInterval)  //некорректное количество часов
            {
                if (!double.TryParse(cbInterval.Text, out double interval))
                {
                    message = "Enter correct interval hours count!";
                    return false;
                }
            }

            message = "Is correct!";
            return true;    
        }

        //view
        private void Clear()
        {
            tbTitle.Text = EMPTY_STRING;
            tbDescription.Text = EMPTY_STRING;
        }


        //controllers
        private void btnClear_Click(object sender, EventArgs e)
        {
            this.Clear();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.CloseTaskCreator();
            DialogResult = DialogResult.Cancel;
        }

        private void btnConfirm_Click(object sender, EventArgs e)
        {
            string message;
            if (!IsFormCorrect(out message))
            {
                MessageBox.Show(message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return; //бан
            }

            string className = GetSelectedClassName();
            _createdTask = _factory.CreateTask(className);

            this.DialogResult = DialogResult.OK;
            this.CloseTaskCreator();
        }

        private void cbTaskType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_selectedClassName != "")
            {
                var oldTaskCreatorBuilder = _factory.CreateTaskCreatorBuilder(_selectedClassName);
                oldTaskCreatorBuilder.ClearTaskCreator();
            }

            _selectedClassName = GetSelectedClassName();
            var selectedTaskCreatorBuilder = _factory.CreateTaskCreatorBuilder(_selectedClassName);
            selectedTaskCreatorBuilder.BuildTaskCreator();

            tbTitle.Text = $"New {cbTaskType.Text}";
            tbDescription.Text = $"I need to do ...";
        }
    }


}
