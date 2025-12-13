using System;
using System.Drawing;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class ProgressTaskCreatorBuilder : SimpleTaskCreatorBuilder
    {
        public ProgressTaskCreatorBuilder(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void BuildTaskCreator()
        {
            // Сначала строим базовые элементы SimpleTask
            base.BuildTaskCreator();

            // Создаем и настраиваем Label для количества целей
            Label lGoalCount = new Label
            {
                AutoSize = true,
                Font = BoldDefaultFont,
                Location = new Point(52, 340),
                Name = "lGoalCount",
                Size = new Size(100, 20),
                TabIndex = 14,
                Text = "Goal count"
            };
            _taskCreator.Controls.Add(lGoalCount);

            // Создаем и настраиваем NumericUpDown для ввода целей
            NumericUpDown udGoalCount = new NumericUpDown
            {
                Location = new Point(189, 340),
                Maximum = 99999,
                Minimum = 1,
                Name = "udGoalCount",
                Size = new Size(362, 22),
                TabIndex = 15,
                Font = DefaultFont
            };
            _taskCreator.Controls.Add(udGoalCount);
        }

        public override void ClearTaskCreator()
        {
            // Удаляем специфичные элементы ProgressTask
            RemoveControlByName("lGoalCount");
            RemoveControlByName("udGoalCount");

            // Затем удаляем базовые элементы SimpleTask
            base.ClearTaskCreator();
        }
    }
}