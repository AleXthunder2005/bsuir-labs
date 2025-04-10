using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static miapr5.ItemsGenerator;
using static miapr5.Trainer;

namespace miapr5
{
    public class Classificator
    {
        private Item[] _items;
        private Vector _sumPotential;

        public Classificator(Item[] items, Vector sumPotemtial) 
        { 
            _items = items;
            _sumPotential = sumPotemtial;
        }
        public void StartClassification() 
        {
            for (int i = 0; i < _items.Length; i++)
            {
                _items[i].Class = (_sumPotential.Substitute(_items[i]) > 0) ?  1 : 2;
                _items[i].SetColor();
            }
        }
    }
}
