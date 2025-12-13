using System;
using System.Linq;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class ProgressTaskCreatorInitializer : SimpleTaskCreatorInitializer
    {
        public ProgressTaskCreatorInitializer(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void InitializeCreator(Task editingTask)
        {
            // Сначала заполняем базовые поля SimpleTask
            base.InitializeCreator(editingTask);

            var progressTask = editingTask as ProgressTask;
            if (progressTask == null) return;

            // Заполняем NumericUpDown количества целей
            var udGoalCount = _taskCreator.Controls.Find("udGoalCount", true).FirstOrDefault() as NumericUpDown;
            if (udGoalCount != null)
            {
                udGoalCount.Value = progressTask.GoalCount;
            }
        }
    }
}