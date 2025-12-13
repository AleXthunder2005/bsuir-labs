using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Text;
using System.Text.Json.Serialization;

namespace task_manager.Tasks
{
    [Serializable]
    public class SimpleTask : Task
    {
        private DateTime _startDate;
        private DateTime _deadlineDate;

        public new static string taskTypeName = "Simple task";
        public SimpleTask() : base() { }

        public SimpleTask(SimpleTaskOptions builder) : base(builder)
        {
            int count = _idCounter;

            StartDate = builder.StartDate;
            DeadlineDate = builder.DeadlineDate;
            IsCompleted = builder.IsCompleted;

            SetOptions();
        }
        public override void SetOptions()
        {
            
        }

        public override void Draw(Graphics g, DrawOptions options)
        {
            Rectangle rect = new Rectangle(options.X, options.Y, options.Width, options.Height);
            Brush textBrush = new SolidBrush(options.TextColor);
            Pen borderPen = new Pen(options.BorderColor);
            Brush backgroundBrush = new SolidBrush(options.IsSelected ? DrawOptions.clSELECTED: IsCompleted ? DrawOptions.clCOMPLETED : options.BackgroundColor);



            g.FillRectangle(backgroundBrush, rect);
            g.DrawRectangle(borderPen, rect);

            g.DrawString($"{Title}", new Font("Arial", options.TitleFontSize, FontStyle.Bold), textBrush, options.X + options.Padding, options.Y + options.Padding);
            g.DrawString(Description, new Font("Arial", options.FontSize), textBrush, options.X + options.Padding, options.Y + options.Padding + 25);
            g.DrawString($"Start: {StartDate.ToString("D", new CultureInfo("en-US"))}", new Font("Arial", options.FontSize), textBrush, options.X + options.Padding    , options.Y + options.Padding + 40);
            g.DrawString($"Deadline: {DeadlineDate.ToString("D", new CultureInfo("en-US"))}", new Font("Arial", options.FontSize), textBrush, options.X + options.Padding, options.Y + options.Padding + 55);
        }

        public override string ToString() 
        {
            return $"{Title}({Description}) {StartDate.Date} - {DeadlineDate}";
        }

        public override Task Clone()
        {
            return new SimpleTask
            {
                TaskID = this.TaskID,
                Title = this.Title,
                Description = this.Description,
                StartDate = this.StartDate,
                DeadlineDate = this.DeadlineDate,
                IsCompleted = this.IsCompleted,
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

/*        public override string ToJSON()
        {
            var jsonBuilder = new StringBuilder("{");

            string baseJson = base.ToJSON();

            jsonBuilder.Append(baseJson, 1, baseJson.Length - 2); //сделали trim('{', '}')

            jsonBuilder.Append($",\"StartDate\":\"{StartDate: yyyy-MM-dd}\"");
            jsonBuilder.Append($",\"DeadlineDate\":\"{DeadlineDate: yyyy-MM-dd}\"");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }

        public override bool IsReadingFromJsonObjectSuccessful(Task task, Dictionary<string, string> fields)
        {
            bool isBaseSuccessful = base.IsReadingFromJsonObjectSuccessful(task, fields);
            if (!isBaseSuccessful)
                return false;

            SimpleTask simpleTask = task as SimpleTask;

            try
            {
                if (fields.ContainsKey("StartDate"))
                {
                    simpleTask.StartDate = DateTime.ParseExact(fields["StartDate"], "yyyy-MM-dd", CultureInfo.InvariantCulture);
                }

                if (fields.ContainsKey("DeadlineDate"))
                {
                    simpleTask.DeadlineDate = DateTime.ParseExact(fields["DeadlineDate"], "yyyy-MM-dd", CultureInfo.InvariantCulture);
                }
            }
            catch
            {
                return false;
            }

            return true;
        }*/


        //properties
        [JsonPropertyName("StartDate")]
        public DateTime StartDate {
            get { return _startDate; }
            set { _startDate = value; }
        }
        [JsonPropertyName("DeadlineDate")]
        public DateTime DeadlineDate
        {
            get { return _deadlineDate; }
            set { _deadlineDate = value; }
        }
    }
}
