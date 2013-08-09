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
#import "HandModel.h"

@interface ConnectionViewController ()
{
    HandModel *leftHand;
    HandModel *rightHand;
}

-(void)initLoader;
-(void)initBluetooth;
-(void)initHands;

@end

@implementation ConnectionViewController

@synthesize rightLoader;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLoader];
    [self initBluetooth];
    [self initHands];
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
    [self.rightLoader setHidden:TRUE];
    [self.leftLoader setHidden:TRUE];
}

-(void) initHands
{
    rightHand = [[HandModel alloc] initWithUUID:@"F0573D38-3AE0-CB56-CA5F-2130EA4A6140"];
    leftHand = [[HandModel alloc] initWithUUID:@"CDA99567-1DAD-4422-65A0-3118878A8863"];
}

-(void) bleDidConnect
{
    
    if([leftHand isConnected])
    {
        [self.leftBtn setTitle:@"Connect Left Hand" forState:UIControlStateNormal];
        [self.leftLoader stopAnimating];
        NSLog(@"->Left Hand Connected");
    }
    
    if ([rightHand isConnected])
    {
        [self.rightBtn setTitle:@"Connect Right Hand" forState:UIControlStateNormal];
        [self.rightLoader stopAnimating];
        NSLog(@"->Right Hand Connected");
    }
    
}

-(void) bleDidDisconnect
{
    if(![leftHand isConnected])
    {
        [self.leftBtn setTitle:@"Connect" forState:UIControlStateNormal];
        [self.leftLoader stopAnimating];
        NSLog(@"->Left Hand Disconnected");
   }
    
    if (![rightHand isConnected])
    {
        [self.rightBtn setTitle:@"Connect" forState:UIControlStateNormal];
        [self.rightLoader stopAnimating];
        NSLog(@"->Right Hand Disconnected");
    }
        
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

-(void) rightHandConnectionCallback:(NSTimer *)timer
{
    [self.rightBtn setEnabled:true];
    [self.rightBtn setTitle:@"Disconnect Right Hannd" forState:UIControlStateNormal];
    
    if (![[BLEManager sharedInstance] connectToHand:rightHand])
    {
        [self.rightBtn setTitle:@"Connect Right Hand" forState:UIControlStateNormal];
        [self.rightLoader stopAnimating];
    }
}

-(void) leftHandConnectionCallback:(NSTimer *)timer
{
    [self.leftBtn setEnabled:true];
    [self.leftBtn setTitle:@"Disconnect Left Hannd" forState:UIControlStateNormal];
    
    if (![[BLEManager sharedInstance] connectToHand:leftHand])
    {
        [self.leftBtn setTitle:@"Connect Left Hand" forState:UIControlStateNormal];
        [self.leftLoader stopAnimating];
    }
}

//- (IBAction)connectRightHand:(id)sender
//{
//    BLEManager* bleManager = [BLEManager sharedInstance];
//    if ([bleManager isConnected]) {
//        [bleManager cancelActiveConnections];
//        [self.rightBtn setTitle:@"Connect" forState:UIControlStateNormal];
//        return;
//    }
//    
//    [bleManager findBluetoothPeripherals];
//    
//    [self.rightBtn setEnabled:false];
//    [self.rightBtn setTitle:@"Connecting" forState:UIControlStateNormal];
//    
//    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
//    
//    [self.rightLoader startAnimating];
//    [self.rightLoader setHidden:FALSE];
//}

- (IBAction)connectRightHand:(id)sender
{
    if([rightHand isConnected])
    {
        [[BLEManager sharedInstance] disconnectHand:rightHand];
    }
    
    [self.rightBtn setEnabled:false];
    [self.rightBtn setTitle:@"Connecting" forState:UIControlStateNormal];

    BLEManager* bleManager = [BLEManager sharedInstance];
    
    [bleManager findBluetoothPeripherals];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)3.0 target:self selector:@selector(rightHandConnectionCallback:) userInfo:nil repeats:NO];
    
    [self.rightLoader startAnimating];
    [self.rightLoader setHidden:FALSE];
}



- (IBAction)connectLeftHand:(id)sender {
    if([leftHand isConnected])
    {
        [[BLEManager sharedInstance] disconnectHand:leftHand];
    }
    
    [self.leftBtn setEnabled:false];
    [self.leftBtn setTitle:@"Connecting" forState:UIControlStateNormal];
    
    BLEManager* bleManager = [BLEManager sharedInstance];
    
    [bleManager findBluetoothPeripherals];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)3.0 target:self selector:@selector(leftHandConnectionCallback:) userInfo:nil repeats:NO];
    
    [self.leftLoader startAnimating];
    [self.leftLoader setHidden:FALSE];
}

@end
