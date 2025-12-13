using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using task_manager.Tasks;

namespace task_manager.FileHandlers
{
    public static class JsonPlugin
    {
        public static string SaveChecksum(string jsonArray)
        {
            int checksum = int.MaxValue - jsonArray.Length;

            StringBuilder jsonBuilder = new StringBuilder("");

            jsonBuilder.Append("{");
            jsonBuilder.Append("\"Tasks\":");
            jsonBuilder.Append(jsonArray);

            jsonBuilder.Append(",");

            jsonBuilder.Append($"\"Metadata\":{{\"Checksum\": {checksum}}}");

            jsonBuilder.Append("}");

            return jsonBuilder.ToString();
        }

        public static string DiscardChecksum(string json)
        {

            Dictionary<string, string> parsedJson = JsonParser.ParseJsonObject(json);

            if (parsedJson.ContainsKey("Tasks"))
            {
                int tasksArrayLength = parsedJson["Tasks"].Length;
                return parsedJson["Tasks"].Substring(1, tasksArrayLength - 2); // обрезали {}
            }
            {
                return json;
            }
        }

        public static bool IsChecksumCorrect(string json)
        {

            Dictionary<string, string> parsedJson = JsonParser.ParseJsonObject(json);

            if (parsedJson.ContainsKey("Metadata"))
            {
                var parsedMetadata = JsonParser.ParseJsonObject(parsedJson["Metadata"]);
                if (parsedMetadata.ContainsKey("Checksum"))
                {
                    try
                    {
                        int checksum = int.Parse(parsedMetadata["Checksum"]);
                        int diff = int.MaxValue - (checksum + parsedJson["Tasks"].Length);
                        if (diff != 0)
                        {
                            return false;
                        }
                    }
                    catch
                    {
                        return false;
                    }
                }
            }
            else
            {
                return false;
            }

            return true;
        }

        public static class JsonParser
        {
            public static Dictionary<string, string> ParseJsonObject(string json)
            {
                var resultDictionary = new Dictionary<string, string>();
                json = json.Trim().Substring(1, json.Length - 2); //убрали крайние { и }

                int braceLevel = 0;
                int startIndex = 0;

                // Сначала разбиваем на пары ключ-значение с учетом вложенных объектов
                var pairs = new List<string>();
                for (int i = 0; i < json.Length; i++)
                {
                    char c = json[i];

                    if (c == '{' || c == '[') braceLevel++;
                    if (c == '}' || c == ']') braceLevel--;

                    if (c == ',' && braceLevel == 0)
                    {
                        pairs.Add(json.Substring(startIndex, i - startIndex));
                        startIndex = i + 1;
                    }
                }

                // Добавляем последнюю пару
                if (startIndex < json.Length)
                    pairs.Add(json.Substring(startIndex));

                // Обрабатываем каждую пару
                foreach (var pair in pairs)
                {
                    int colonPos = pair.IndexOf(':');
                    if (colonPos <= 0) continue;

                    string key = pair.Substring(0, colonPos).Trim().Trim('"');
                    string value = pair.Substring(colonPos + 1).Trim();

                    // Удаляем кавычки у строковых значений
                    if (value.StartsWith("\"") && value.EndsWith("\""))
                        value = value.Substring(1, value.Length - 2);
                    value = value.Trim();

                    resultDictionary[key] = value;
                }

                return resultDictionary;
            }
        }

    }
}
