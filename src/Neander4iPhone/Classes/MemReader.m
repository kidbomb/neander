//
//  MemReader.m
//  Neander4iPhone
//
//  Created by Filipe Rodrigues on 7/19/12.
//  Copyright 2012 T&T. All rights reserved.
//

#import "MemReader.h"


@implementation MemReader
- (void) initWithFile:(NSString*)path{
	
	fileManager = [NSFileManager defaultManager];
	
	NSString *memFile = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
	if ([fileManager fileExistsAtPath:memFile]== YES) {
		NSLog(@"File exists");
		memFileStream =  [[NSInputStream alloc] initWithFileAtPath:memFile];
		[memFileStream open];
		
		//polling?
		_data = [[NSMutableData data] retain];

		uint8_t buffer[516] ; //256(memory)*2+4(header)
		unsigned int len = 0;
		len = [memFileStream read:buffer maxLength:1024];
		if(len){
			[_data appendBytes:(const void *)buffer length:len];
			bytesRead +=len;
		}
		[memFileStream close];
		
		
	} else {
		NSLog(@"File does not exists");
	}
}

- (unsigned char) read:(unsigned char)address{
	return ((unsigned char*) [_data mutableBytes])[(address*2)+4];
}

@end
