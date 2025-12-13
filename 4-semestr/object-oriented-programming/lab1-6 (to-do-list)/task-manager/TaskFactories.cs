using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace task_manager.TaskFactories
{
    public abstract class TaskFactory
    {
        public abstract Task CreateTask(TaskBuilder builder);
    }

    public class SimpleTaskFactory : TaskFactory
    {
        public override Task CreateTask(TaskBuilder builder) => new SimpleTask(builder);
    }

    public class ReminderFactory : TaskFactory
    {
        public override Task CreateTask(TaskBuilder builder) => new Reminder(builder);

    }

    public class ReccuringSimpleTaskFactory : TaskFactory
    {
        public override Task CreateTask(TaskBuilder builder) => new ReccuringSimpleTask(builder);
    }

    public class ProgressTaskFactory : TaskFactory
    {
        public override Task CreateTask(TaskBuilder builder) => new ProgressTask(builder);
    }

    public class PriorityTaskFactory : TaskFactory
    {
        public override Task CreateTask(TaskBuilder builder) => new PriorityTask(builder);
    }

    //class ReccuringReminderFactory : ITaskFactory
    //{
    //    public Task CreateTask() => new ReccuringReminder();
    //}

    //class VoiceReminderFactory : ITaskFactory
    //{
    //    public Task CreateTask() => new VoiceReminder();
    //}
}
