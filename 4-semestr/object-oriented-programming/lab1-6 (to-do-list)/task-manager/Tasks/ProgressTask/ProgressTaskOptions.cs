using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace task_manager.Tasks
{
    public class ProgressTaskOptions : SimpleTaskOptions
    {
        // progress task
        private int _goalCount = 100;
        private int _currCount = 0;

        public int GoalCount
        {
            get { return _goalCount; }
            set { _goalCount = value; }
        }

        public int CurrCount
        {
            get { return _currCount; }
            set { _currCount = value; }
        }

        public ProgressTaskOptions() : base() { }
        public ProgressTaskOptions(fTaskCreator taskCreator) : base(taskCreator)
        {

        }

        public override TaskOptions Build()
        {
            ProgressTaskOptions options = (ProgressTaskOptions)base.Build();

            if (_taskCreator != null)
            {
                if (_taskCreator.Controls.Find("udGoalCount", true).FirstOrDefault() is NumericUpDown udGoalCount)
                {
                    if (int.TryParse(udGoalCount.Text, out int goalCount))
                    {
                        options._goalCount = goalCount;
                    }
                }
            }

            return options;
        }





    }


}
