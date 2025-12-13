using System;
using System.Collections.Generic;

namespace task_manager
{
    static class mTaskCreator
    {
        private static List<Type> _taskTypes;

        public static void Initialize(List<Type> taskTypes)
        {
            _taskTypes = taskTypes;
        }

        public static List<Type> TaskTypes
        {
            get { return _taskTypes; }
        }


        //public static void AddTaskType(Type type) 
        //{
        //     //_taskTypes.Add(type);
        //}
    }
}
