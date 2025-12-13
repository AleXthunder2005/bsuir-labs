using System;
using System.Linq;
using System.Windows.Forms;
using static task_manager.Tasks.PriorityTask;

namespace task_manager.Tasks
{
    public class PriorityTaskOptions : SimpleTaskOptions
    {
        // priority_task
        private t_priority _priority = t_priority.Low;

        public t_priority Priority
        {
            get { return _priority; }
            set { _priority = value; }
        }

        public PriorityTaskOptions() : base() { }
        public PriorityTaskOptions(fTaskCreator taskCreator) : base(taskCreator)
        {

        }


        public override TaskOptions Build()
        {
            PriorityTaskOptions options = (PriorityTaskOptions)base.Build();

            if (_taskCreator != null)
            {
                if (_taskCreator.Controls.Find("cbPriority", true).FirstOrDefault() is ComboBox cbPriority)
                {
                    if (cbPriority.SelectedItem != null && Enum.TryParse(cbPriority.SelectedItem.ToString(), out t_priority priority))
                    {
                        options._priority = priority;
                    }
                }
            }

            return options;
        }
    }
}
