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

//- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
//{
//    if (peripheral.UUID != NULL)
//        printf("Connected to %s successful\n",[self UUIDToString:peripheral.UUID]);
//    else
//        printf("Connected to NULL successful\n");
//    self.activePeripheral = peripheral;
//    [self.activePeripheral discoverServices:nil];
//    [self getAllServicesFromPeripheral:peripheral];
//}


@end
