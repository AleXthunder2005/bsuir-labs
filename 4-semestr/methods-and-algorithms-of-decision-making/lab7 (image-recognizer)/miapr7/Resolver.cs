using System;
using System.Collections.Generic;
using System.Drawing;
using System.Net;
using System.Security.Cryptography;

namespace miapr7
{
    /*
     Number -> Digit | Digits
     Digits -> Digit Digits | null

     Digit → Zero | One | Two | Three | Four | Five | Six | Seven | Eight | Nine

     Zero -> (LUR, Horizontal)                 LUR - LeftUpRight
     LUR -> (LU, Vertical)                      LU - LeftUp
     LU -> (Vertical, Horizontal)

     One -> (Ascent, Vertical)

     Two -> (AlmostTwo, Horizontal)
     AlmostTwo -> (LeftBrace, Vertical)
     LeftBrace -> (LD, Horizontal)
     LD -> (Vertical, Horizontal)
     */
    public class Resolver
    {
        public const int TERMINAL_PAIR_DISTANCE = 30;
        public enum Direction 
        {
            Up,
            Right,
            Down,
            Left,
        }

        private List<Terminal> _cloneTerminals;
        private List<Terminal> _leftTerminals;

        public Resolver(List<Terminal> terminals)
        {
            _leftTerminals = new List<Terminal>();
            _cloneTerminals = new List<Terminal>();
            foreach (Terminal terminal in terminals)
            {
                _leftTerminals.Add(terminal.Clone());
                _cloneTerminals.Add(terminal.Clone());
            }
        }

        private List<Terminal> CloneList(List<Terminal> list) 
        {
            var newList = new List<Terminal>();
            foreach (Terminal terminal in list)
            {
                newList.Add(terminal.Clone());
            }

            return newList;
        }

        public List<int> Digit(out Point leftPoint)
        {
            List<int> nums = new List<int>(); 

            _leftTerminals = CloneList(_cloneTerminals);
            if (Eight(out leftPoint, _leftTerminals))
            {
                nums.Add(8);
            }

            if (Six(out leftPoint, _leftTerminals))
            {
                nums.Add(6);
            }

            if (Nine(out leftPoint, _leftTerminals))
            {
                nums.Add(9); 
            }

            if (Three(out leftPoint, _leftTerminals))
            {
                nums.Add(3); 
            }

            if (Zero(out leftPoint, _leftTerminals))             //rightPoint
            {
                nums.Add(0); 
            }

            if (One(out leftPoint, _leftTerminals))
            {
                nums.Add(1); 
            }

            if (Two(out leftPoint, _leftTerminals))
            {
                nums.Add(2); 
            }

            if (Four(out leftPoint, _leftTerminals))
            {
                nums.Add(4); 
            }

            if (Five(out leftPoint, _leftTerminals))
            {
                nums.Add(5);
            }

            if (Seven(out leftPoint, _leftTerminals))
            {
                nums.Add(7);
            }

            return nums;
        }

        //ZEROOOOOOOOOOOO
        private bool Zero(out Point rdPoint, List<Terminal> leftTerminals)
        {
            rdPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.LongVertical, Direction.Down, DlLU, leftTerminals, out rdPoint);
        }

        private bool DlLU (out Point ruPoint, List<Terminal> leftTerminals)
        {
            ruPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, DlL, leftTerminals, out ruPoint);
        }

        private bool DlL(out Point ulPoint, List<Terminal> leftTerminals)
        {
            ulPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.LongVertical, Direction.Up, D, leftTerminals, out ulPoint);
        }

        //D


        //ONEEEEEEEEEEEE
        private bool One(out Point rdPoint, List<Terminal> leftTerminals)
        {
            rdPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.LongVertical, Direction.Down, Asc, leftTerminals, out rdPoint);
        }

        private bool Asc(out Point ruPoint, List<Terminal> leftTerminals) 
        {
            ruPoint = new Point();
            return Terminal(miapr7.Terminal.TerminalType.Ascent, Direction.Up, leftTerminals, out ruPoint);
        }

        //TWOOOOOOOOOO

        private bool Two(out Point lPoint, List<Terminal> leftTerminals)
        {
            lPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, AlmostTwo, leftTerminals, out lPoint);
        }

        private bool AlmostTwo(out Point uPoint, List<Terminal> leftTerminals)
        {
            uPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, LeftBrace, leftTerminals, out uPoint);
        }

        private bool LeftBrace(out Point mrPoint, List<Terminal> leftTerminals)
        {
            mrPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, LD, leftTerminals, out mrPoint);
        }

        private bool LD(out Point mlPoint, List<Terminal> leftTerminals)
        {
            mlPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, D, leftTerminals, out mlPoint);
        }

        private bool D(out Point lPoint, List<Terminal> leftTerminals) 
        {
            lPoint = new Point();
            return Terminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, leftTerminals, out lPoint);
        }

        //THREEEEEEEE забили на нейм поинтов
        private bool Three(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, AlmostThree, leftTerminals, out luPoint);
        }
        private bool AlmostThree(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, ThreeRightBracket, leftTerminals, out luPoint);
        }
        private bool ThreeRightBracket(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, ThreeRD, leftTerminals, out luPoint, true);
        }
        private bool ThreeRD(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, ThreeD, leftTerminals, out luPoint);
        }
        private bool ThreeD(out Point lPoint, List<Terminal> leftTerminals)
        {
            lPoint = new Point();
            return Terminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, leftTerminals, out lPoint);
        }

        //FOOOOOUUUUUUUUURRRRRRR
        private bool Four (out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, AlmostFour, leftTerminals, out luPoint);
        }
        private bool AlmostFour(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, FourLongRight, leftTerminals, out luPoint);
        }
        private bool FourLongRight(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, FourR, leftTerminals, out luPoint, true);
        }

        private bool FourR(out Point lPoint, List<Terminal> leftTerminals)
        {
            lPoint = new Point();
            return Terminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, leftTerminals, out lPoint);
        }

        //FIVEEEEEEEEEEE
        private bool Five(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, AlmostFive, leftTerminals, out luPoint);
        }
        private bool AlmostFive(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, FiveRightBracket, leftTerminals, out luPoint);
        }
        private bool FiveRightBracket(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, FiveRD, leftTerminals, out luPoint );
        }
        private bool FiveRD(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, FiveD, leftTerminals, out luPoint);
        }

        private bool FiveD(out Point lPoint, List<Terminal> leftTerminals)
        {
            lPoint = new Point();
            return Terminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, leftTerminals, out lPoint);
        }

        //SIIIIIIIIIX
        private bool Six(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, AlmostSix, leftTerminals, out luPoint);
        }
        private bool AlmostSix(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.LongVertical, Direction.Up, SixRightBracket, leftTerminals, out luPoint);
        }
        private bool SixRightBracket(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, SixRD, leftTerminals, out luPoint);
        }
        private bool SixRD(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Down, SixM, leftTerminals, out luPoint);
        }

        private bool SixM(out Point lPoint, List<Terminal> leftTerminals)
        {
            lPoint = new Point();
            return Terminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, leftTerminals, out lPoint);
        }

        //SEEEEEEEEEVEN
        private bool Seven(out Point rdPoint, List<Terminal> leftTerminals)
        {
            rdPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, SevenAsc, leftTerminals, out rdPoint);
        }

        private bool SevenAsc(out Point ruPoint, List<Terminal> leftTerminals)
        {
            ruPoint = new Point();
            return Terminal(miapr7.Terminal.TerminalType.Ascent, Direction.Up, leftTerminals, out ruPoint);
        }


        //EEEEEEEEEIGHT
        private bool Eight(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, AlmostEight, leftTerminals, out luPoint);
        }
        private bool AlmostEight(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Down, EightHook, leftTerminals, out luPoint, true);
        }
        private bool EightHook(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Down, EightRightBracket, leftTerminals, out luPoint);
        }
        private bool EightRightBracket(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, EightLongRD, leftTerminals, out luPoint);
        }
        private bool EightLongRD(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, EightRD, leftTerminals, out luPoint);
        }
        private bool EightRD(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Up, EightD, leftTerminals, out luPoint);
        }

        private bool EightD(out Point lPoint, List<Terminal> leftTerminals)
        {
            lPoint = new Point();
            return Terminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, leftTerminals, out lPoint);
        }

        //SIIIIIIIIIX
        private bool Nine(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, AlmostNine, leftTerminals, out luPoint);
        }
        private bool AlmostNine(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortVertical, Direction.Down, NineRightBracket, leftTerminals, out luPoint);
        }
        private bool NineRightBracket(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Left, NineRD, leftTerminals, out luPoint);
        }
        private bool NineRD(out Point luPoint, List<Terminal> leftTerminals)
        {
            luPoint = new Point();
            return NonTerminal(miapr7.Terminal.TerminalType.LongVertical, Direction.Up, NineD, leftTerminals, out luPoint);
        }

        private bool NineD(out Point lPoint, List<Terminal> leftTerminals)
        {
            lPoint = new Point();
            return Terminal(miapr7.Terminal.TerminalType.ShortHorizontal, Direction.Right, leftTerminals, out lPoint);
        }





        public delegate bool NonTerminalCallback(out Point endPoint, List<Terminal> leftTerminals);


        private bool NonTerminal(
            Terminal.TerminalType type,
            Direction direction,
            NonTerminalCallback callback,
            List<Terminal> leftTerminals,
            out Point endPoint,
            bool needOldEndPoint = false
            )
        {
            endPoint = new Point();
            Point startPoint = new Point();

            List<Terminal> clonedLeftTerminals = CloneList(leftTerminals);
            List<Terminal> candidates = DiscardCandidates(leftTerminals, type);
            
            bool result = false;
            foreach (Terminal candidate in candidates)
            {
                //leftTerminals.Remove(candidate);

                int leftTerminalsCount = leftTerminals.Count;
                for (int i = 0; i < leftTerminalsCount; i++)
                {
                    if (callback.Invoke(out startPoint, leftTerminals) && CanJoin(candidate, startPoint, direction, out endPoint))
                    {
                        result = true;
                        if (needOldEndPoint) endPoint = startPoint;
                        break;
                    }
                    else
                    {
                        leftTerminals = clonedLeftTerminals;
                        if (leftTerminals.Count > 0)
                        {
                            Terminal term = leftTerminals[0];
                            leftTerminals.RemoveAt(0);
                            leftTerminals.Add(term);
                        }
                    }
                }
                if (result) break;
            }

            return result;
        }

        private bool Terminal (
            Terminal.TerminalType type,
            Direction direction,
            List<Terminal> leftTerminals,
            out Point endPoint)
        {
            endPoint = new Point();

            List<Terminal> candidates = DiscardCandidates(leftTerminals, type);

            if (candidates.Count == 0)
            {
                return false;
            }
            else
            {
                Terminal candidate = candidates[0];
                Found(candidate, direction, out endPoint);
                //leftTerminals.Remove(candidate);
                return true;
            }
        }

        private List<Terminal> DiscardCandidates(List<Terminal> leftTerminals, Terminal.TerminalType type) 
        {
            List<Terminal> candidates = new List<Terminal>();
            foreach (Terminal terminal in leftTerminals)
            {
                if (terminal.Type == type) 
                {
                    candidates.Add(terminal);
                }
            }
            return candidates;
        }


        private void Found(Terminal terminal, Direction direction, out Point endPoint) 
        {
            endPoint = new Point();
            Point newStart = new Point();
            Point newEnd = new Point();

            Point start = terminal.Start;
            Point end = terminal.End;

            switch (direction)
            {
                case Direction.Up:
                    newStart = start.Y > end.Y ? start : end;
                    newEnd = start.Y > end.Y ? end : start;
                    break;
                case Direction.Right:
                    newStart = start.X < end.X ? start : end;
                    newEnd = start.X < end.X ? end : start;
                    break;
                case Direction.Down:
                    newStart = start.Y < end.Y ? start : end;
                    newEnd = start.Y < end.Y ? end : start;
                    break;
                case Direction.Left:
                    newStart = start.X > end.X ? start : end;
                    newEnd = start.X > end.X ? end : start;
                    break;
            }

            endPoint = newEnd;
        }

        private bool CanJoin(Terminal terminal, Point startPoint, Direction direction, out Point endPoint)
        {
            endPoint = new Point();

            Point newStart = new Point();
            Point newEnd = new Point();

            Point start = terminal.Start;
            Point end = terminal.End;

            switch (direction)
            {
                case Direction.Up:
                    newStart = start.Y > end.Y ? start : end;
                    newEnd = start.Y > end.Y ? end : start;
                    break;
                case Direction.Right:
                    newStart = start.X < end.X ? start : end;
                    newEnd = start.X < end.X ? end : start;
                    break;
                case Direction.Down:
                    newStart = start.Y < end.Y ? start : end;
                    newEnd = start.Y < end.Y ? end : start;
                    break;
                case Direction.Left:
                    newStart = start.X > end.X ? start : end;
                    newEnd = start.X > end.X ? end : start;
                    break;
            }

            if (CalculateLineLength(newStart, startPoint) < TERMINAL_PAIR_DISTANCE)
            {
                endPoint = newEnd;
                return true;
            }

            return false;
        }

        public Point ReceiveEndPoint(Terminal terminal, Direction direction) 
        {
            Point start = terminal.Start;
            Point end = terminal.End;

            Point newEnd = new Point();

            switch (direction)
            {
                case Direction.Up:
                    newEnd = start.Y > end.Y ? end : start;
                    break;
                case Direction.Right:
                    newEnd = start.X < end.X ? end : start;
                    break;
                case Direction.Down:
                    newEnd = start.Y < end.Y ? end : start;
                    break;
                case Direction.Left:
                    newEnd = start.X > end.X ? end : start;
                    break;
            }

            return newEnd;
        }


        private int CalculateLineLength(Point start, Point end)
        {
            int deltaX = end.X - start.X;
            int deltaY = end.Y - start.Y;

            return (int)Math.Round(Math.Sqrt(deltaX * deltaX + deltaY * deltaY));
        }
    }
}
