//
//  BLEManager.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "BLEManager.h"

@implementation BLEManager

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
    self.ble = [[HandsBLE alloc] init];
    [self.ble controlSetup:1];
    self.ble.delegate = delegate;
}

-(void)executeCommand:(id <BLECommand> ) command
{
    [self sendCommand:[command getData]];
}

-(void)executeCommand:(id <BLECommand> ) command onHand:(Hand *)hand
{
    [self.ble write:[command getData] toPeripheral:hand.peripheral];
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

-(BOOL)connectToHand:(Hand *)hand
{    
    if(self.ble.peripherals.count > 0)
    {
        for(int i = 0; self.ble.peripherals.count > i; i++)
        {
            CBPeripheral *p = [self.ble.peripherals objectAtIndex:i];
            if(CFEqual(p.UUID, hand.uuid))
            {
                hand.peripheral = p;
                [self connectToPeripheral:hand.peripheral];
                return YES;
            }
        }
    }
    return NO;
}

-(void)connectToPeripheral:(CBPeripheral *) peripheral
{
//    if([self isConnected:peripheral])
//    {
//        [self disconnectFromPeripheral:peripheral];
//    }
    [self.ble connectPeripheral:peripheral];
}

-(void)disconnectFromPeripheral:(CBPeripheral *) peripheral
{
    [self.ble.CM cancelPeripheralConnection:peripheral];
}

-(void)disconnectHand:(Hand *) hand
{
    if([hand isConnected] && hand.peripheral)
    {
        [self disconnectFromPeripheral:hand.peripheral];
    }
}

-(void)findBluetoothPeripherals
{
    [self.ble findBLEPeripherals:3];
}
    
-(BOOL)isConnected:(CBPeripheral *) peripheral
{
    return peripheral && peripheral.isConnected;
}

-(void)cancelActiveConnections
{
    [[self.ble CM] cancelPeripheralConnection:[self.ble activePeripheral]];

}


@end
