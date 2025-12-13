using System;
using System.Drawing;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class ReccuringSimpleTaskCreatorBuilder : SimpleTaskCreatorBuilder
    {
        public ReccuringSimpleTaskCreatorBuilder(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void BuildTaskCreator()
        {
            base.BuildTaskCreator();

            ComboBox cbInterval = new ComboBox
            {
                FormattingEnabled = true,
                Items =
                {
                    "0.25", "0.5", "0.75", "1", "1.5", "2", "2.5", "3",
                    "4", "5", "6", "7", "8", "9", "10", "11", "12", "24"
                },
                Location = new Point(189, 340),
                Name = "cbInterval",
                Size = new Size(362, 24),
                TabIndex = 13,
                SelectedIndex = 3,
                Font = DefaultFont
            };
            _taskCreator.Controls.Add(cbInterval);

            Label lInterval = new Label
            {
                AutoSize = true,
                Font = BoldDefaultFont,
                Location = new Point(52, 340),
                Name = "lInterval",
                Size = new Size(71, 20),
                TabIndex = 14,
                Text = "Interval"
            };
            _taskCreator.Controls.Add(lInterval);
        }

        public override void ClearTaskCreator()
        {
            RemoveControlByName("cbInterval");
            RemoveControlByName("lInterval");

            base.ClearTaskCreator();
        }
    }
}