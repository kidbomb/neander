//
//  Neander4iPhoneAppDelegate.h
//  Neander4iPhone
//
//  Created by Filipe Rodrigues on 2/15/11.
//  Copyright 2011 T&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Neander.h"

@interface Neander4iPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

