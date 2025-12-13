using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using task_manager.Tasks;

namespace task_manager
{
    class Project
    {
        private DateTime m_projectStart;
        private DateTime m_projectDeadline;
        private string m_projectTitle;
        private string m_projectDescription;
        private bool m_isCompleted;
        private TaskList<Task> m_taskList;


        public Project(DateTime projectStart, DateTime projectDeadline, string title = "new project", string description = "nothing")
        {
            ProjectStart = projectStart;
            ProjectDeadline = projectDeadline;
            ProjectTitle = title;
            ProjectDescription = description;
            IsCompleted = false;
            m_taskList = new TaskList<Task>();
        }

        //properties
        public DateTime ProjectStart
        {
            get { return m_projectStart; }
            set { m_projectStart = value; }
        }

        public DateTime ProjectDeadline
        {
            get { return m_projectDeadline; }
            set { m_projectDeadline = value; }
        }

        public string ProjectTitle
        {
            get { return m_projectTitle; }
            set { m_projectTitle = value; }
        }

        public string ProjectDescription
        {
            get { return m_projectDescription; }
            set { m_projectDescription = value; }
        }

        public bool IsCompleted
        {
            get { return m_isCompleted; }
            set { m_isCompleted = value; }
        }
    }
}
