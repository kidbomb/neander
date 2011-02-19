using System;
using System.Text;
using System.Collections.Generic;

using Microsoft.VisualStudio.TestTools.UnitTesting;
using NeanderSharp;

namespace TestsNeander
{
    /// <summary>
    /// Summary description for CalculetorTests
    /// </summary>
    [TestClass]
    public class CalculatorTests
    {
        string memfile;
        Neander n;
        public CalculatorTests()
        {
            //memfile = @"C:\Users\Filipe\Documents\git\Simple-C-Compiler\mem\neander\calculadora-lfzawacki.mem";
            //memfile = @"C:\Users\Filipe\Documents\git\Simple-C-Compiler\mem\neander\calculadora-bjurkowski.MEM";
            //memfile = @"C:\Users\Filipe\Documents\git\Simple-C-Compiler\mem\neander\calculadora-cmdalbem.MEM";
            memfile = @"C:\Users\Filipe\Documents\git\Simple-C-Compiler\mem\neander\calculadora-labianchin.mem";
            n = new Neander();
            ReadMemToNeander(memfile, n);
        }

        private void ReadMemToNeander(string file, Neander n)
        {
            MemReader r = new MemReader(file);
            r.ReadHeader();
            for (int i = 0; i <= 255; i++)
            {
                n.Memory[i] = r.ReadByte();
            }
            r.Close();
        }

        [TestMethod]
        public void Case1()
        {
            //caso 1
            n.Reset();
            n.Memory[128] = 1;
            n.Memory[129] = 128;
            n.Memory[130] = 8;
            n.Run();
            Assert.AreEqual(8, n.Memory[131]);
        }


        [TestMethod]
        public void Case2()
        {
            //caso 2
            n.Reset();
            n.Memory[128] = 3;
            n.Memory[129] = 44;
            n.Memory[130] = 1;
            n.Run();
            Assert.AreEqual(43, n.Memory[131]);
        }

        [TestMethod]
        public void Case3()
        {
            //caso 3
            n.Reset();
            n.Memory[128] = 1;
            n.Memory[129] = 29;
            n.Memory[130] = 1;
            n.Run();
            Assert.AreEqual(30, n.Memory[131]);
        }

        [TestMethod]
        public void Case4()
        {
            //caso 4
            n.Reset();
            n.Memory[128] = 15;
            n.Memory[129] = 115;
            n.Memory[130] = 15;
            n.Run();
            Assert.AreEqual(57, n.Memory[131]);
        }
        [TestMethod]
        public void Case5()
        {
            //caso 5
            n.Reset();
            n.Memory[128] = 7;
            n.Memory[129] = 105;
            n.Memory[130] = 127;
            n.Run();
            Assert.AreEqual(210, n.Memory[131]);
        }

        [TestMethod]
        public void Case6()
        {
            //caso 6
            n.Reset();
            n.Memory[128] = 3;
            n.Memory[129] = 47;
            n.Memory[130] = 3;
            n.Run();
            Assert.AreEqual(44, n.Memory[131]);
        }

        [TestMethod]
        public void Case7()
        {
            //caso 7
            n.Reset();
            n.Memory[128] = 7;
            n.Memory[129] = 122;
            n.Memory[130] = 100;
            n.Run();
            Assert.AreEqual(244, n.Memory[131]);
        }

        [TestMethod]
        public void Case8()
        {
            //caso 8
            n.Reset();
            n.Memory[128] = 15;
            n.Memory[129] = 28;
            n.Memory[130] = 0;
            n.Run();
            Assert.AreEqual(14, n.Memory[131]);
        }

        [TestMethod]
        public void Case9()
        {
            //caso 9
            n.Reset();
            n.Memory[128] = 1;
            n.Memory[129] = 156;
            n.Memory[130] = 8;
            n.Run();
            Assert.AreEqual(20, n.Memory[131]);
        }

        [TestMethod]
        public void Case10()
        {
            //caso 10
            n.Reset();
            n.Memory[128] = 3;
            n.Memory[129] = 144;
            n.Memory[130] = 1;
            n.Run();
            Assert.AreEqual(15, n.Memory[131]);
        }

        [TestMethod]
        public void Case11()
        {
            //caso 11
            n.Reset();
            n.Memory[128] = 1;
            n.Memory[129] = 129;
            n.Memory[130] = 1;
            n.Run();
            Assert.AreEqual(0, n.Memory[131]);
        }

        [TestMethod]
        public void Case12()
        {
            //caso 8
            n.Reset();
            n.Memory[128] = 15;
            n.Memory[129] = 130;
            n.Memory[130] = 1;
            n.Run();
            Assert.AreEqual(1, n.Memory[131]);
        }

        [TestMethod]
        public void Case13()
        {
            //caso 13
            n.Reset();
            n.Memory[128] = 7;
            n.Memory[129] = 0;
            n.Memory[130] = 127;
            n.Run();
            Assert.AreEqual(0, n.Memory[131]);
        }

        [TestMethod]
        public void Case14()
        {
            //caso 14
            n.Reset();
            n.Memory[128] = 3;
            n.Memory[129] = 130;
            n.Memory[130] = 131;
            n.Run();
            Assert.AreEqual(1, n.Memory[131]);
        }

        [TestMethod]
        public void Case15()
        {
            //caso 15
            n.Reset();
            n.Memory[128] = 7;
            n.Memory[129] = 122;
            n.Memory[130] = 100;
            n.Run();
            Assert.AreEqual(244, n.Memory[131]);
        }

        [TestMethod]
        public void Case16()
        {
            //caso 16
            n.Reset();
            n.Memory[128] = 15;
            n.Memory[129] = 127;
            n.Memory[130] = 0;
            n.Run();
            Assert.AreEqual(63, n.Memory[131]);
        }

    }
}
