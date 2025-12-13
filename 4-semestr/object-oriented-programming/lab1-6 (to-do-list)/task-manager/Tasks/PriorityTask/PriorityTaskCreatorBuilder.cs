using System;
using System.Drawing;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class PriorityTaskCreatorBuilder : SimpleTaskCreatorBuilder
    {
        public PriorityTaskCreatorBuilder(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void BuildTaskCreator()
        {
            base.BuildTaskCreator();

            // Создаем и настраиваем ComboBox для приоритета
            ComboBox cbPriority = new ComboBox
            {
                FormattingEnabled = true,
                Location = new Point(189, 340),
                Name = "cbPriority",
                Size = new Size(362, 24),
                TabIndex = 13,
                DropDownStyle = ComboBoxStyle.DropDownList,
                Font = DefaultFont
            };

            cbPriority.Items.AddRange(new object[] { "Low", "Medium", "High" });
            cbPriority.SelectedIndex = 0;

            _taskCreator.Controls.Add(cbPriority);

            // Создаем и настраиваем Label для приоритета
            Label lPriority = new Label
            {
                AutoSize = true,
                Font = BoldDefaultFont,
                Location = new Point(52, 340),
                Name = "lPriority",
                Size = new Size(70, 20),  
                TabIndex = 14,
                Text = "Priority"
            };
            _taskCreator.Controls.Add(lPriority);
        }

        public override void ClearTaskCreator()
        {
            RemoveControlByName("cbPriority");
            RemoveControlByName("lPriority");

            base.ClearTaskCreator();
        }
    }
}