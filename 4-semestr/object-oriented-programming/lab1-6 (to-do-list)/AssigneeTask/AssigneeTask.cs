using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;
using System.Text.Json.Serialization;

namespace task_manager.Tasks
{
    [Serializable]
    public class AssigneeTask : SimpleTask
    {
        private string _assignee;

        public new static string taskTypeName = "Task with Assignee";

        public AssigneeTask() : base() { }

        public AssigneeTask(AssigneeTaskOptions builder) : base(builder)
        {
            if (builder is AssigneeTaskOptions assigneeBuilder)
            {
                Assignee = assigneeBuilder.Assignee;
            }
        }

        public override void SetOptions()
        {
            base.SetOptions();
            // Можно настроить специфические опции отрисовки
        }

        public override void Draw(Graphics g, DrawOptions options)
        {
            base.Draw(g, options);

            Brush textBrush = new SolidBrush(options.TextColor);
            Font assigneeFont = new Font("Arial", options.FontSize, FontStyle.Italic);

            string assigneeText = $"Assignee: {Assignee}";
            SizeF textSize = g.MeasureString(assigneeText, assigneeFont);

            float x = options.X + options.Width - textSize.Width - options.Padding;
            float y = options.Y + options.Height - textSize.Height - options.Padding;

            g.DrawString(assigneeText, assigneeFont, textBrush, x, y);
        }

        public override Task Clone()
        {
            return new AssigneeTask
            {
                TaskID = this.TaskID,
                Title = this.Title,
                Description = this.Description,
                IsCompleted = this.IsCompleted,
                Assignee = this.Assignee,
                Options = new DrawOptions
                {
                    IsSelected = this.Options.IsSelected,
                    X = this.Options.X,
                    Y = this.Options.Y,
                    Width = this.Options.Width,
                    Height = this.Options.Height,
                    Margin = this.Options.Margin,
                    BackgroundColor = this.Options.BackgroundColor,
                    TextColor = this.Options.TextColor,
                    FontSize = this.Options.FontSize,
                }
            };
        }

        // Свойство исполнителя
        [JsonPropertyName("Assignee")]
        public string Assignee
        {
            get { return _assignee; }
            set { _assignee = value; }
        }

    }
}
