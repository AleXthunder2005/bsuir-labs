using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Windows.Forms;

namespace task_manager.Plugins
{
    public static class JsonPlugin
    {
        private static readonly JsonSerializerOptions _jsonOptions = new JsonSerializerOptions
        {
            WriteIndented = true,
        };

        public static object Settings { get; private set; }

        // Класс-обертка для задач и метаданных
        public class TaskDataWrapper
        {
            [JsonPropertyName("Tasks")]
            public List<object> Tasks { get; set; } = new List<object>();

            [JsonPropertyName("Metadata")]
            public Metadata Metadata { get; set; } = new Metadata();
        }

        // Класс для хранения метаданных
        public class Metadata
        {
            [JsonPropertyName("Checksum")]
            public int Checksum { get; set; }
        }
        public static string SaveChecksum(string jsonArray)
        {
            try
            {
                // Десериализуем входной JSON в список задач
                var tasks = JsonSerializer.Deserialize<List<object>>(jsonArray, _jsonOptions);

                // Сериализуем задачи в стандартизированный JSON
                string standardizedJson = JsonSerializer.Serialize(tasks, _jsonOptions);

                // Создаем обертку с задачами и контрольной суммой
                var wrapper = new TaskDataWrapper
                {
                    Tasks = tasks,
                    Metadata = new Metadata
                    {
                        Checksum = CalculateChecksum(standardizedJson)
                    }
                };

                // Сериализуем обертку в JSON и возвращаем
                return JsonSerializer.Serialize(wrapper, _jsonOptions);
            }
            catch (JsonException ex)
            {
                throw new InvalidOperationException("Invalid JSON format", ex);
            }
        }

        public static string DiscardChecksum(string json)
        {
            try
            {
                // Десериализуем обертку
                var wrapper = JsonSerializer.Deserialize<TaskDataWrapper>(json, _jsonOptions);

                // Возвращаем задачи в виде JSON
                return JsonSerializer.Serialize(wrapper.Tasks, _jsonOptions);
            }
            catch (JsonException)
            {
                // Если формат обертки неверный, возвращаем оригинальный JSON
                return json;
            }
        }

        public static bool IsChecksumCorrect(string json)
        {
            try
            {
                // Десериализуем обертку
                var wrapper = JsonSerializer.Deserialize<TaskDataWrapper>(json, _jsonOptions);
                if (wrapper == null || wrapper.Metadata == null) return false;

                // Сериализуем задачи в стандартизированный JSON
                string tasksJson = JsonSerializer.Serialize(wrapper.Tasks, _jsonOptions);

                // Вычисляем ожидаемую контрольную сумму
                int expectedChecksum = CalculateChecksum(tasksJson);

                // Сравниваем контрольные суммы
                return wrapper.Metadata.Checksum == expectedChecksum;
            }
            catch (JsonException)
            {
                return false;
            }
        }

        private static int CalculateChecksum(string json)
        {
            int checksum = 0;
            foreach (char c in json)
            {
                // Простая хеш-функция на основе битовых операций
                checksum = (checksum << 5) - checksum + c;
            }
            return checksum;
        }
    }
}