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
#import "HandsModel.h"
#import "Hand.h"

#define LEFT_HAND_CONNECTION_SUCCESS_MSG @"Disconnect Left Hand"
#define RIGHT_HAND_CONNECTION_SUCCESS_MSG @"Disconnect Right Hand"
#define RIGHT_HAND_CONNECTION_UNSUCCESS_MSG @"Connect Right Hand"
#define LEFT_HAND_CONNECTION_UNSUCCESS_MSG @"Connect Left Hand"
@interface ConnectionViewController ()
{
    HandsModel *handsModel;
    Hand *leftHand;
    Hand *rightHand;
}

-(void)initLoader;
-(void)initBluetooth;

@end

@implementation ConnectionViewController

@synthesize rightLoader;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLoader];
    [self initBluetooth];
    handsModel = [HandsModel sharedInstance];
    leftHand = handsModel.leftHand;
    rightHand = handsModel.rightHand;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)initBluetooth
{
    [[BLEManager sharedInstance] initializeWithDelegate:self];
}

- (void)initLoader
{
    [self disableLoader:self.rightLoader];
    [self disableLoader:self.leftLoader];
}

-(void) bleDidConnect
{
    
    if([leftHand isConnected])
    {
        [self.leftBtn setTitle:LEFT_HAND_CONNECTION_SUCCESS_MSG forState:UIControlStateNormal];
        [self disableLoader:self.leftLoader];
        NSLog(@"->Left Hand Connected");
    }
    
    if ([rightHand isConnected])
    {
        [self.rightBtn setTitle:RIGHT_HAND_CONNECTION_SUCCESS_MSG forState:UIControlStateNormal];
        [self disableLoader:self.rightLoader];

        NSLog(@"->Right Hand Connected");
    }
    
}

-(void) bleDidDisconnect
{
    if(![leftHand isConnected])
    {
        [self.leftBtn setTitle:RIGHT_HAND_CONNECTION_UNSUCCESS_MSG forState:UIControlStateNormal];
        [self disableLoader:self.leftLoader];
        NSLog(@"->Left Hand Disconnected");
   }
    
    if (![rightHand isConnected])
    {
        [self.rightBtn setTitle:RIGHT_HAND_CONNECTION_UNSUCCESS_MSG forState:UIControlStateNormal];
        [self disableLoader:self.rightLoader];
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
    [self.rightBtn setTitle:RIGHT_HAND_CONNECTION_SUCCESS_MSG forState:UIControlStateNormal];
    
    if (![[BLEManager sharedInstance] connectToHand:rightHand]) {
        [self.rightBtn setTitle:RIGHT_HAND_CONNECTION_UNSUCCESS_MSG forState:UIControlStateNormal];
    };
    [self disableLoader:self.rightLoader];
}

-(void) leftHandConnectionCallback:(NSTimer *)timer
{
    [self.leftBtn setEnabled:true];
    [self.leftBtn setTitle:LEFT_HAND_CONNECTION_SUCCESS_MSG forState:UIControlStateNormal];
    
    if (![[BLEManager sharedInstance] connectToHand:leftHand]) {
        [self.leftBtn setTitle:LEFT_HAND_CONNECTION_UNSUCCESS_MSG forState:UIControlStateNormal];
    };
    [self disableLoader:self.leftLoader];
}

- (IBAction)connectRightHand:(id)sender
{
    if([rightHand isConnected])
    {
        [[BLEManager sharedInstance] disconnectHand:rightHand];
        return;
    }
    
    [self.rightBtn setEnabled:false];
    [self.rightBtn setTitle:@"Connecting" forState:UIControlStateNormal];

    BLEManager* bleManager = [BLEManager sharedInstance];
    
    [bleManager findBluetoothPeripherals];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)3.0 target:self selector:@selector(rightHandConnectionCallback:) userInfo:nil repeats:NO];
    
    [self enableLoader:self.rightLoader];
}



- (IBAction)connectLeftHand:(id)sender {
    if([leftHand isConnected])
    {
        [[BLEManager sharedInstance] disconnectHand:leftHand];
        return;
    }
    
    [self.leftBtn setEnabled:false];
    [self.leftBtn setTitle:@"Connecting" forState:UIControlStateNormal];
    
    BLEManager* bleManager = [BLEManager sharedInstance];
    
    [bleManager findBluetoothPeripherals];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)3.0 target:self selector:@selector(leftHandConnectionCallback:) userInfo:nil repeats:NO];
    
    [self enableLoader:self.leftLoader];
}

-(void) disableLoader:(Loader *)loader
{
    [loader setHidden:YES];
    [loader stopAnimating];
}

-(void) enableLoader:(Loader *)loader
{
    [loader setHidden:NO];
    [loader startAnimating];
}


@end
