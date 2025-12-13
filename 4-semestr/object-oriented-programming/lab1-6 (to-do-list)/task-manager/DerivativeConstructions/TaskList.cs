using System;
using System.Collections.Generic;
using task_manager.Tasks;

namespace task_manager
{
    [Serializable]
    public class TaskList<T> : List<T> where T: Task
    {
        
    }
}
