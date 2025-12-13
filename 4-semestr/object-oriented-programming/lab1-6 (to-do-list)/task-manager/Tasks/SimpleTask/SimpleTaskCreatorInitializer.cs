using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class SimpleTaskCreatorInitializer : TaskCreatorInitializer
    {
        public SimpleTaskCreatorInitializer(fTaskCreator taskCreator) : base(taskCreator) { }

        public override void InitializeCreator(Task editingTask)
        {
            base.InitializeCreator(editingTask);

            var simpleTask = editingTask as SimpleTask;
            if (simpleTask == null) return;

            var dtpStartDate = _taskCreator.Controls.Find("dtpStartDate", true).FirstOrDefault() as DateTimePicker;
            var dtpDeadlineDate = _taskCreator.Controls.Find("dtpDeadlineDate", true).FirstOrDefault() as DateTimePicker;

            if (dtpStartDate != null) dtpStartDate.Value = simpleTask.StartDate;
            if (dtpDeadlineDate != null) dtpDeadlineDate.Value = simpleTask.DeadlineDate;
        }
    }
}
