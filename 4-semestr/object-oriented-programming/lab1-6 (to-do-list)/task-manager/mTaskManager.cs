using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using static task_manager.Settings;
using task_manager.Tasks;
using System.Windows.Forms;

namespace task_manager
{
    static class mTaskManager
    {
        private static TaskList<Task> _tasks = new TaskList<Task>();       //Список задач
        private static List<Type> _taskTypes = new List<Type>();
        private static List<Assembly> _loadedAssemblies= new List<Assembly>();

        public static int SelectedTaskIndex { get; set; } = RESETED_TASK_INDEX;
        public static void Initialize() {
            _taskTypes = LoadTaskTypes();
        }

        private static List<Type> LoadTaskTypes() { 
   
            List<Type> taskTypes = new List<Type>();
            Assembly assembly = Assembly.GetExecutingAssembly();
            var taskClasses = assembly.GetTypes().Where(type => type.IsClass && !type.IsAbstract && type.IsSubclassOf(typeof(Task)));
            foreach (var type in taskClasses)
            {
                taskTypes.Add(type);
            }

            return taskTypes;
        }

        public static bool LoadNewTaskType(Assembly newAssembly)
        {
            try
            {
                var newTaskTypes = newAssembly.GetTypes()
                    .Where(type => type.IsClass &&
                                  !type.IsAbstract &&
                                  type.IsSubclassOf(typeof(Task)));

                foreach (var type in newTaskTypes)
                {
                    if (!_taskTypes.Contains(type))
                    {
                        _taskTypes.Add(type);
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Loading new class unsuccessful", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
        }


        public static bool LoadAssembly(string dllPath) 
        {
            bool isCorrect = false;
            Assembly assembly = Assembly.LoadFrom(dllPath);

            if (assembly != null && (!_loadedAssemblies.Contains(assembly)))
            {
                _loadedAssemblies.Add(assembly);
                isCorrect = LoadNewTaskType(assembly);
                MessageBox.Show("Loading dll successful!", "Loading", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            return isCorrect;
        }

        //properties
        public static TaskList<Task> Tasks {
            get { return _tasks; }
            set { _tasks = value; }
        }

        public static List<Type> TaskTypes
        {
            get { return _taskTypes; }
        }

        public static List<Assembly> LoadedAssemblies { get { return _loadedAssemblies; } }
    }
}
