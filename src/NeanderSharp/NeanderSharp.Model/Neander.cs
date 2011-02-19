using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Diagnostics;

namespace NeanderSharp
{
    public enum Command : byte
    {
        NOP = 0,
        STA = 16,
        LDA = 32,
        ADD = 48,
        OR = 64,
        AND = 80,
        NOT = 96,
        JMP = 128,
        JN = 144,
        JZ = 160,
        HLT = 240
    }
    public class Neander: INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        public Memory Memory;
        byte ac;
        byte pc;
        bool n;
        bool z;
        public Neander()
        {
            Memory = new Memory(256);
            Reset();
        }
        public void Reset()
        {
            AC = 0;
            PC = 0;
        }
        public byte PC
        {
            get { return pc; }
            set 
            { 
                pc = value;
                OnPropertyChanged("PC");
            }
        }

        public byte AC
        {
            get
            {
                return ac;
            }
            set
            {
                ac = value;
                if (ac >= 128)
                {
                    n = true;
                    z = false;
                }
                else if (ac == 0)
                {
                    n = false;
                    z = true;
                } 
                else 
                {
                    n = false;
                    z = false;
                }
                OnPropertyChanged("AC");
            }
        }

        protected void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(name));
            }
        }

        public byte Step()
        {
            if (PC == 255) throw new IndexOutOfRangeException("End of program counter");
            byte instruction = Memory[PC++];
            byte address = 0;
            int result;
            switch (instruction&240)
            {
                case (byte)Command.NOP:
                    break;
                case (byte)Command.STA:
                    address = Memory[PC++];
                    Memory[address] = AC;
                    break;
                case (byte)Command.LDA:
                    address = Memory[PC++];
                    AC = Memory[address];
                    break;
                case (byte)Command.ADD:
                    address = Memory[PC++];
                    result = Memory[address] + AC;
                    AC = (byte)result;
                    break;
                case (byte)Command.OR:
                    address = Memory[PC++];
                    result = Memory[address] | AC;
                    AC = (byte)result;
                    break;
                case (byte)Command.AND:
                    address = Memory[PC++];
                    result = Memory[address] & AC;
                    AC = (byte)result;
                    break;
                case (byte)Command.NOT:
                    result = 255 - AC;
                    AC = (byte)result;
                    break;
                case (byte)Command.JMP:
                    address = Memory[PC++];
                    PC = address;
                    break;
                case (byte)Command.JN:
                    address = Memory[PC++];
                    if (n) PC = address;
                    break;
                case (byte)Command.JZ:
                    address = Memory[PC++];
                    if (z) PC = address;
                    break;
            }
            Debug.WriteLine("[command] " + Enum.GetName(typeof(Command), instruction));
            if (address > 0) Debug.WriteLine("[address] " + address);
            Debug.WriteLine("[AC] " + AC);

            return instruction;
        }
        public void Run()
        {
            int numInstructionRun = 0;
            byte instruction = 0;
            while (instruction != (byte)Command.HLT && PC <=255)
            {
                instruction = Step();
                numInstructionRun++;
                Debug.WriteLine("[instruction] " + numInstructionRun.ToString());
            }
        }
    }
}
