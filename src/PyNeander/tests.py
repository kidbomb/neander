from neander import *
import unittest

class TestNeander(unittest.TestCase):

	def setUp(self):
		self.neander = Neander()

	def test_sta(self):
		self.neander.reset()
		self.neander.ac = 24
		self.neander.memory[0] = Command.STA
		self.neander.memory[1] = 255
		self.neander.memory[2] = Command.HLT

		self.neander.run()
		
		self.assertEqual(self.neander.memory[255], 24)

	def test_sta_dontcare(self):
		self.neander.reset()
		self.neander.ac = 24
		self.neander.memory[0] = 23 #STA
		self.neander.memory[1] = 255
		self.neander.memory[2] = Command.HLT

		self.neander.run()

		self.assertEqual(self.neander.memory[255], 24)

	def test_lda(self):
		self.neander.reset()
        
		self.neander.memory[0] = Command.LDA
		self.neander.memory[1] = 255
		self.neander.memory[2] = Command.HLT

		self.neander.memory[255] = 24
		self.neander.run()

		self.assertEqual(self.neander.ac, 24)


if __name__ == '__main__':
	unittest.main()
