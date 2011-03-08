from neander import *
import unittest

class CalculatorTestNeander(unittest.TestCase):

	def setUp(self):
		self.neander = Neander()
		#self.neander.from_file('/home/kidbomb/git/simple-c-compiler/mem/neander/calculadora-bjurkowski.mem')#7
		#self.neander.from_file('/home/kidbomb/git/simple-c-compiler/mem/neander/calculadora-lfzawacki.mem')#7
		#self.neander.from_file('/home/kidbomb/git/simple-c-compiler/mem/neander/calculadora-cmdalbem.mem')#OK
		self.neander.from_file('/home/kidbomb/git/simple-c-compiler/mem/neander/calculadora-labianchin.mem')#OK

	def test_case1(self):
		self.neander.reset()
		self.neander.memory[128] = 1
		self.neander.memory[129] = 128
		self.neander.memory[130] = 8
		self.neander.run()

		self.assertEqual(self.neander.memory[131], 8)

	def test_case2(self):
		self.neander.reset()
		self.neander.memory[128] = 3
		self.neander.memory[129] = 44
		self.neander.memory[130] = 1
		self.neander.run()

		self.assertEqual(self.neander.memory[131], 43)

	def test_case3(self):
		self.neander.reset()
		self.neander.memory[128] = 1
		self.neander.memory[129] = 29
		self.neander.memory[130] = 1
		print "Start run"
		self.neander.run()

		self.assertEqual(self.neander.memory[131], 30)

	def test_case4(self):
		self.neander.reset()
		self.neander.memory[128] = 15
		self.neander.memory[129] = 115
		self.neander.memory[130] = 15
		self.neander.run()

		self.assertEqual(self.neander.memory[131], 57)

	def test_case5(self):
		self.neander.reset()
		self.neander.memory[128] = 7
		self.neander.memory[129] = 105
		self.neander.memory[130] = 127
		self.neander.run()

		self.assertEqual(self.neander.memory[131], 210)

	def test_case6(self):
		self.neander.reset()
		self.neander.memory[128] = 3
		self.neander.memory[129] = 47
		self.neander.memory[130] = 3
		self.neander.run()

		self.assertEqual(self.neander.memory[131], 44)

	def test_case7(self):
		self.neander.reset()
		self.neander.memory[128] = 7
		self.neander.memory[129] = 122
		self.neander.memory[130] = 100
		self.neander.run()

		self.assertEqual(self.neander.memory[131], 244)

	def test_case8(self):
		self.neander.reset()
		self.neander.memory[128] = 15
		self.neander.memory[129] = 28
		self.neander.memory[130] = 0
		self.neander.run()

		self.assertEqual(self.neander.memory[131], 14)

if __name__ == '__main__':
	unittest.main()
