//
//  SimpleTests.h
//  Neander4iPhone
//
//  Created by Filipe Rodrigues on 2/15/11.
//  Copyright 2011 T&T. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

#define USE_APPLICATION_UNIT_TEST 1

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

//#import "application_headers" as required


@interface SimpleTests : SenTestCase {

}

- (void) testSta;
- (void) testStaDontCare;
- (void) testLda;
- (void) testAdd1;
- (void) testAddWithOverflow;

@end

/*

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
 */

/*
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
 */