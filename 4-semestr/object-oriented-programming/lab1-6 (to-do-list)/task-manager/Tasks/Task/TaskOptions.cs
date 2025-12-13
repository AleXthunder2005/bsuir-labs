using System.Linq;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public abstract class TaskOptions
    {
        protected fTaskCreator _taskCreator;

        //task
        private string _title = "New task";
        private string _description = "-";
        private bool _isCompleted = false;

        // properties
        public string Title
        {
            get { return _title; }
            set { _title = value; }
        }

        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }

        public bool IsCompleted
        {
            get { return _isCompleted; }
            set { _isCompleted = value; }
        }

        //constructors
        public TaskOptions() { }
        public TaskOptions(fTaskCreator taskCreator) 
        {
            _taskCreator = taskCreator;
        }


        public virtual TaskOptions Build()
        {
            // Проверяем, существует ли форма _taskCreator
            if (_taskCreator != null)
            {
                if (_taskCreator.Controls.Find("tbTitle", true).FirstOrDefault() is TextBox tbTitle) { _title = tbTitle.Text; }
                if (_taskCreator.Controls.Find("tbDescription", true).FirstOrDefault() is TextBox tbDescription) { _description = tbDescription.Text; }
            }

            return this;
        }
    }
}
