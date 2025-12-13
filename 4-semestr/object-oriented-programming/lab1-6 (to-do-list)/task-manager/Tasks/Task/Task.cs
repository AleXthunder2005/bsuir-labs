using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Windows.Forms;
using task_manager.FileHandlers;

namespace task_manager.Tasks
{
    [Serializable]
    [JsonConverter(typeof(TaskJsonConverter))]
    public abstract class Task
    {
        private string _title;
        private string _description;
        private int _taskId;

        public static int _idCounter;

        static Task() 
        {
            _idCounter = 0;
        }

        public Task() { }
        public Task (TaskOptions builder) {
            Title = builder.Title;
            Description = builder.Description;

            _taskId = _idCounter++;
        }

        public abstract void Draw(Graphics g, DrawOptions options);

        public abstract void SetOptions();
        //properties
        [JsonPropertyName("Title")]
        public string Title {
            get { return _title; }
            set { _title = value; }
        }
        [JsonPropertyName("Description")]
        public string Description {
            get { return _description; }
            set { _description = value; }
        }

        [JsonPropertyName("IsCompleted")]
        public bool IsCompleted { get; set; } = false;

        public int TaskID {
            get { return _taskId; }
            set { _taskId = value; }
        }

        public DrawOptions Options { get; set; } = new DrawOptions();

        public abstract Task Clone();

        public override bool Equals(object obj)
        {
            Task otherTask = obj as Task;
            if (otherTask == null)
            {
                return false;
            }

            return this.TaskID == otherTask.TaskID;
        }

        //public virtual string ToJSON()
        //{
        //    var jsonBuilder = new StringBuilder();
        //    jsonBuilder.Append("{");

        //    jsonBuilder.Append($"\"Title\":\"{Title}\"");
        //    jsonBuilder.Append($",\"Description\":\"{Description}\"");
        //    jsonBuilder.Append($",\"TaskID\":\"{TaskID}\"");
        //    jsonBuilder.Append($",\"IsCompleted\":{(IsCompleted ? "true" : "false")}");

        //    jsonBuilder.Append("}");
        //    return jsonBuilder.ToString();
        //}

        //public virtual bool IsReadingFromJsonObjectSuccessful(Task task, Dictionary<string, string> fields)
        //{
        //    task.Title = fields.ContainsKey("Title") ? fields["Title"] : "task";
        //    task.Description = fields.ContainsKey("Description") ? fields["Description"] : "description";
        //    try
        //    {
        //        if (fields.ContainsKey("TaskID")) task.TaskID = int.Parse(fields["TaskID"]);
        //        task.IsCompleted = fields.ContainsKey("IsCompleted") ? bool.Parse(fields["IsCompleted"]) : false;
        //    }
        //    catch
        //    {
        //        return false;
        //    }
        //    return true;
        //}

    }
}
