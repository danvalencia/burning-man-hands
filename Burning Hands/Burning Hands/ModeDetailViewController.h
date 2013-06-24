//
//  ModeDetailViewController.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Mode;

@interface ModeDetailViewController : UIViewController

@property (strong, nonatomic) Mode *mode;

@property (weak, nonatomic) IBOutlet UILabel *modeNameLabel;

@end
