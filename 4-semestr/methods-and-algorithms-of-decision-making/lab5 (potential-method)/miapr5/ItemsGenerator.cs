using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace miapr5
{
    public class ItemsGenerator
    {
        public Item[][] Kernels { get; set; }
        public Item[] Items { get; set; }

        public int ClassPresenterCount { get; set; } = 1;
        public int ItemsCount { get; set; } = DEFAULT_ITEMS_COUNT;

        private static int _contentWidth;
        private static int _contentHeight;


        private const int DEFAULT_ITEMS_COUNT = 30000;

        private const byte DEFAULT_CLASS_ID = 0;
        public static Color DEFAULT_COLOR = Color.LightGray;

        public static Color[] KERNEL_COLORS = 
        {
            Color.Gray,   //не используется
            Color.Blue,
            Color.Red,
        };
        public static Color[] COLORS = 
        {
            DEFAULT_COLOR,
            Color.LightBlue,
            Color.LightCoral,
        };


        public ItemsGenerator(int contentWidth, int contentHeight,  int classPresentersCount, int itemsCount = DEFAULT_ITEMS_COUNT) {
            _contentWidth = contentWidth;
            _contentHeight = contentHeight;
            ClassPresenterCount = classPresentersCount;
            ItemsCount = itemsCount;

            Items = new Item[ItemsCount];
            for (int i = 0; i < ItemsCount; i++)
            {
                Items[i] = new Item();
            }

            Kernels = new Item[2][];
            for (int i = 0; i < Kernels.Length; i++) {
                Kernels[i] = new Item[ClassPresenterCount] ;
                for (int j = 0; j < Kernels[i].Length; j++)
                {
                    Kernels[i][j] = new Item(i+1);
                    Kernels[i][j].AppointKernel();
                }
            }
        }
        public void DrawItems(Graphics graphics) 
        {
            foreach (Item item in Items)
            {
                item.Draw(graphics);
            }

            foreach (Item[] kernelSet in Kernels)
            {
                foreach(Item kernel in kernelSet)
                    kernel.Draw(graphics);
            }
        }

        public class Item
        {
            public int X { get; set; }
            public int Y { get; set; }
            public int Class { get; set; } = DEFAULT_CLASS_ID;
            public Color Color { get; set; } = DEFAULT_COLOR;
            public int Size { get; set; } = ITEM_SIZE;

            private const int ITEM_SIZE = 3;
            private const int KERNEL_SIZE = 7;
            private static Random _randomCoord = new Random();

            public Item()
            {
                X = _randomCoord.Next(-_contentWidth / 2, _contentWidth / 2);
                Y = _randomCoord.Next(-_contentHeight / 2, _contentHeight / 2);
            }

            public Item (int classID) : this() {
                Class = classID;
            }

            public void SetColor()
            {
                Color = COLORS[Class];
            }
            
            public void AppointKernel()
            {
                Color = KERNEL_COLORS[Class];
                Size = KERNEL_SIZE;
            }

            public void Draw(Graphics parent)
            {
                using (SolidBrush brush = new SolidBrush(Color))
                {
                    parent.FillRectangle(brush, X + (_contentWidth/2) - (Size / 2), Y + (_contentHeight / 2) - (Size / 2), Size, Size);
                }
            }
        }
    }
}
