//
//  Neander.m
//  Neander4iPhone
//
//  Created by Filipe Rodrigues on 2/15/11.
//  Copyright 2011 T&T. All rights reserved.
//

#import "MemReader.h"
#import "Neander.h"

@implementation Neander



-(id)init{
	self = [super init];
	if(self){
		[self reset];
	}
	return self;
}

-(id)initWithFile:(NSString*)path{
	self = [self init];
	MemReader *memReader = [MemReader new];
	[memReader initWithFile:path];
	[self reset];
	for (unsigned int i=0; i<256; i++) {
		[self setMemory:i :[memReader read:i]];
	}
	NSLog(@"Read to memory");
	return self;
}

-(void)setDelegate:(id)obj{
	delegate = obj;
}

-(void)reset{
	pc = 0;
	ac = 0;
}

@synthesize pc;

-(unsigned char) ac{
	return ac;
}

-(void) setAc:(unsigned char)newValue{
	ac = newValue;
	
	if(ac >=128){
		n = TRUE;
		z = FALSE;
	}
	else if (ac == 0){
		n = FALSE;
		z = TRUE;
	} 
	else {
		n = FALSE;
		z = FALSE;
	}
	
}
-(void) setMemory:(unsigned char)index:(unsigned char) value{
	memory[index] = value;
}
-(unsigned char) getMemory:(unsigned char) index{
	return memory[index];
}

-(unsigned char) step{
	unsigned char instruction = memory[pc++];
	unsigned char address = 0;
	int result;
	switch (instruction&240) {
		case (unsigned char)NOP:
			break;
		case (unsigned char)STA:
			address = memory[pc++];
			memory[address] = ac;
			break;
		case (unsigned char)LDA:
			address = memory[pc++];
			[self setAc:memory[address]];
			break;
		case (unsigned char)ADD:
			address = memory[pc++];
			result = memory[address] + ac;
			[self setAc:(unsigned char)result];
			break;
		case (unsigned char)OR:
			address = memory[pc++];
			result = memory[address] | ac;
			[self setAc:(unsigned char)result];
			break;
		case (unsigned char)AND:
			address = memory[pc++];
			result = memory[address] & ac;
			[self setAc:(unsigned char)result];
			break;
		case (unsigned char)NOT:
			result = 255 - ac;
			[self setAc:(unsigned char)result];
			break;
		case (unsigned char)JMP:
			address = memory[pc++];
			pc = address;
			break;
		case (unsigned char)JN:
			address = memory[pc++];
			if (n) pc = address;
			break;
		case (unsigned char)JZ:
			address = memory[pc++];
			if (z) pc = address;
			break;
		default:
			break;
	}
	
	[delegate stepped];
	
	return instruction;
}

-(void) run{
	unsigned char instruction = 0;
	while (instruction !=(unsigned char)HLT) {
		instruction = [self step];
	}
}

@end
