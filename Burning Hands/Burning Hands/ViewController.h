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


@interface ViewController : UIViewController <UITextFieldDelegate, BLEDelegate>

@property (weak, nonatomic) IBOutlet UILabel *greetingLabel;

@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (strong, nonatomic) IBOutlet Loader *loader;


@property (copy, nonatomic) NSString *userName;
@property (strong, nonatomic) BLE *ble;
@property (strong, nonatomic) IBOutlet UITextField *colorTextField;

- (IBAction)connectToDevice:(id)sender;
- (IBAction)toggleLED:(id)sender;
- (IBAction)updateColor:(id)sender;

@end
