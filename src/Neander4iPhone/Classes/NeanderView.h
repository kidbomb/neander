//
//  NeanderView.h
//
//  Created by Filipe Rodrigues on 7/22/12.
//  Copyright 2012 T&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NeanderView : UIView {
	UILabel *pcValue;
	UILabel *acValue;
}

@property (nonatomic, retain) IBOutlet UILabel *pcValue;
@property (nonatomic, retain) IBOutlet UILabel *acValue;

@end
