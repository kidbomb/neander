//
//  NeanderViewController.h
//
//  Created by Filipe Rodrigues on 7/22/12.
//  Copyright 2012 T&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Neander.h"

@interface NeanderViewController : UIViewController<NeanderDelegate> {
	Neander *neander;
}

- (IBAction) openFileClicked:(id)sender;  
- (IBAction) runButtonClicked:(id)sender;  
- (void) stepped;

@end


