using System;
using System.Drawing;
using static task_manager.Settings;

namespace task_manager
{
    [Serializable]
    public class DrawOptions
    {
        public static Color clSELECTED = Color.CadetBlue;
        public static Color clHIGH_PRIORITY = Color.LightCoral;
        public static Color clMEDIUM_PRIORITY = Color.Orange;
        public static Color clLOW_PRIORITY = Color.LightYellow;
        public static Color clREMINDER_BACKGROUNG = Color.DeepSkyBlue;
        public static Color clCOMPLETED = Color.LightGreen;

        public int X { get; set; } = 0;
        public int Y { get; set; } = 0;

        public Color BackgroundColor { get; set; } = Color.White;
        public Color BorderColor { get; set; } = Color.Black;
        public Color TextColor { get; set; } = Color.Black;
        public Color ProgressBarFillColor { get; set; } = Color.Green;
        public Color ProgressBarBackgroundColor { get; set; } = Color.LightGray;

        public int Height { get; set; } = TaskHeightSetting;
        public int Width { get; set; } = TaskWidthSetting;
        public int Margin { get; set; } = TASK_MARGIN;
        public int Padding { get; set; } = TASK_PADDING;

        public int TitleFontSize { get; set; } = TASK_TITLE_FONT_SIZE;
        public int FontSize { get; set; } = TASK_FONT_SIZE;
        public int LineSpacing { get; set; } = TASK_LINE_SPACING;

        public int ProgressBarHeight { get; set; } = PROGRESS_BAR_HEIGHT;

        public bool IsSelected = false;
    }
}
