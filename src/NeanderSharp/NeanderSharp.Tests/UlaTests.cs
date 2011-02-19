using System;
using System.Text;
using System.Collections.Generic;

using Microsoft.VisualStudio.TestTools.UnitTesting;
using NeanderSharp;

namespace NeanderSharp.Tests
{
    /// <summary>
    /// Summary description for UnitTest1
    /// </summary>
    [TestClass]
    public class UlaTests
    {

        [TestMethod]
        public void TestSta()
        {
            Neander n = new Neander();
            //STA end: MEM(end) ← AC
            n.AC = 24;
            n.Memory[0] = (byte)Command.STA;
            n.Memory[1] = 255;
            n.Memory[2] = (byte)Command.HLT;

            n.Run();
            Console.WriteLine(n.PC);
            Assert.AreEqual(n.Memory[255], 24);
        }

        [TestMethod]
        public void TestStaDontCare()
        {
            Neander n = new Neander();
            //STA end: MEM(end) ← AC
            n.AC = 24;
            n.Memory[0] = 23;
            n.Memory[1] = 255;
            n.Memory[2] = (byte)Command.HLT;

            n.Run();
            Console.WriteLine(n.PC);
            Assert.AreEqual(n.Memory[255], 24);
        }

        [TestMethod]
        public void TestLDA()
        {
            Neander n = new Neander();
            //LDA end: AC← MEM(end)

            n.Memory[0] = (byte)Command.LDA;
            n.Memory[1] = 255;
            n.Memory[2] = (byte)Command.HLT;

            n.Memory[255] = 24;
            n.Run();
            Assert.AreEqual(n.AC, 24);
        }
        [TestMethod]
        public void TestADD1()
        {
            Neander n = new Neander();
            //ADD end: AC← MEM(end) + AC
            n.AC = 6;
            n.Memory[0] = (byte)Command.ADD;
            n.Memory[1] = 255;
            n.Memory[2] = (byte)Command.HLT;

            n.Memory[255] = 24;
            n.Run();
            Assert.AreEqual(n.AC, 30);
        }
        [TestMethod]
        public void TestADD_Overflow()
        {
            Neander n = new Neander();
            //ADD end: AC← MEM(end) + AC
            n.AC = 2;
            n.Memory[0] = (byte)Command.ADD;
            n.Memory[1] = 255;
            n.Memory[2] = (byte)Command.HLT;

            n.Memory[255] = 255;
            n.Run();
            Assert.AreEqual(n.AC, 1);
        }

        private void ReadMemToNeander(string file, Neander n)
        {
            MemReader r = new MemReader(file);
            r.ReadHeader();
            for (int i = 0; i <= 255; i++)
            {
                n.Memory[i] = r.ReadByte();
            }
        }

        [TestMethod]
        public void TestReadMEMFile()
        {
            Neander n = new Neander();
            ReadMemToNeander(@"C:\Users\Kidbomb\git\Simple-C-Compiler\exemplo.MEM", n);
            n.Run();
        }
    }
}
