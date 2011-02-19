using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using NeanderSharp;
using System.Text.RegularExpressions;

namespace Daedalus
{
    struct Instruction {
        public Command Command;
        public string Label;
    }
    class AsmReader
    {
        StringReader sr;
        public AsmReader(string asm)
        {
            sr = new StringReader(asm);
        }
        public Instruction ReadInstruction()
        {
            string line = sr.ReadLine().Trim();
            string[] lineSplit = Regex.Split(line, @"\w*");
            Instruction instruction = new Instruction();
            instruction.Command = (Command)Enum.Parse(typeof(Command), lineSplit[0]);
            if(lineSplit.Length > 1) instruction.Label = lineSplit[1];
            return instruction;
        }

    }
}
