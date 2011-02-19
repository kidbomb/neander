using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace NeanderSharp
{
    public class MemReader
    {
        BinaryReader br;
        public MemReader(string file)
        {
            br = new BinaryReader(new FileStream(file, FileMode.Open));
        }
        public byte ReadByte()
        {
            byte ret = br.ReadByte();
            br.ReadByte(); //swallow
            return ret;
        }
        public string ReadHeader()
        {
            byte[] header = br.ReadBytes(4);
            return "NDR";
        }
        public void Close()
        {
            br.Close();
        }
    }
}
