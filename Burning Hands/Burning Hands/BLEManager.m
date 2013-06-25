//
//  BLEManager.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "BLEManager.h"

@implementation BLEManager

@synthesize ble;

static BLEManager* _instance = NULL;

-(id)init
{
    self = [super init];
    return self;
}

+(BLEManager *)sharedInstance
{
    @synchronized(self)
    {
        if (!_instance)
        {
            _instance = [[self alloc] init];
        }        
    }
    return _instance;
}


-(void)initializeWithDelegate:(id<BLEDelegate>)delegate
{
    NSLog(@"Initializing Bluetooth!");
    self.ble = [[BLE alloc] init];
    [self.ble controlSetup:1];
    self.ble.delegate = delegate;
}

-(void)sendCommand:(NSData *)data
{
    [self.ble write:data];
}

-(BOOL)connectToDevice
{
    if (self.ble.peripherals.count > 0)
    {
        [self.ble connectPeripheral:[self.ble.peripherals objectAtIndex:0]];
        return YES;
    }
    return NO;
}

-(void)findBluetoothPeripherals
{
    if (self.ble.peripherals)
        self.ble.peripherals = nil;
    [self.ble findBLEPeripherals:2];
}

-(BOOL)isConnected
{
    if (self.ble.activePeripheral)
    {
        if(self.ble.activePeripheral.isConnected)
        {
            return YES;
        }
    }
    return NO;
}

-(void)cancelActiveConnections
{
    [[self.ble CM] cancelPeripheralConnection:[self.ble activePeripheral]];

}


@end
