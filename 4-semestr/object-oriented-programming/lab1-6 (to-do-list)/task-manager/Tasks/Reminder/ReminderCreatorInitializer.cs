using System;
using System.Linq;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class ReminderCreatorInitializer : TaskCreatorInitializer
    {
        public ReminderCreatorInitializer(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void InitializeCreator(Task editingTask)
        {
            base.InitializeCreator(editingTask); // Заполняем базовые поля (title, description)

            var reminder = editingTask as Reminder;
            if (reminder == null) return;

            // Заполняем DateTimePicker для запланированного времени
            var dtpSheduledTime = _taskCreator.Controls.Find("dtpSheduledTime", true).FirstOrDefault() as DateTimePicker;
            if (dtpSheduledTime != null)
            {
                dtpSheduledTime.Value = reminder.SheduledTime;
            }
        }
    }
}