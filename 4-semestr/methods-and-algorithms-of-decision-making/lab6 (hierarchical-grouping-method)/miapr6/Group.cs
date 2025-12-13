using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace miapr6
{
    public class Group
    {
        public float Distance { get; set; }
        public List<int> Indexes = new List<int>();
        public List<Group> Groups = new List<Group>();
        public static char GroupName { get; set; } = 'A';

        public Group(int index)
        {
            Distance = 0;
            Indexes.Add(index);
            GroupName = GroupName++;
        }

        public Group(float distance, Group firstGroup, Group secondGroup)
        {
            Distance = distance;
            Groups.Add(firstGroup);
            Groups.Add(secondGroup);
            GroupName = GroupName++;
        }
    }
}
