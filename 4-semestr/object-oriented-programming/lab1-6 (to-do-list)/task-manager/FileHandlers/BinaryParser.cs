using System.Collections.Generic;
using task_manager.Tasks;

namespace task_manager
{
    public static class BinaryParser
    {
        public static Dictionary<string, string> ParseBinaryObject(string obj)
        {
            var resultDictionary = new Dictionary<string, string>();
            string[] strings = obj.Split(',');
            foreach (string s in strings)
            {
                string[] pair = s.Split(':');
                if (pair.Length == 2)
                {
                    resultDictionary.Add(pair[0].Trim(), pair[1].Trim());
                }
            }
            return resultDictionary;
        }
    }
}
