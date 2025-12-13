using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class ReminderCreatorBuilder : TaskCreatorBuilder
    {

        public ReminderCreatorBuilder(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void BuildTaskCreator()
        {
            // Создаем и настраиваем DateTimePicker для запланированного времени
            DateTimePicker dtpSheduledTime = new DateTimePicker();
            dtpSheduledTime.Location = new System.Drawing.Point(189, 252);
            dtpSheduledTime.Name = "dtpSheduledTime";
            dtpSheduledTime.Size = new System.Drawing.Size(362, 22);
            dtpSheduledTime.TabIndex = 10;
            dtpSheduledTime.Font = DefaultFont; // Устанавливаем шрифт
            _taskCreator.Controls.Add(dtpSheduledTime);

            // Создаем и настраиваем Label для запланированного времени
            Label lStartDate = new Label();
            lStartDate.AutoSize = true;
            lStartDate.Font = BoldDefaultFont; // Устанавливаем жирный шрифт
            lStartDate.Location = new System.Drawing.Point(52, 254);
            lStartDate.Name = "lStartDate";
            lStartDate.Size = new System.Drawing.Size(128, 20);
            lStartDate.TabIndex = 12;
            lStartDate.Text = "Sheduled time";
            _taskCreator.Controls.Add(lStartDate);
        }

        public override void ClearTaskCreator()
        {
            // Удаляем компоненты, связанные с RemainderCreator
            RemoveControlByName("dtpSheduledTime");
            RemoveControlByName("lStartDate");
        }
    }
}
