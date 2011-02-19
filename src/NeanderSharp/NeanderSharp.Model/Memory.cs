using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace NeanderSharp
{
    public class Memory : BindingList<byte>

    {
        public Memory(int memorySize)
        {
            for (int i = 0; i <= memorySize-1; i++)
            {
                Add(0);
            }
        }
    }
}
