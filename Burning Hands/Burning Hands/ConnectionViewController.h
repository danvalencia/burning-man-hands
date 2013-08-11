//
//  ViewController.h
//  Burning Hands
//
//  Created by Daniel Valencia on 2/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loader.h"
#import "BLE.h"

@interface ConnectionViewController : UIViewController <BLEDelegate>

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;

@property (strong, nonatomic) IBOutlet Loader *rightLoader;
@property (strong, nonatomic) IBOutlet Loader *leftLoader;

- (IBAction)connectRightHand:(id)sender;
- (IBAction)connectLeftHand:(id)sender;

@end
