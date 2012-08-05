from array import array
class Command:
	NOP = 0
	STA = 16
	LDA = 32
	ADD = 48
	OR = 64
	AND = 80
	NOT = 96
	JMP = 128
	JN = 144
	JZ = 160
	HLT = 240

class CommandFormatter:
	def format(self,command):
		if command == Command.NOP:
			return "NOP"
		elif command == Command.STA:
			return "STA"
		elif command == Command.LDA:
			return "LDA"
		elif command == Command.STA:
			return "STA"
		elif command == Command.ADD:
			return "ADD"
		elif command == Command.OR:
			return "OR"
		elif command == Command.AND:
			return "AND"
		elif command == Command.NOT:
			return "NOT"
		elif command == Command.JMP:
			return "JMP"
		elif command == Command.JN:
			return "JN"
		elif command == Command.JZ:
			return "JZ"
		elif command == Command.HLT:
			return "HLT"

class Neander(object):
	def __init__(self):
		self.memory = [0] * 256
		self.reset()

	def reset(self):
		self.ac = 0
		self.pc = 0
	
	@property
	def ac(self):
		return self._ac

	@ac.setter
	def ac(self, value):
		self._ac = value
		if self._ac >= 128:
			self.n = True
			self.z = False
		elif self._ac == 0:
			self.n = False
			self.z = True
		else:
			self.n = False
			self.z = False


	def fetch(self):
		fetched_value = self.memory[self.pc]
		self.pc = self.pc+1
		return fetched_value

	def step(self):
		instruction = self.fetch()
		instruction = instruction&240
		address = 0
		if instruction == Command.STA:
			address = self.fetch()
			self.memory[address] = self.ac
		elif instruction == Command.LDA:
			address = self.fetch()
			self.ac = self.memory[address]
		elif instruction == Command.ADD:
			address = self.fetch()
			result = self.memory[address] + self.ac
			if(result > 255): # overflow
				result = result - 256
			self.ac = result

		elif instruction == Command.OR:
			address = self.fetch()
			result = self.memory[address] | self.ac
			self.ac = result
		elif instruction == Command.AND:
			address = self.fetch()
			result = self.memory[address] & self.ac
			self.ac = result
		elif instruction == Command.NOT:
			result = 255 - self.ac
			self.ac = result
		elif instruction == Command.JMP:
			address = self.fetch()
			self.pc = address
		elif instruction == Command.JN:
			address = self.fetch()
			if self.n:
				self.pc = address
		elif instruction == Command.JZ:
			address = self.fetch()
			if self.z:
				self.pc = address

		self.on_stepped();

		return instruction

	def run(self):
		instruction = 0
		while instruction != Command.HLT and self.pc <=255:
			instruction = self.step()

	def from_file(self, filename):
		self.reset()
		reader = NeanderMemReader(filename)
		reader.read_header()
		for i in range(256):
			self.memory[i] = reader.read()
		reader.close()

	def set_stepped_function(self, f):
		self.on_stepped = f

class NeanderMemReader:
	def __init__(self, filename):
		self.f = open(filename, 'r')

	def read_header(self):
		self.f.read(4)

	def read(self):
		mem_value = ord(self.f.read(1))
		self.f.read(1) #swallow
		return mem_value

	def close(self):
		self.f.close()

