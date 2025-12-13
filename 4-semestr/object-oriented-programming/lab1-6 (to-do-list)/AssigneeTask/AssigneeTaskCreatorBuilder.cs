using System;
using System.Drawing;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class AssigneeTaskCreatorBuilder : SimpleTaskCreatorBuilder
    {
        public AssigneeTaskCreatorBuilder(fTaskCreator taskCreator) : base(taskCreator)
        {
        }

        public override void BuildTaskCreator()
        {
            base.BuildTaskCreator();

            // Создаем и настраиваем TextBox для исполнителя
            TextBox tbAssignee = new TextBox
            {
                Location = new Point(189, 340),
                Name = "tbAssignee",
                Size = new Size(362, 22),
                TabIndex = 14,
                Font = DefaultFont
            };
            _taskCreator.Controls.Add(tbAssignee);

            // Создаем и настраиваем Label для текста "Assignee"
            Label lAssignee = new Label
            {
                AutoSize = true,
                Font = BoldDefaultFont,
                Location = new Point(52, 342),
                Name = "lAssignee",
                Size = new Size(80, 20),
                TabIndex = 15,
                Text = "Assignee"
            };
            _taskCreator.Controls.Add(lAssignee);
        }

        public override void ClearTaskCreator()
        {
            RemoveControlByName("tbAssignee");
            RemoveControlByName("lAssignee");

            base.ClearTaskCreator();
        }
    }
}