using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class ReccuringSimpleTaskOptions : SimpleTaskOptions
    {
        // reccuring_simple_task
        private double _interval = 1; // в часах

        public double Interval
        {
            get { return _interval; }
            set { _interval = value; }
        }

        public ReccuringSimpleTaskOptions() : base() { }
        public ReccuringSimpleTaskOptions(fTaskCreator taskCreator) : base(taskCreator)
        {

        }

        public override TaskOptions Build()
        {
            ReccuringSimpleTaskOptions options = (ReccuringSimpleTaskOptions)base.Build();

            if (_taskCreator != null)
            {
                if (_taskCreator.Controls.Find("cbInterval", true).FirstOrDefault() is ComboBox cbInterval)
                {
                    if (double.TryParse(cbInterval.Text, out double interval))
                    {
                        options._interval = interval;
                    }
                }
            }

            return options;
        }
    }
}
