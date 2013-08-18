//
//  ColorFadeViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 8/17/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ColorFadeViewController.h"
#import "BLEManager.h"
#import "ColorFadeCommand.h"
#import "HandsModel.h"

@interface ColorFadeViewController ()

@end

@implementation ColorFadeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateMode:(id)sender {
    HandsModel *handsModel = [HandsModel sharedInstance];
    ColorFadeCommand *command = [[ColorFadeCommand alloc] init];
    
    if(self.handsButton.selectedSegmentIndex == 0)
    {
        [[BLEManager sharedInstance] executeCommand:command onHand:handsModel.leftHand];
    }
    else
    {
        [[BLEManager sharedInstance] executeCommand:command onHand:handsModel.rightHand];
    }
}
@end
