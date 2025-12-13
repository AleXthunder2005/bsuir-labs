using System.Collections.Generic;
using System.Drawing;

namespace miapr7
{
    public class Drawer
    {

        public List<Terminal> Terminals { get; set; }

        public Drawer() 
        {
            Terminals = new List<Terminal>();
        }

        public void AddTerminal(Point start, Point end)
        {
            Terminal terminal = new Terminal(start, end);
            Terminals.Add(terminal);
        }

        public void ClearTerminals() 
        {
            Terminals.Clear();
        }

        public void UpdateGraphics(Graphics graphics)
        {
            if (Terminals != null)
            {
                graphics.Clear(Color.White);
                foreach (Terminal terminal in Terminals)
                {
                    terminal.Draw(graphics);
                }
            }
        }
        
    }
}
