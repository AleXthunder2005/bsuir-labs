using System;
using System.Linq;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class ReccuringSimpleTaskCreatorInitializer : SimpleTaskCreatorInitializer
    {
        public ReccuringSimpleTaskCreatorInitializer(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void InitializeCreator(Task editingTask)
        {
            // Сначала заполняем базовые поля SimpleTask
            base.InitializeCreator(editingTask);

            var recurringTask = editingTask as ReccuringSimpleTask;
            if (recurringTask == null) return;

            // Заполняем ComboBox интервала
            var cbInterval = _taskCreator.Controls.Find("cbInterval", true).FirstOrDefault() as ComboBox;
            if (cbInterval != null)
            {
                var intervalString = recurringTask.Interval.ToString();
                cbInterval.SelectedItem = intervalString;
            }
        }
    }
}