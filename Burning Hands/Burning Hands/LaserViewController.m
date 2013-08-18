//
//  RainbowViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/29/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "LaserViewController.h"
#import "BLEManager.h"
#import "HandsModel.h"
#import "LaserCommand.h"

@interface LaserViewController ()

-(void) sendLaserUpdate:(UInt8*)params;

@end

@implementation LaserViewController

@synthesize delayTextField;

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

- (IBAction)setMode:(id)sender
{
    [self.view endEditing:YES];
    
    NSScanner* scanner = [[NSScanner alloc] initWithString:[[self delayTextField] text]];
    
    int* delayInteger = malloc(sizeof(int));
    [scanner scanInt:delayInteger];
    
    UInt8 paramArray[1] = {};
    
    paramArray[0] = (UInt8) delayInteger;
    [self sendLaserUpdate:paramArray];
}

-(void) sendLaserUpdate:(UInt8*)params
{
    HandsModel *handsModel = [HandsModel sharedInstance];
    
    LaserCommand* command = [[LaserCommand alloc]initWithDelay];
    
    if(self.handsButton.selectedSegmentIndex == 0)
    {
        [[BLEManager sharedInstance] executeCommand:command onHand:handsModel.leftHand];
    }
    else
    {
        [[BLEManager sharedInstance] executeCommand:command onHand:handsModel.rightHand];
    }

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.delayTextField)
    {
        [self.delayTextField resignFirstResponder];
        NSLog(@"Color text field is being called!");
    }
    else
    {
        NSLog(@"Color text field is NOT being called!");
    }
    
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
