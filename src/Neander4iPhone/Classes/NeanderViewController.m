//
//  NeanderViewController.m
//
//  Created by Filipe Rodrigues on 7/22/12.
//  Copyright 2012 T&T. All rights reserved.
//

#import "NeanderViewController.h"
#import "NeanderView.h"

@implementation NeanderViewController

-(IBAction) openFileClicked:(id)sender{
	neander = [[Neander new] initWithFile:@"programaNeander.mem"];
	[neander setDelegate:self];
	for (unsigned int i=0; i < 256; i++) {
		NSLog(@"Red address %d [%d]", i, [neander getMemory:i]);
	}
	
}

-(IBAction) runButtonClicked:(id)sender{
	[neander run];
	NSLog(@"Done with PC=[%d]", [neander pc]);
	
}

-(void)stepped{
	NeanderView *neanderView = (NeanderView*)[self view];
	[[neanderView pcValue] setText:[NSString stringWithFormat:@"%d",[neander pc]]];
	[[neanderView acValue] setText:[NSString stringWithFormat:@"%d",[neander ac]]];
}
	
@end
