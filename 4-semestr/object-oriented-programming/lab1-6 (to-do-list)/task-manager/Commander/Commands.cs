using task_manager.Tasks;

namespace task_manager
{
    public interface ICommand
    {
        void Execute();
        void Undo();
    }

    public class AddTaskCommand : ICommand
    {
        private readonly Task _task;
        private readonly int _taskID;
        public AddTaskCommand(Task task)
        {
            _task = task;
            _taskID = _task.TaskID;
        }

        public void Execute() => mTaskManager.Tasks.Add(_task);
        public void Undo()
        {
            foreach (var task in mTaskManager.Tasks)
                if (_task.Equals(task)) 
                {
                    mTaskManager.Tasks.Remove(task);
                    break;
                }
        }
    }

    public class DeleteTaskCommand : ICommand
    {
        private readonly Task _task;
        private readonly int _index;

        public DeleteTaskCommand(int index)
        {
            _index = index;
            _task = mTaskManager.Tasks[index];
        }

        public void Execute() => mTaskManager.Tasks.RemoveAt(_index);
        public void Undo()
        {
             mTaskManager.Tasks.Insert(_index, _task);
        }
    }

    public class CompleteTaskCommand : ICommand
    {
        private readonly int _index;
        private readonly Task _task;
        private bool _wasCompleted;

        public CompleteTaskCommand(int index)
        {
            _index = index;
            _task = mTaskManager.Tasks[index];
        }

        public void Execute()
        {
            var task = mTaskManager.Tasks[_index];

            if (task is ProgressTask progressTask)
            {
                progressTask.CurrCount++;
                _wasCompleted = progressTask.CurrCount >= progressTask.GoalCount;

                if (_wasCompleted)
                {
                    mTaskManager.Tasks[_index].IsCompleted = true;
                }
            }
            else
            {
                _wasCompleted = true;
                mTaskManager.Tasks[_index].IsCompleted = true;
            }
        }

        public void Undo()
        {
            if (_wasCompleted)
            {
                mTaskManager.Tasks[_index].IsCompleted = false;
            }
            
            if (_task is ProgressTask progressTask)
            {
                var currentTask = (ProgressTask)mTaskManager.Tasks[_index];
                currentTask.CurrCount--;
            }
        }
    }

    // Команда редактирования задачи
    public class EditTaskCommand : ICommand
    {
        private readonly int _index;
        private readonly Task _originalTask;
        private readonly Task _modifiedTask;

        public EditTaskCommand(int index, Task modifiedTask)
        {
            _index = index;
            _originalTask = mTaskManager.Tasks[index].Clone();
            _modifiedTask = modifiedTask;
        }

        public void Execute() => mTaskManager.Tasks[_index] = _modifiedTask;
        public void Undo() => mTaskManager.Tasks[_index] = _originalTask;
    }
}