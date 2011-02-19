using System;
using System.Collections.Generic;
using System.Text;

namespace NeanderSharp
{
    public class MemEntry
    {
        public byte Address { get; set; }
        public byte Data { get; set; }
        public MemEntry() { }
        public MemEntry(byte address, byte data)
        {
            Address = address;
            Data = data;
        }
    }
}
