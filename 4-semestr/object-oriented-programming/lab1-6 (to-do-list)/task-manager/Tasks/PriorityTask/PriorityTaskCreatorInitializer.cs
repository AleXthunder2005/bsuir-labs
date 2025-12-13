using System;
using System.Linq;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class PriorityTaskCreatorInitializer : SimpleTaskCreatorInitializer
    {
        public PriorityTaskCreatorInitializer(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void InitializeCreator(Task editingTask)
        {
            // Сначала заполняем базовые поля SimpleTask
            base.InitializeCreator(editingTask);

            var priorityTask = editingTask as PriorityTask;
            if (priorityTask == null) return;

            // Заполняем ComboBox приоритета
            var cbPriority = _taskCreator.Controls.Find("cbPriority", true).FirstOrDefault() as ComboBox;
            if (cbPriority != null)
            {
                cbPriority.SelectedItem = priorityTask.Priority.ToString();
            }
        }
    }
}