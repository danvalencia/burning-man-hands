//
//  ViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 2/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ConnectionViewController.h"
#import "Loader.h"
#import "BLEManager.h"

#define HEX_CHARS @"0123456789ABCDEFabcdef"

@interface ConnectionViewController ()

- (void) initLoader;
- (void) initBluetooth;
- (NSString*)padWithZeros:(NSString*)colorText;
- (void) sendColorUpdate:(UInt8[])colors;

@end

@implementation ConnectionViewController

@synthesize colorTextField;
@synthesize loader;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initLoader];
    [self initBluetooth];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initBluetooth
{
    [[BLEManager sharedInstance] initializeWithDelegate:self];
}

- (void)initLoader
{
    [self.loader setHidden:TRUE];
}

-(void) bleDidConnect
{
    NSLog(@"->Connected");
        
    [self.loader stopAnimating];
    
}

-(void) bleDidDisconnect
{
    NSLog(@"->Disconnected");
    
    [self.connectBtn setTitle:@"Connect" forState:UIControlStateNormal];

    [self.loader stopAnimating];
}

-(void) bleDidUpdateRSSI:(NSNumber *) rssi
{
    //lblRSSI.text = rssi.stringValue;
}

-(void) bleDidReceiveData:(unsigned char *) data length:(int) length
{
    NSLog(@"Length: %d", length);
    
    // parse data, all commands are in 3-byte
    for (int i = 0; i < length; i+=3)
    {
        NSLog(@"0x%02X, 0x%02X, 0x%02X", data[i], data[i+1], data[i+2]);
        
        if (data[i] == 0x0A)
        {
           // if (data[i+1] == 0x01)
                //swDigitalIn.on = true;
           // else
                //swDigitalIn.on = false;
        }
        else if (data[i] == 0x0B)
        {
           // UInt16 Value;
            
            //Value = data[i+2] | data[i+1] << 8;
            //lblAnalogIn.text = [NSString stringWithFormat:@"%d", Value];
        }
    }

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


-(void) connectionTimer:(NSTimer *)timer
{
    [self.connectBtn setEnabled:true];
    [self.connectBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
    
    if (![[BLEManager sharedInstance] connectToDevice])
    {
        [self.connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
        [self.loader stopAnimating];
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

- (IBAction)connectToDevice:(id)sender
{
    BLEManager* bleManager = [BLEManager sharedInstance];
    if ([bleManager isConnected]) {
        [bleManager cancelActiveConnections];
        [self.connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
        return;
    }
    
    [bleManager findBluetoothPeripherals];
    
    [self.connectBtn setEnabled:false];
    [self.connectBtn setTitle:@"Connecting" forState:UIControlStateNormal];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
    [self.loader startAnimating];
    [self.loader setHidden:FALSE];
}

- (IBAction)toggleLED:(id)sender
{
    if ([sender isOn])
    {
        //[self sendDigitalOut:0x01];
        NSLog(@"Switch is ON");
        
    }
    else
    {
        //[self sendDigitalOut:0x00];
        NSLog(@"Switch is OFF");
        
    }
}

- (IBAction)updateColor:(id)sender {
    [self.view endEditing:YES];
    NSString* colorText = [[self colorTextField] text];
    NSString* hexColor = [self padWithZeros:colorText];
    self.colorTextField.text = hexColor;
    UInt8 colorArray[3] = {};
    
    unsigned firstDigitInt;
    for (int i = 0; i < 6; i += 2) {
        NSString *digit = [hexColor substringWithRange:NSMakeRange(i, 2)];
        [[NSScanner scannerWithString:digit] scanHexInt:&firstDigitInt];
        colorArray[i/2] = (char)firstDigitInt;
        NSLog(@"Digit: %u", firstDigitInt);
    }
    
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



//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
////    if (theTextField == self.nameTextField) {
////        [theTextField resignFirstResponder];
////    }
//    return YES;
//}


@end
