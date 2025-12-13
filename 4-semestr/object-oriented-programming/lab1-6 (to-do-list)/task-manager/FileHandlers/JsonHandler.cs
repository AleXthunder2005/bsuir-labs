using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Windows.Forms;
using task_manager.FileHandlers;
using task_manager.Plugins;
using task_manager.Tasks;


namespace task_manager
{
    public static class JsonHandler
    {
        private static readonly JsonSerializerOptions _jsonOptions = new JsonSerializerOptions
        {
            WriteIndented = true,
            Converters = { new TaskJsonConverter() },
        };

        public static string BuildJson(TaskList<Task> tasks, bool haveToSaveChecksum = false)
        {
            try
            {
                string json = JsonSerializer.Serialize(tasks, _jsonOptions);

                //Подключение плагина
                if (haveToSaveChecksum)
                {
                    Assembly jsonChecksumSaver = Assembly.LoadFrom(Settings.JSON_SAVER_PATH);

                    Type jsonPluginType = jsonChecksumSaver.GetType($"{Settings.PLUGINS_NAMESPACE}.JsonPlugin");

                    if (jsonPluginType == null)
                    {
                        MessageBox.Show($"Checksum saver is not found in {Settings.JSON_SAVER_PATH}");
                        return json;
                    }

                    MethodInfo saveChecksumMethod = jsonPluginType.GetMethod("SaveChecksum", BindingFlags.Public | BindingFlags.Static);

                    if (saveChecksumMethod == null) return json;

                    json = (string)saveChecksumMethod.Invoke(null, new object[] { json });
                }
                //Конец подключения плагина

                return json;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Serialization failed: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
        }

        public static TaskList<Task> ReadJson(string json, bool haveToVerifyChecksum = false)
        {
            try
            {
                //Начало подключения плагина
                if (haveToVerifyChecksum)
                {
                    Assembly jsonChecksumSaver = Assembly.LoadFrom(Settings.JSON_SAVER_PATH);
                    Type jsonPluginType = jsonChecksumSaver.GetType($"{Settings.PLUGINS_NAMESPACE}.JsonPlugin");
                    if (jsonPluginType == null)
                    {
                        MessageBox.Show($"Checksum saver is not found in {Settings.JSON_SAVER_PATH}", "Opening plugin error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                    else
                    {
                        MethodInfo isChecksumCorrectMethod = jsonPluginType.GetMethod("IsChecksumCorrect", BindingFlags.Public | BindingFlags.Static);
                        if (isChecksumCorrectMethod != null)
                        {
                            bool isChecksumCorrect = (bool)isChecksumCorrectMethod.Invoke(null, new object[] { json });
                            if (!isChecksumCorrect)
                            {
                                MessageBox.Show($"Checksum is incorrect!", "Incorrect checksum", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                return new TaskList<Task>();
                            }
                        }

                        MethodInfo discardChecksumMethod = jsonPluginType.GetMethod("DiscardChecksum", BindingFlags.Public | BindingFlags.Static);
                        if (discardChecksumMethod != null)
                        {
                            json = (string)discardChecksumMethod.Invoke(null, new object[] { json });
                        }
                    }
                }
                //Конец подключения плагина


                TaskList<Task> tasks = JsonSerializer.Deserialize<TaskList<Task>>(json, _jsonOptions);
                if (tasks != null)
                {
                    tasks.RemoveAll(task => task == null);
                    return tasks;
                }
                return new TaskList<Task>();
            }
            catch (JsonException ex)
            {
                MessageBox.Show($"Invalid JSON format: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return new TaskList<Task>();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error reading JSON: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return new TaskList<Task>();
            }
        }
    }
}
