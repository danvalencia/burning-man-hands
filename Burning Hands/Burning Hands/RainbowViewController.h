//
//  RainbowViewController.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/29/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RainbowViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *delayTextField;
- (IBAction)setRainbowMode:(id)sender;

@end
