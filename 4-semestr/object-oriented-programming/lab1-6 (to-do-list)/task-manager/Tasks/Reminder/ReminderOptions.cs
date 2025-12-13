using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class ReminderOptions : TaskOptions
    {
        // reminder
        private DateTime _sheduledTime = DateTime.Now.Date;
        private bool _isViewed = false;
        public DateTime SheduledTime
        {
            get { return _sheduledTime; }
            set { _sheduledTime = value; }
        }

        public bool IsViewed
        {
            get { return _isViewed; }
            set { _isViewed = value; }
        }

        public ReminderOptions() : base() { }
        public ReminderOptions(fTaskCreator taskCreator) : base(taskCreator)
        {

        }

        public override TaskOptions Build()
        {
            ReminderOptions options = (ReminderOptions)base.Build();
            if (_taskCreator != null)
            {
                if (_taskCreator.Controls.Find("dtpSheduledTime", true).FirstOrDefault() is DateTimePicker dtpSheduledTime) { options._sheduledTime = dtpSheduledTime.Value.Date; }
            }

            return options;
        }
    }
}
