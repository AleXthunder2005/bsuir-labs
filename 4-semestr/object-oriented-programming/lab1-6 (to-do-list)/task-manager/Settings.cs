using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;

namespace task_manager
{
    public static class Settings
    {
        public static bool haveToSaveChecksum = false;

        public static int TaskWidthSetting = 500;
        public static int TaskHeightSetting = 110;
        public const int TASK_MARGIN = 10;
        public const int TASK_PADDING = 10;

        public const int TASK_TITLE_FONT_SIZE = 11;
        public const int TASK_FONT_SIZE = 10;

        public const int TASK_LINE_SPACING = 20;

        public const int PROGRESS_BAR_HEIGHT = 15;
        public const int SCROLLBAR_WIDTH = 25;

        public const int RESETED_TASK_INDEX = -1;

        public const string TASKS_NAMESPACE = "task_manager.Tasks";
        public const string PLUGINS_NAMESPACE = "task_manager.Plugins";
        public const string DEFAULT_FILE_NAME = "save";

        private static readonly string PluginsDirectory = Path.GetFullPath(
            Path.Combine(AppContext.BaseDirectory, @"..\..\..", "plugins"));

        public static readonly string JSON_SAVER_PATH = Path.Combine(
            PluginsDirectory,
            "JsonChecksumSaver.dll");

        public static readonly string BINARY_SAVER_PATH = Path.Combine(
            PluginsDirectory,
            "BinaryChecksumSaver.dll");
    }
}

