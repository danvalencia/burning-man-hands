//
//  HandsBLE.m
//  Burning Hands
//
//  Created by Daniel Valencia on 8/8/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsBLE.h"

@interface HandsBLE() {
    NSArray *handsArray;
}

@end

@implementation HandsBLE

- (void) connectPeripheral:(CBPeripheral *)peripheral
{
    
    printf("Connecting to peripheral with UUID : %s\r\n",[self UUIDToString:peripheral.UUID]);
    self.activePeripheral = peripheral;
    self.activePeripheral.delegate = self;
    [self.CM connectPeripheral:self.activePeripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [super centralManager:central didConnectPeripheral:peripheral];
    NSLog(@"It fucking works, yeaaaaahhhh!!!!!!!!");
}

//-(void) write:(NSData *)d toPeripheral:(CBPeripheral *)peripheral
//{
//    CBUUID *uuid_service = [CBUUID UUIDWithString:@BLE_DEVICE_SERVICE_UUID];
//    CBUUID *uuid_char = [CBUUID UUIDWithString:@BLE_DEVICE_TX_UUID];
//    
//    [self writeValue:uuid_service characteristicUUID:uuid_char p:peripheral data:d];
//}


@end
