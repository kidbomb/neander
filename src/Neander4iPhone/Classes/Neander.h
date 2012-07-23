//
//  Neander.h
//  Neander4iPhone
//
//  Created by Filipe Rodrigues on 2/15/11.
//  Copyright 2011 T&T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@protocol NeanderDelegate

-(void)stepped;

@end


@interface Neander : NSObject {
	unsigned char ac;
	unsigned char pc;
	bool n;
	bool z;
	unsigned char memory[256];
	
	id<NeanderDelegate> delegate;
}

@property (nonatomic) unsigned char pc;
@property (nonatomic) unsigned char ac;
-(id) init;
-(id)initWithFile:(NSString*)path;
-(void)setDelegate:(id)obj;
-(void) reset;
-(void) setMemory:(unsigned char)index:(unsigned char) value;
-(unsigned char) getMemory:(unsigned char) index;
-(unsigned char) step;
-(void) run;


@end
