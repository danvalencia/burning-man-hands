//
//  HandsBLE.m
//  Burning Hands
//
//  Created by Daniel Valencia on 8/8/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsBLE.h"
#import "BLEDefines.h"

@interface HandsBLE() {
    NSArray *handsArray;
    BOOL isConnected;
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

-(void) write:(NSData *)d toPeripheral:(CBPeripheral *)peripheral
{
    CBUUID *uuid_service = [CBUUID UUIDWithString:@BLE_DEVICE_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:@BLE_DEVICE_TX_UUID];
    
    [self writeValue:uuid_service characteristicUUID:uuid_char p:peripheral data:d];
}

-(void) readFromPeripheral:(CBPeripheral *)peripheral
{
    CBUUID *uuid_service = [CBUUID UUIDWithString:@BLE_DEVICE_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:@BLE_DEVICE_RX_UUID];
    
    [self readValue:uuid_service characteristicUUID:uuid_char p:peripheral];
}


-(void) enableWriteForPeripheral:(CBPeripheral *)peripheral
{
    CBUUID *uuid_service = [CBUUID UUIDWithString:@BLE_DEVICE_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:@BLE_DEVICE_RESET_RX_UUID];
    unsigned char bytes[] = {0x01};
    NSData *d = [[NSData alloc] initWithBytes:bytes length:1];
    [self writeValue:uuid_service characteristicUUID:uuid_char p:peripheral data:d];
}

-(void) readLibVerFromPeripheral:(CBPeripheral *)peripheral;
{
    CBUUID *uuid_service = [CBUUID UUIDWithString:@BLE_DEVICE_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:@BLE_DEVICE_LIB_VERSION_UUID];
    
    [self readValue:uuid_service characteristicUUID:uuid_char p:peripheral];
}

-(void) readVendorNameFromPeripheral:(CBPeripheral *)peripheral;
{
    CBUUID *uuid_service = [CBUUID UUIDWithString:@BLE_DEVICE_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:@BLE_DEVICE_VENDOR_NAME_UUID];
    
    [self readValue:uuid_service characteristicUUID:uuid_char p:peripheral];
}

static bool done = false;

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (!error)
    {
        //        printf("Characteristics of service with UUID : %s found\n",[self CBUUIDToString:service.UUID]);
        
        for (int i=0; i < service.characteristics.count; i++)
        {
            //            CBCharacteristic *c = [service.characteristics objectAtIndex:i];
            //            printf("Found characteristic %s\n",[ self CBUUIDToString:c.UUID]);
            CBService *s = [peripheral.services objectAtIndex:(peripheral.services.count - 1)];
            
            if ([service.UUID isEqual:s.UUID])
            {
                if (!done)
                {
                    [self enableReadNotification:peripheral];
                    [self readLibVerFromPeripheral:peripheral];
                    [self readVendorNameFromPeripheral:peripheral];
                    
                    [[self delegate] bleDidConnect];
                    
                    isConnected = true;
                    [peripheral readRSSI];
                    
                    done = true;
                }
                
                break;
            }
        }
    }
    else
    {
        printf("Characteristic discorvery unsuccessful!\r\n");
    }
}

@end
