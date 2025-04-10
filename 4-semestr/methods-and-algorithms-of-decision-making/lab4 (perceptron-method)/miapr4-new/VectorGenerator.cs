using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace miapr4_new
{
    class VectorGenerator
    {
        private Random _random = new Random();
        private int _signCount = 1;

        private const int FREE_MEMBER = 1;
        
        public VectorGenerator() 
        { 
        }

        public void InitializeGenerator(int signCount) 
        { 
            _signCount = signCount;
        }

        public Vector[] GenerateVectors(int vectorCount)
        {
            Vector[] vectors = new Vector[vectorCount];
            for (int i = 0; i < vectorCount; i++)
            {
                vectors[i] = new Vector(_signCount, _random);
            }

            return vectors;
        }

        public Vector[] GenerateVectors(int vectorCount, int vectorSize, int defaultValue)
        {
            Vector[] vectors = new Vector[vectorCount];
            for (int i = 0; i < vectorCount; i++)
            {
                vectors[i] = new Vector(vectorSize, defaultValue);
            }

            return vectors;
        }

        public Vector[] GenerateExtendedVectors(int vectorCount)
        {
            Vector[] vectors = new Vector[vectorCount];
            for (int i = 0; i < vectorCount; i++)
            {
                vectors[i] = new Vector(_signCount+1, _random);
                vectors[i].Rates[_signCount] = FREE_MEMBER;
            }

            return vectors;
        }

        public void DistributeByClasses(Vector[] vectors, int classObjectCount)
        {
            for (int i = 0; i < vectors.Length; i++) 
            {
                vectors[i].Class = (i + classObjectCount) / classObjectCount;
            }
        }

    }
}
