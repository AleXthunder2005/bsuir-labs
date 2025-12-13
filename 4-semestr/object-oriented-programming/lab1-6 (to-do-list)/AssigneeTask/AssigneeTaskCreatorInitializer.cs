using System;
using System.Linq;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class AssigneeTaskCreatorInitializer : SimpleTaskCreatorInitializer
    {
        public AssigneeTaskCreatorInitializer(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void InitializeCreator(Task editingTask)
        {
            // Сначала заполняем базовые поля SimpleTask
            base.InitializeCreator(editingTask);

            var assigneeTask = editingTask as AssigneeTask;
            if (assigneeTask == null) return;

            // Заполняем TextBox исполнителя
            var tbAssignee = _taskCreator.Controls.Find("tbAssignee", true).FirstOrDefault() as TextBox;
            if (tbAssignee != null)
            {
                tbAssignee.Text = assigneeTask.Assignee;
            }
        }
    }
}