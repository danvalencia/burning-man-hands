//
//  AboutViewController.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *colorTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *handButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *loopModeSelector;

- (IBAction)updateColor:(id)sender;
- (IBAction)handSelected:(id)sender;


@end
