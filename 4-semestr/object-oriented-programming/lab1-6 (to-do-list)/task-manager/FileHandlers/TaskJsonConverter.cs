using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Text.Json;
using task_manager.Tasks;
using System.Reflection;

namespace task_manager.FileHandlers
{
    public class TaskJsonConverter : JsonConverter<Task>
    {
        public override Task Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            using (JsonDocument doc = JsonDocument.ParseValue(ref reader))
            {
                var root = doc.RootElement;
                string typeName = root.GetProperty("Type").GetString();
                var task = new Factory(mTaskManager.LoadedAssemblies).CreateTask(typeName);
                if (task == null) return null;

                // Десериализуем прямо в существующий объект
                using (var json = JsonDocument.Parse(root.GetRawText()))
                {
                    return (Task)JsonSerializer.Deserialize(json.RootElement.GetRawText(), task.GetType(), options);
                }
            }
        }

        public override void Write(Utf8JsonWriter writer, Task task, JsonSerializerOptions options)
        {
            writer.WriteStartObject();
            writer.WriteString("Type", task.GetType().Name);

            // Получаем все свойства типа
            PropertyInfo[] properties = task.GetType().GetProperties();

            foreach (PropertyInfo property in properties)
            {
                // Проверяем наличие атрибута JsonPropertyName
                object[] attributes = property.GetCustomAttributes(typeof(JsonPropertyNameAttribute), false);
                if (attributes.Length == 0) continue;

                // Получаем имя из атрибута
                string propertyName = ((JsonPropertyNameAttribute)attributes[0]).Name;
                object propertyValue = property.GetValue(task);

                writer.WritePropertyName(propertyName);
                JsonSerializer.Serialize(writer, propertyValue, options);
            }

            writer.WriteEndObject();
        }
    }
}