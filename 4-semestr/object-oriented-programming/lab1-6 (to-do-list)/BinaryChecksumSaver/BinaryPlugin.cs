using System;
using System.Linq;

namespace task_manager.Plugins
{
    public class BinaryPlugin
    {
        //алгоритм CRC-32
        private static readonly uint[] Table = new uint[256];
        private const uint Polynomial = 0xEDB88320;

        static BinaryPlugin()
        {
            for (uint i = 0; i < 256; i++)
            {
                uint crc = i;
                for (int j = 0; j < 8; j++)
                    crc = (crc >> 1) ^ ((crc & 1) * Polynomial);
                Table[i] = crc;
            }
        }

        public static uint ComputeChecksum(byte[] bytes)
        {
            uint crc = 0xFFFFFFFF;
            foreach (byte b in bytes)
                crc = (crc >> 8) ^ Table[(crc ^ b) & 0xFF];
            return crc ^ 0xFFFFFFFF;
        }

        public static byte[] SaveChecksum(byte[] data)
        {
            uint checksum = ComputeChecksum(data);

            return BitConverter.GetBytes(checksum).Concat(data).ToArray();
        }

        public static bool IsChecksumCorrect(byte[] fileData)
        {
            if (fileData.Length < 4)
                return false;

            uint savedChecksum = BitConverter.ToUInt32(fileData, 0);
            byte[] data = new byte[fileData.Length - 4];

            Buffer.BlockCopy(fileData, 4, data, 0, data.Length);

            uint actualChecksum = ComputeChecksum(data);
            if (actualChecksum != savedChecksum)
                return false;

            return true;
        }

        public static byte[] DiscardChecksum(byte[] fileData)
        {
            byte[] data = new byte[fileData.Length - 4];

            Buffer.BlockCopy(fileData, 4, data, 0, data.Length);
            return data;
        }
    }
}
