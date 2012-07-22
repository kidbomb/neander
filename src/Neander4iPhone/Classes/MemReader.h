//
//  MemReader.h
//  Neander4iPhone
//
//  Created by Filipe Rodrigues on 7/19/12.
//  Copyright 2012 T&T. All rights reserved.
//


@interface MemReader : NSObject<NSStreamDelegate> {
	NSMutableData * _data;
	int bytesRead;
	NSFileManager *fileManager;
	NSInputStream *memFileStream;
}

- (void) initWithFile:(NSString*)path;
- (unsigned char) read:(unsigned char)address;


@end
