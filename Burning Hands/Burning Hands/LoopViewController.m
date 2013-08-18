//
//  AboutViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "LoopViewController.h"
#import "BLEManager.h"
#import "LoopCommand.h"
#import "HandsModel.h"
#import "ColorUtils.h"

#define HEX_CHARS @"0123456789ABCDEFabcdef"

@interface LoopViewController ()
{
    NSArray *loopTypes;
}

- (void) sendColorUpdate:(NSString *)colors;

@end

@implementation LoopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)updateColor:(id)sender {
    [self.view endEditing:YES];
    NSString* colorText = [[self colorTextField] text];
    NSString* hexColor = [ColorUtils padWithZeros:colorText];
    self.colorTextField.text = hexColor;
    [self sendColorUpdate:hexColor];
}

- (IBAction)handSelected:(id)sender {
    NSLog(@"%d index selected: ", self.handButton.selectedSegmentIndex);
}


-(void) sendColorUpdate:(NSString*)colors
{
    HandsModel *handsModel = [HandsModel sharedInstance];
    
    LoopCommand* command = [[LoopCommand alloc]initWithColor:colors andType:self.loopModeSelector.selectedSegmentIndex];
    if(self.handButton.selectedSegmentIndex == 0)
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
    if(textField == self.colorTextField)
    {
        [self.colorTextField resignFirstResponder];
        NSLog(@"Color text field is being called!");
    }
    else
    {
        NSLog(@"Color text field is NOT being called!");
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:HEX_CHARS] invertedSet];
    if(textField == self.colorTextField)
    {
        NSLog(@"Color text field is being called!");
        if (textField.text.length + string.length > 6 )
        {
            return NO;
        }
        else
        {
            return [[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1;
        }
    }
    
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
