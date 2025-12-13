using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class SimpleTaskCreatorBuilder : TaskCreatorBuilder
    {
        public SimpleTaskCreatorBuilder(fTaskCreator taskCreator): base(taskCreator) { }

        public override void BuildTaskCreator()
        {
            // Создаем и настраиваем DateTimePicker для начальной даты
            DateTimePicker dtpStartDate = new DateTimePicker();
            dtpStartDate.Location = new System.Drawing.Point(189, 252);
            dtpStartDate.Name = "dtpStartDate";
            dtpStartDate.Size = new System.Drawing.Size(362, 22);
            dtpStartDate.TabIndex = 10;
            dtpStartDate.Font = DefaultFont; // Устанавливаем шрифт
            _taskCreator.Controls.Add(dtpStartDate);

            // Создаем и настраиваем DateTimePicker для даты дедлайна
            DateTimePicker dtpDeadlineDate = new DateTimePicker();
            dtpDeadlineDate.Location = new System.Drawing.Point(189, 280);
            dtpDeadlineDate.Name = "dtpDeadlineDate";
            dtpDeadlineDate.Size = new System.Drawing.Size(362, 22);
            dtpDeadlineDate.TabIndex = 11;
            dtpDeadlineDate.Font = DefaultFont; // Устанавливаем шрифт
            _taskCreator.Controls.Add(dtpDeadlineDate);

            // Создаем и настраиваем Label для начальной даты
            Label lStartDate = new Label();
            lStartDate.AutoSize = true;
            lStartDate.Font = BoldDefaultFont; // Устанавливаем жирный шрифт
            lStartDate.Location = new System.Drawing.Point(52, 254);
            lStartDate.Name = "lStartDate";
            lStartDate.Size = new System.Drawing.Size(92, 20);
            lStartDate.TabIndex = 12;
            lStartDate.Text = "Start date";
            _taskCreator.Controls.Add(lStartDate);

            // Создаем и настраиваем Label для даты дедлайна
            Label lDeadlineDate = new Label();
            lDeadlineDate.AutoSize = true;
            lDeadlineDate.Font = BoldDefaultFont; // Устанавливаем жирный шрифт
            lDeadlineDate.Location = new System.Drawing.Point(52, 282);
            lDeadlineDate.Name = "lDeadlineDate";
            lDeadlineDate.Size = new System.Drawing.Size(115, 20);
            lDeadlineDate.TabIndex = 13;
            lDeadlineDate.Text = "Deadline date";
            _taskCreator.Controls.Add(lDeadlineDate);
        }

        public override void ClearTaskCreator()
        {
            // Удаляем компоненты, связанные с SimpleTaskCreator
            RemoveControlByName("dtpStartDate");
            RemoveControlByName("dtpDeadlineDate");
            RemoveControlByName("lStartDate");
            RemoveControlByName("lDeadlineDate");
        }

    }
}
