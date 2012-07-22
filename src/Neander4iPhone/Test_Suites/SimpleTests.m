//
//  SimpleTests.m
//  Neander4iPhone
//
//  Created by Filipe Rodrigues on 2/15/11.
//  Copyright 2011 T&T. All rights reserved.
//

#import "SimpleTests.h"
#import "Neander.h"


@implementation SimpleTests

// all code under test must be linked into the Unit Test bundle

- (void) testSta {
    Neander* n = [[Neander new] init];
	[n setAc:24];
	[n setMemory:0 :(unsigned char)STA];
	[n setMemory:1 :255];
	[n setMemory:2 :(unsigned char)HLT];
	[n run];
    STAssertTrue([n getMemory:255] ==24, @"Error in STA" );
    
}

- (void) testStaDontCare {
    Neander* n = [[Neander new] init];
	[n setAc:24];
	[n setMemory:0 :23];
	[n setMemory:1 :255];
	[n setMemory:2 :(unsigned char)HLT];
	[n run];
    STAssertTrue([n getMemory:255] ==24, @"Error in STA" );
    
}

- (void) testLda {
    Neander* n = [[Neander new] init];
	
	[n setMemory:0 :(unsigned char)LDA];
	[n setMemory:1 :255];
	[n setMemory:2 :(unsigned char)HLT];
	
	[n setMemory:255 :24];
	[n run];
    STAssertTrue([n ac] ==24, @"Error in LDA" );
    
}

- (void) testAdd1 {
    Neander* n = [[Neander new] init];
	
	[n setAc:6];
	[n setMemory:0 :(unsigned char)ADD];
	[n setMemory:1 :255];
	[n setMemory:2 :(unsigned char)HLT];
	
	[n setMemory:255 :24];
	[n run];
    STAssertTrue([n ac] ==30, @"Error in ADD" );
    
}

- (void) testAddWithOverflow {
    Neander* n = [[Neander new] init];
	
	[n setAc:2];
	[n setMemory:0 :(unsigned char)ADD];
	[n setMemory:1 :255];
	[n setMemory:2 :(unsigned char)HLT];
	
	[n setMemory:255 :255];
	[n run];
    STAssertTrue([n ac] ==1, @"Error in ADD" );
}




@end
