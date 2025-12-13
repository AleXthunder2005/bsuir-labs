using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using static miapr6.ChartBuilder;

namespace miapr6
{
    public class TableHandler
    {
        public float[][] DistanceTable { get; set; } = null;
        private int _objectCount;
        private Random _random;
        private const int MIN_DISTANCE = 25;
        private const int MAX_DISTANCE = 1000;

        private float[][] MergedTable { get; set; } = null;
        private Group[] groups;




        public TableHandler(int objectCount) 
        { 
            _objectCount = objectCount;
            _random = new Random();
        }

        public void GenerateDistanceTable() 
        { 
            DistanceTable = new float[_objectCount][];
            for (int i = 0; i < DistanceTable.Length; i++)
            {
                DistanceTable[i] = new float[_objectCount];
            }

            for (int i = 0; i < DistanceTable.Length; i++)
            {
                for (int j = i; j < DistanceTable[i].Length; j++)
                {
                    float value = (float)(_random.Next(MIN_DISTANCE, MAX_DISTANCE)) / 100; ;
                    DistanceTable[i][j] = DistanceTable[j][i] = value;
                }
            }

            for (int i = 0; i < DistanceTable.Length; i++) 
            {
                DistanceTable[i][i] = 0;
            }
        }

        private void InverseDistanceTable() 
        {
            for (int i = 0; i < DistanceTable.Length; i++)
            {
                for (int j = 0; j < DistanceTable[i].Length; j++)
                {
                    if (i == j) continue;

                    DistanceTable[i][j] = DistanceTable[i][j] == 0 ? 0 : 1 / DistanceTable[i][j];
                }
            }
        }

        public Group GroupingStart(bool isMaxCritery) 
        {
            InitializeGroups();
            if (isMaxCritery) InverseDistanceTable();

            MergedTable = DistanceTable;
            while (groups.Length > 1)
                MergeTable();

            return groups[0];
        }
        
        public void MergeTable() 
        {
            var mergedTable = new float[MergedTable.Length - 1][];
            for (int i = 0; i < MergedTable.Length - 1; i++)
            {
                mergedTable[i] = new float[MergedTable[i].Length - 1];
            }

            int firstIndex;
            int secondIndex;
            float distance = GetMinDistance(MergedTable, out firstIndex, out secondIndex);

            int row = 0;
            int col = 0;
            for (int i = 0; i < MergedTable.Length; i++) 
            {
                if ((i == firstIndex) || (i == secondIndex)) continue;

                col = 0;
                for (int j = 0; j <= i; j++) 
                {
                    if ((j == firstIndex) || (j == secondIndex)) continue;

                    mergedTable[row][col] = mergedTable[col][row] = MergedTable[i][j];
                    col++;
                }

                row++;
            }

            col = 0;
            for (int j = 0; j < MergedTable.Length; j++) 
            {
                if ((j == firstIndex) || (j == secondIndex)) continue;

                mergedTable[row][col] = mergedTable[col][row] = Math.Min(MergedTable[firstIndex][j], MergedTable[secondIndex][j]);
                col++;
            }
            mergedTable[row][col] = 0;



            MergeGroupsArray(distance, firstIndex, secondIndex);
            MergedTable = mergedTable;

        }


        private float GetMinDistance(float[][] table, out int firstIndex, out int secondIndex)
        {
            float minDistance = float.MaxValue;
            firstIndex = 0;
            secondIndex = 0;

            for (int i = 0; i < table.Length; i++)
            {
                for (int j = i; j < table[i].Length; j++)
                {
                    if (i == j) continue;

                    if (table[i][j] < minDistance) 
                    { 
                        minDistance = table[i][j];
                        firstIndex = i;                       //нумерация от нуля
                        secondIndex = j;
                    }
                }
            }

            return minDistance;
        }

        private void InitializeGroups() 
        { 
            groups = new Group[_objectCount];
            for (int i = 0; i < groups.Length; i++) 
            {
                groups[i] = new Group(i);
            }
        }

        private void MergeGroupsArray(float distance, int firstIndex, int secondIndex) 
        {
            int index = 0;
            
            Group[] newMergedGroups = new Group[groups.Length - 1];
            for (int i = 0; i < groups.Length; i++)
            {
                if ((i == firstIndex) || (i == secondIndex)) continue;

                newMergedGroups[index++] = groups[i];
            }

            newMergedGroups[index] = new Group(distance, groups[firstIndex], groups[secondIndex]);

            groups = newMergedGroups;
        }
    }
}
