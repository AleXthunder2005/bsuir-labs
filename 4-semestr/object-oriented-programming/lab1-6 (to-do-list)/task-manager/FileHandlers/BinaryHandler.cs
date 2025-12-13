using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.Serialization.Formatters.Binary;
using System.Windows.Forms;
using task_manager.FileHandlers;
using task_manager.Tasks;

namespace task_manager
{
    public static class BinaryHandler
    {
        static BinaryHandler()
        {
            AppDomain.CurrentDomain.AssemblyResolve += CurrentDomain_AssemblyResolve;
        }

        public static void SerializeTasks(TaskList<Task> tasks, string filePath, bool haveToSaveChecksum = false)
        {
            try
            {
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    BinaryFormatter formatter = new BinaryFormatter();
                    formatter.Serialize(memoryStream, tasks);
                    byte[] data = memoryStream.ToArray();

                    //Подключение плагина
                    if (haveToSaveChecksum)
                    {
                        Assembly binaryChecksumSaver = Assembly.LoadFrom(Settings.BINARY_SAVER_PATH);
                        Type binaryPluginType = binaryChecksumSaver.GetType($"{Settings.PLUGINS_NAMESPACE}.BinaryPlugin");

                        if (binaryPluginType == null)
                        {
                            MessageBox.Show($"Checksum saver is not found in {Settings.BINARY_SAVER_PATH}");
                        }
                        else
                        {
                            MethodInfo saveChecksumMethod = binaryPluginType.GetMethod("SaveChecksum", BindingFlags.Public | BindingFlags.Static);

                            if (saveChecksumMethod != null)
                                data = (byte[])saveChecksumMethod.Invoke(null, new object[] { data });
                        }
                    }
                    //Конец подключения плагина

                    File.WriteAllBytes(filePath, data);

                    MessageBox.Show("Successful saving!", "Saving", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Unsuccessful saving! ({ex.Message})", "Saving error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                tasks.Clear();
            }
        }

        public static TaskList<Task> DeserializeTasks(string filePath, bool haveToVerifyChecksum = false)
        {
            try
            {
                byte[] fileData = File.ReadAllBytes(filePath);

                //Начало подключения плагина
                if (haveToVerifyChecksum)
                {
                    Assembly binaryChecksumSaver = Assembly.LoadFrom(Settings.BINARY_SAVER_PATH);
                    Type binaryPluginType = binaryChecksumSaver.GetType($"{Settings.PLUGINS_NAMESPACE}.BinaryPlugin");

                    if (binaryPluginType == null)
                    {
                        MessageBox.Show($"Checksum saver is not found in {Settings.BINARY_SAVER_PATH}");
                        return new TaskList<Task>();
                    }

                    MethodInfo isChecksumCorrectMethod = binaryPluginType.GetMethod("IsCheckSumCorrect", BindingFlags.Public | BindingFlags.Static);

                    if (isChecksumCorrectMethod != null && !((bool)isChecksumCorrectMethod.Invoke(null, new object[] { fileData })))
                    {
                        MessageBox.Show($"Reading unsuccessful! (Checksum is incorrect!)", "Opening error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return new TaskList<Task>();
                    }
                    else
                    {
                        MethodInfo discardChecksumMethod = binaryPluginType.GetMethod("DiscardChecksum", BindingFlags.Public | BindingFlags.Static);
                        byte[] data = (byte[])discardChecksumMethod.Invoke(null, new object[] { fileData });
                        using (MemoryStream memoryStream = new MemoryStream(data))
                        {
                            BinaryFormatter formatter = new BinaryFormatter();
                            return (TaskList<Task>)formatter.Deserialize(memoryStream);
                        }
                    }
                    //Конец подключения плагина
                }
                else
                {
                    using (MemoryStream memoryStream = new MemoryStream(fileData))
                    {
                        BinaryFormatter formatter = new BinaryFormatter();
                        return (TaskList<Task>)formatter.Deserialize(memoryStream);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Reading unsuccessful! ({ex.Message})", "Opening error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return new TaskList<Task>();
            }
        }

        private static Assembly CurrentDomain_AssemblyResolve(object sender, ResolveEventArgs args)
        {
            // args.Name — полное имя сборки (например, "MyAssembly, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null")

            // Ищем сборку среди уже загруженных
            var loadedAssembly = AppDomain.CurrentDomain.GetAssemblies()
                .FirstOrDefault(a => a.FullName == args.Name);

            if (loadedAssembly != null)
                return loadedAssembly;

            // Если сборка не загружена, пробуем загрузить её вручную
            foreach (Assembly assembly in mTaskManager.LoadedAssemblies) 
            {
                if (assembly.FullName == args.Name) return assembly;
            }

            return null;
        }
    }
}
