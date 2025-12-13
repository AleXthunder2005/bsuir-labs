using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Text;
using System.Text.Json.Serialization;

namespace task_manager.Tasks
{
    [Serializable]
    class Reminder : Task
    {
        private DateTime _sheduledTime;
        private bool _isViewed;

        public new static string taskTypeName = "Reminder";

        public Reminder():base() { }

        public Reminder(ReminderOptions builder) : base(builder)
        {
            SheduledTime = builder.SheduledTime;
            IsViewed = builder.IsViewed;

            SetOptions();
        }

        public override void SetOptions()
        {
            Options.BackgroundColor = DrawOptions.clREMINDER_BACKGROUNG;
        }

        public override void Draw(Graphics g, DrawOptions options)
        {
            Rectangle rect = new Rectangle(options.X, options.Y, options.Width, options.Height);
            Brush textBrush = new SolidBrush(options.TextColor);
            Pen borderPen = new Pen(options.BorderColor);
            Brush backgroundBrush = new SolidBrush(options.IsSelected ? DrawOptions.clSELECTED : IsCompleted ? DrawOptions.clCOMPLETED : options.BackgroundColor);

            g.FillRectangle(backgroundBrush, rect);
            g.DrawRectangle(borderPen, rect);

            g.DrawString($"{Title}", new Font("Arial", options.TitleFontSize, FontStyle.Bold), textBrush, options.X + options.Padding, options.Y + options.Padding);
            g.DrawString(Description, new Font("Arial", options.FontSize), textBrush, options.X + options.Padding, options.Y + options.Padding + 25);
            g.DrawString($"Reminder: {SheduledTime.ToString("D", new CultureInfo("en-US"))}", new Font("Arial", options.FontSize), textBrush, options.X + options.Padding, options.Y + options.Padding + 40);

        }
        public override string ToString()
        {
            return $"{Title}({Description}) - {SheduledTime.Date}";
        }

        public override Task Clone()
        {
            return new Reminder
            {
                TaskID = this.TaskID,
                Title = this.Title,
                Description = this.Description,
                SheduledTime = this.SheduledTime,
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

                    jsonBuilder.Append($",\"SheduledTime\":\"{SheduledTime: yyyy-MM-dd}\"");
                    jsonBuilder.Append("}");
                    return jsonBuilder.ToString();
                }

                public override bool IsReadingFromJsonObjectSuccessful(Task task, Dictionary<string, string> fields)
                {
                    bool isBaseSuccessful = base.IsReadingFromJsonObjectSuccessful(task, fields);
                    if (!isBaseSuccessful)
                        return false;

                    Reminder reminder = task as Reminder;

                    try
                    {
                        if (fields.ContainsKey("SheduledTime"))
                        {
                            reminder.SheduledTime = DateTime.ParseExact(fields["SheduledTime"], "yyyy-MM-dd", CultureInfo.InvariantCulture);
                        }
                    }
                    catch
                    {
                        return false;
                    }

                    return true;
                }*/

        //properties
        [JsonPropertyName("SheduledTime")]
        public DateTime SheduledTime
        {
            get { return _sheduledTime; }
            set { _sheduledTime = value; }
        }

        [JsonPropertyName("IsViewed")]
        public bool IsViewed
        {
            get { return _isViewed; }
            set { _isViewed = value; }
        }
    }
}
