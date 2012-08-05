#!/usr/bin/env python
import sys
import string
import struct

if len(sys.argv) <= 2:
	print "Usage: asm2mem file.asm file.mem"
	exit(1)

asm_file = open(sys.argv[1])

pc=0
labels = {}

for line in asm_file:

	if ':' in line: #has label
		double_colon_index = string.find(line, ':')
		label = line[0:double_colon_index].strip()
		labels[label] = pc
		line = line[double_colon_index+1:]

	line = line.strip()
	if line.startswith('STA'):
		pc+=2
	elif line.startswith('LDA'):
		pc+=2
	elif line.startswith('ADD'):
		pc+=2
	elif line.startswith('OR '):
		pc+=2
	elif line.startswith('AND'):
		pc+=2
	elif line.startswith('NOT'):
		pc+=1
	elif line.startswith('JMP'):
		pc+=2
	elif line.startswith('JN'):
		pc+=2
	elif line.startswith('JZ'):
		pc+=2
	elif line.startswith('HLT'):
		pc+=1
	elif line.startswith('NOP'):
		pc+=1
	elif line.startswith('ORG'):
		pc=int(line.split()[1])
	elif line.startswith('DB'):
		pc+=1

#read again
pc=0
asm_file.seek(0)

mem_file = open(sys.argv[2], 'w')

mem_file.write(struct.pack('bccc', 3, 'N', 'D', 'R'))

for line in asm_file:

	if ':' in line: #has label
		double_colon_index = string.find(line, ':')
		line = line[double_colon_index+1:]

	line = line.strip()
	if line.startswith('STA'):
		mem_file.write(struct.pack('BBBB', 16, 0, int(labels[line.split()[1]]), 0))
		pc+=2
	elif line.startswith('LDA'):
		mem_file.write(struct.pack('BBBB', 32, 0, int(labels[line.split()[1]]), 0))
		pc+=2
	elif line.startswith('ADD'):
		mem_file.write(struct.pack('BBBB', 48, 0, int(labels[line.split()[1]]), 0))
		pc+=2
	elif line.startswith('OR '):
		mem_file.write(struct.pack('BBBB', 64, 0, int(labels[line.split()[1]]), 0))
		pc+=2
	elif line.startswith('AND'):
		mem_file.write(struct.pack('BBBB', 80, 0, int(labels[line.split()[1]]), 0))
		pc+=2
	elif line.startswith('NOT'):
		mem_file.write(struct.pack('BB', 96, 0))
		pc+=1
	elif line.startswith('JMP'):
		mem_file.write(struct.pack('BBBB', 128, 0, int(labels[line.split()[1]]), 0))
		pc+=2
	elif line.startswith('JN'):
		mem_file.write(struct.pack('BBBB', 144, 0, int(labels[line.split()[1]]), 0))
		pc+=2
	elif line.startswith('JZ'):
		mem_file.write(struct.pack('BBBB', 160, 0, int(labels[line.split()[1]]), 0))
		pc+=2
	elif line.startswith('HLT'):
		mem_file.write(struct.pack('BB', 240, 0))
		pc+=1
	elif line.startswith('ORG '):
		new_pc = int(line.split()[1])
		while(pc < new_pc):
			mem_file.write(struct.pack('BB', 0, 0))
			pc+=1
	elif line.startswith('DB '):
		mem_file.write(struct.pack('BB', int(line.split()[1]), 0))
		pc+=1


while(pc <= 255):
	mem_file.write(struct.pack('BB', 0, 0))
	pc+=1


asm_file.close()
mem_file.close()

	

