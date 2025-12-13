using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using static task_manager.Settings;

namespace task_manager.Tasks
{
    public abstract class TaskCreatorBuilder
    {
        protected static readonly System.Drawing.Font DefaultFont = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        protected static readonly System.Drawing.Font BoldDefaultFont = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));

        protected fTaskCreator _taskCreator;

        public TaskCreatorBuilder(fTaskCreator taskCreator) 
        { 
            _taskCreator = taskCreator;
        }

        public abstract void BuildTaskCreator();
        public abstract void ClearTaskCreator();

        protected void RemoveControlByName( string controlName)
        {
            var control = _taskCreator.Controls.Find(controlName, true).FirstOrDefault();
            if (control != null)
            {
                _taskCreator.Controls.Remove(control);
                control.Dispose(); 
            }
        }




        

        


    }
}