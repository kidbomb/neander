//
//  Neander4iPhoneAppDelegate.h
//  Neander4iPhone
//
//  Created by Filipe Rodrigues on 2/15/11.
//  Copyright 2011 T&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Neander.h"

@interface Neander4iPhoneAppDelegate : NSObject <UIApplicationDelegate,NeanderDelegate> {
    UIWindow *window;
	Neander *neander;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
- (IBAction) openFileClicked:(id)sender;  
- (IBAction) runButtonClicked:(id)sender;  
- (void) stepped;

@end

