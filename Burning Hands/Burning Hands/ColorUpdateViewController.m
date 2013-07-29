//
//  AboutViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ColorUpdateViewController.h"
#import "BLEManager.h"

#define HEX_CHARS @"0123456789ABCDEFabcdef"

@interface ColorUpdateViewController ()

- (NSString*)padWithZeros:(NSString*)colorText;
- (void) sendColorUpdate:(UInt8[])colors;

@end

@implementation ColorUpdateViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UInt8*)convertHexStringToByteArray:(NSString *)hexColor {
    UInt8* colorArray = malloc(sizeof(UInt8) * 3);
    //UInt8 colorArray[3] = {};
    
    unsigned firstDigitInt;
    for (int i = 0; i < 6; i += 2) {
        NSString *digit = [hexColor substringWithRange:NSMakeRange(i, 2)];
        [[NSScanner scannerWithString:digit] scanHexInt:&firstDigitInt];
        colorArray[i/2] = (char)firstDigitInt;
        NSLog(@"Digit: %u", firstDigitInt);
    }
    return colorArray;
}

- (IBAction)updateColor:(id)sender {
    [self.view endEditing:YES];
    NSString* colorText = [[self colorTextField] text];
    NSString* hexColor = [self padWithZeros:colorText];
    self.colorTextField.text = hexColor;
    UInt8* colorArray;
    colorArray = [self convertHexStringToByteArray:hexColor];
    
    [self sendColorUpdate:colorArray];
    
}

- (NSString*)padWithZeros:(NSString*)string
{
    NSMutableString *paddedString = [NSMutableString stringWithCapacity:6];
    [paddedString appendString:string];
    
    if(string.length < 6)
    {
        for(UInt8 i = 6 - string.length; i > 0; i--)
        {
            [paddedString appendString:@"0"];
        }
    }
    return paddedString;
}

-(void) sendColorUpdate:(UInt8*)colors
{
    UInt8 command[4] = {};
    command[0] = 0x01;
    command[1] = colors[0];
    command[2] = colors[1];
    command[3] = colors[2];
    
    NSLog(@"Sending command: %d; Red: %d; Green %d; Blue %d", command[0], command[1], command[2], command[3]);
    
    NSData *data = [[NSData alloc] initWithBytes:command length:4];
    [[BLEManager sharedInstance] sendCommand:data];
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
