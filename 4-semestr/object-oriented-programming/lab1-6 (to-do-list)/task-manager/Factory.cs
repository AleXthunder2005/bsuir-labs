using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Windows.Forms;
using task_manager.Tasks;

namespace task_manager
{
    public class Factory
    {
        private List<Assembly> _loadedAssemblies;
        private fTaskCreator _taskCreator;

        public Factory(List<Assembly> loadedAssemblies, fTaskCreator taskCreator = null)
        {
            _loadedAssemblies = loadedAssemblies;
            _taskCreator = taskCreator;
        }

        public TaskOptions CreateTaskOptions(string className)
        {
            if (string.IsNullOrEmpty(className))
            {
                MessageBox.Show("Class name cannot be null or empty", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }

            string fullClassName = $"{Settings.TASKS_NAMESPACE}.{className}";
            string optionsName = $"{fullClassName}Options";

            Type optionsType = Type.GetType(optionsName);

            if (optionsType == null)
            {
                foreach (Assembly assembly in _loadedAssemblies)
                {
                    optionsType = assembly.GetType(optionsName);
                    if (optionsType != null) break;
                }
            }

            if (optionsType == null)
            {
                MessageBox.Show($"Options type '{optionsName}' not found", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }

            dynamic options = null;
            try
            {
                options = Activator.CreateInstance(optionsType, _taskCreator);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Failed to create instance of {optionsName}: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
            return options;
        }

        public TaskCreatorBuilder CreateTaskCreatorBuilder(string className)
        {
            if (string.IsNullOrEmpty(className))
            {
                MessageBox.Show("Class name cannot be null or empty", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }

            string fullClassName = $"{Settings.TASKS_NAMESPACE}.{className}";
            string taskCreatorBuilderName = $"{fullClassName}CreatorBuilder";

            Type taskCreatorBuilderType = Type.GetType(taskCreatorBuilderName);

            if (taskCreatorBuilderType == null)
            {
                foreach (Assembly assembly in _loadedAssemblies)
                {
                    taskCreatorBuilderType = assembly.GetType(taskCreatorBuilderName);
                    if (taskCreatorBuilderType != null) break;
                }
            }

            if (taskCreatorBuilderType == null)
            {
                MessageBox.Show($"Builder type '{taskCreatorBuilderName}' not found", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }

            dynamic taskCreatorBuilder = null;
            try
            {
                taskCreatorBuilder = Activator.CreateInstance(taskCreatorBuilderType, _taskCreator);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Failed to create instance of {taskCreatorBuilderName}: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
            return taskCreatorBuilder;
        }

        public TaskCreatorInitializer CreateTaskCreatorInitializer(string className)
        {
            if (string.IsNullOrEmpty(className))
            {
                MessageBox.Show("Class name cannot be null or empty", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }

            string fullClassName = $"{Settings.TASKS_NAMESPACE}.{className}";
            string initializerName = $"{fullClassName}CreatorInitializer";

            Type initializerType = Type.GetType(initializerName);

            if (initializerType == null)
            {
                foreach (Assembly assembly in _loadedAssemblies)
                {
                    initializerType = assembly.GetType(initializerName);
                    if (initializerType != null) break;
                }
            }

            if (initializerType == null)
            {
                MessageBox.Show($"Initializer type '{initializerName}' not found", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }

            dynamic taskCreatorInitializer = null;
            try
            {
                taskCreatorInitializer = Activator.CreateInstance(initializerType, _taskCreator);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Failed to create instance of {initializerName}: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
            return taskCreatorInitializer;
        }

        public Task CreateTask(string className)
        {
            var options = CreateTaskOptions(className);
            if (options == null) return null;

            options.Build();
            string fullClassName = $"{Settings.TASKS_NAMESPACE}.{className}";

            Type taskType = Type.GetType(fullClassName);
            if (taskType == null)
            {
                foreach (Assembly assembly in _loadedAssemblies)
                {
                    taskType = assembly.GetType(fullClassName);
                    if (taskType != null) break;
                }
            }

            if (taskType == null)
            {
                MessageBox.Show($"Task type '{fullClassName}' not found", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }

            dynamic task = null;
            try
            {
                task = Activator.CreateInstance(taskType, options);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Failed to create instance of {fullClassName}: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
            return task;
        }
    }
}