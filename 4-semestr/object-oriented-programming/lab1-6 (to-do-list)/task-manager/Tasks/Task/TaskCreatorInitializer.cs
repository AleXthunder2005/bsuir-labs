using System.Linq;
using System.Reflection;
using System.Windows.Forms;
using System;

namespace task_manager.Tasks
{
    public abstract class TaskCreatorInitializer
    {
        protected fTaskCreator _taskCreator;
        public TaskCreatorInitializer(fTaskCreator taskCreator) 
        { 
            _taskCreator = taskCreator;
        }

        public virtual void InitializeCreator(Task editingTask) 
        {
            var tbTitle = _taskCreator.Controls.Find("tbTitle", true).FirstOrDefault() as TextBox;
            var tbDescription = _taskCreator.Controls.Find("tbDescription", true).FirstOrDefault() as TextBox;

            if (tbTitle != null) tbTitle.Text = editingTask.Title;
            if (tbDescription != null) tbDescription.Text = editingTask.Description;
        }

    }
}