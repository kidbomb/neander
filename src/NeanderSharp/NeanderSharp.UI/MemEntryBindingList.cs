using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Diagnostics;

namespace NeanderSharp
{
    public class MemEntryBindingList : BindingList<MemEntry>
    {
        BindingList<byte> _innerList;
        public MemEntryBindingList(BindingList<byte> innerList)
        {
            _innerList = innerList;
            innerList.ListChanged += new ListChangedEventHandler(innerList_ListChanged);
            for (int i = 0; i < innerList.Count; i++)
            {
                Add(new MemEntry((byte)i, innerList[i]));
            }
        }

        void innerList_ListChanged(object sender, ListChangedEventArgs e)
        {
            this[e.NewIndex].Data = _innerList[e.NewIndex];
            // Debug.WriteLine("[listchanged] " + Enum.GetName(typeof(ListChangedType), e.ListChangedType));
        }
    }
}
