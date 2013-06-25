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

@interface ConnectionViewController ()

- (void) initLoader;
- (void) initBluetooth;

@end

@implementation ConnectionViewController

@synthesize loader;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLoader];
    [self initBluetooth];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
////    if (theTextField == self.nameTextField) {
////        [theTextField resignFirstResponder];
////    }
//    return YES;
//}


@end
