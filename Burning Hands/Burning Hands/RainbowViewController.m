//
//  RainbowViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/29/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "RainbowViewController.h"
#import "BLEManager.h"

@interface RainbowViewController ()

-(void) sendRainbowUpdate:(UInt8*)params;

@end

@implementation RainbowViewController

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

- (IBAction)setRainbowMode:(id)sender
{
    [self.view endEditing:YES];
    
    NSScanner* scanner = [[NSScanner alloc] initWithString:[[self delayTextField] text]];
    
    int* delayInteger = malloc(sizeof(int));
    [scanner scanInt:delayInteger];
    
    UInt8 paramArray[1] = {};
    
    paramArray[0] = (UInt8) delayInteger;
    [self sendRainbowUpdate:paramArray];
}

-(void) sendRainbowUpdate:(UInt8*)params
{
    UInt8 command[2] = {};
    command[0] = 0x02;
    command[1] = params[0];
    
    NSLog(@"Sending command to update to rainbow mode: %d", command[0]);
    
    NSData *data = [[NSData alloc] initWithBytes:command length:2];
    [[BLEManager sharedInstance] sendCommand:data];

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
