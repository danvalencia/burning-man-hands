//
//  RainbowViewController.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/29/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaserViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *handsButton;
@property (strong, nonatomic) IBOutlet UITextField *delayTextField;

- (IBAction)setMode:(id)sender;

@end
