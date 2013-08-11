//
//  HandsBLE.h
//  Burning Hands
//
//  Created by Daniel Valencia on 8/8/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "BLE.h"

@interface HandsBLE : BLE

@property (nonatomic, strong) NSArray* peripheralArray;

-(void) connectPeripheral:(CBPeripheral *)peripheral;
-(void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;
-(void) enableWriteForPeripheral:(CBPeripheral *)peripheral;
-(void) readLibVerFromPeripheral:(CBPeripheral *)peripheral;
-(void) readVendorNameFromPeripheral:(CBPeripheral *)peripheral;


@end
