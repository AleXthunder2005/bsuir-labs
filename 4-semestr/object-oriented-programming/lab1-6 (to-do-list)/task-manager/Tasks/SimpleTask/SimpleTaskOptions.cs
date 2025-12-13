using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class SimpleTaskOptions : TaskOptions
    {
        // simple_task
        private DateTime _startDate = DateTime.Now.Date;
        private DateTime _deadlineDate = DateTime.Now.Date;


        public DateTime StartDate
        {
            get { return _startDate; }
            set { _startDate = value; }
        }

        public DateTime DeadlineDate
        {
            get { return _deadlineDate; }
            set { _deadlineDate = value; }
        }

        public SimpleTaskOptions() : base() { }
        public SimpleTaskOptions(fTaskCreator taskCreator) : base(taskCreator)
        {

        }

        public override TaskOptions Build() 
        {
            SimpleTaskOptions options = (SimpleTaskOptions)base.Build();

            if (_taskCreator != null)
            {
                if (_taskCreator.Controls.Find("dtpStartDate", true).FirstOrDefault() is DateTimePicker dtpStartDate) { options._startDate = dtpStartDate.Value.Date; }
                if (_taskCreator.Controls.Find("dtpDeadlineDate", true).FirstOrDefault() is DateTimePicker dtpDeadlineDate) { options._deadlineDate = dtpDeadlineDate.Value.Date; }
            }

            return options;
        }
    }
}
