using System.Linq;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class AssigneeTaskOptions : SimpleTaskOptions
    {
        private string _assignee;

        public string Assignee
        {
            get { return _assignee; }
            set { _assignee = value; }
        }

        public AssigneeTaskOptions() : base() { }
        public AssigneeTaskOptions(fTaskCreator taskCreator) : base(taskCreator)
        {

        }

        public override TaskOptions Build()
        {
            AssigneeTaskOptions options = (AssigneeTaskOptions)base.Build();
            if (_taskCreator != null)
            {
                if (_taskCreator.Controls.Find("tbAssignee", true).FirstOrDefault() is TextBox tbAssignee) { options._assignee = tbAssignee.Text; }
            }
            return options;
        }
    }
}
