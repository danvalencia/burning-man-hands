//
//  RandomViewController.h
//  Burning Hands
//
//  Created by Daniel Valencia on 8/17/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *handsButton;
@property (strong, nonatomic) IBOutlet UIButton *updateButton;

- (IBAction)updateMode:(id)sender;

@end
