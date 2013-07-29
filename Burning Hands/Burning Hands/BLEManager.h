//
//  BLEManager.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLE.h"
#import "BLECommand.h"

@interface BLEManager : NSObject 

@property (nonatomic, retain) BLE* ble;

+(BLEManager *) sharedInstance;
-(void)initializeWithDelegate:(id<BLEDelegate>)delegate;
-(void)sendCommand:(NSData *)data;
-(void)executeCommand:(id <BLECommand> ) command;
-(BOOL)connectToDevice;
-(void)findBluetoothPeripherals;
-(BOOL)isConnected;
-(void)cancelActiveConnections;

@end
