using System;
using System.Drawing;

namespace miapr7
{
    public class Terminal
    {
        public enum TerminalType
        {
            Error,
            Descent,
            Ascent,
            ShortHorizontal,
            ShortVertical,
            LongHorizontal,
            LongVertical,
        }

        public const int HORIZONTAL_LINE_DEVIATION = 30;
        public const int VERTICAL_LINE_DEVIATION = 30;
        public const int SHORT_HORIZONTAL_LINE_MAX_WIDTH = 200;
        public const int SHORT_VERTICAL_LINE_MAX_WIDTH = 200;
        public const int TERMINAL_PAIR_DISTANCE = 30;

        public Point Start { get; set; }
        public Point End { get; set; }
        public string Name { get; set; }
        public TerminalType Type { get; set; }

        public Terminal(Point start, Point end)
        {
            Start = start;
            End = end;
            Type = GetTerminalType(start, end);
            Name = Type.ToString();
        }

        public override string ToString()
        {
            return $"{Name} Start - ({Start.X};{Start.Y}), End - ({End.X};{End.Y})";
        }

        public Terminal Clone()
        {
            return new Terminal(Start, End);
        }

        public void Draw(Graphics graphics)
        {
            using (Pen pen = new Pen(Color.Black))
            {
                graphics.DrawLine(pen, Start, End);
            }

            if (!string.IsNullOrEmpty(Name))
            {
                PointF textPosition = new PointF(
                    (Start.X + End.X) / 2f,
                    (Start.Y + End.Y) / 2f - 15);

                using (Font font = new Font("Arial", 8))
                using (Brush brush = new SolidBrush(Color.Black))
                {
                    graphics.DrawString(Name, font, brush, textPosition);
                }
            }
        }

        private TerminalType GetTerminalType(Point start, Point end)
        {
            if (start.X > end.X)
            {
                Point temp = start;
                start = end;
                end = temp;
            }

            int startX = start.X;
            int startY = start.Y;
            int endX = end.X;
            int endY = end.Y;

            int diffX = endX - startX;
            int diffY = endY - startY;
            int lineLength = CalculateLineLength(start, end);

            if ((lineLength < HORIZONTAL_LINE_DEVIATION) || (lineLength < VERTICAL_LINE_DEVIATION))
            {
                return Math.Abs(diffX) > Math.Abs(diffY) ? TerminalType.ShortHorizontal : TerminalType.ShortVertical;
            }

            if (Math.Abs(diffX) < VERTICAL_LINE_DEVIATION)
            {
                return lineLength < SHORT_VERTICAL_LINE_MAX_WIDTH ? TerminalType.ShortVertical : TerminalType.LongVertical;
            }
            else if (Math.Abs(diffY) < HORIZONTAL_LINE_DEVIATION)
            {
                return lineLength < SHORT_HORIZONTAL_LINE_MAX_WIDTH ? TerminalType.ShortHorizontal : TerminalType.LongHorizontal;
            }
            else if (diffY > 0)
            {
                return TerminalType.Descent;
            }
            else
            {
                return TerminalType.Ascent;
            }
        }

        private int CalculateLineLength(Point start, Point end)
        {
            return (int)Math.Round(Math.Sqrt((end.X - start.X) * (end.X - start.X) + (end.Y - start.Y) * (end.Y - start.Y)));
        }

        public bool IsCloseTo(Terminal other)
        {
            return CalculateLineLength(this.End, other.Start) <= TERMINAL_PAIR_DISTANCE;
        }
    }
}
