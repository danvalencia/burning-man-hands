//
//  AboutViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "VerticalLoopViewController.h"
#import "BLEManager.h"
#import "VerticalLoopCommand.h"
#import "HandsModel.h"
#import "ColorUtils.h"

#define HEX_CHARS @"0123456789ABCDEFabcdef"

@interface VerticalLoopViewController ()
{
    NSArray *loopTypes;
}

- (void) sendColorUpdate:(NSString *)colors;

@end

@implementation VerticalLoopViewController

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return loopTypes.count;
}

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
    self.loopTypeSelection.delegate = self;
    [self initPicker];
}

-(void)initPicker
{
    loopTypes = [[NSArray alloc] initWithObjects:@"Vertical Loop", @"Horizontal Loop", nil];
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
    
    NSInteger row = [self.loopTypeSelection selectedRowInComponent:0];
    VerticalLoopCommand* command = [[VerticalLoopCommand alloc]initWithColor:colors andType:row];
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

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [loopTypes objectAtIndex:row];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
