//
//  BLEManager.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandsBLE.h"
#import "BLECommand.h"
#import "HandModel.h"

@interface BLEManager : NSObject 

@property (nonatomic, strong) HandsBLE* ble;

+(BLEManager *) sharedInstance;
-(void)initializeWithDelegate:(id<BLEDelegate>)delegate;
-(void)sendCommand:(NSData *)data;
-(void)executeCommand:(id <BLECommand> ) command;
-(BOOL)connectToDevice;
-(BOOL)connectToHand:(HandModel *)hand;
-(void)connectToPeripheral:(CBPeripheral *) peripheral;
-(void)findBluetoothPeripherals;
-(BOOL)isConnected;
-(BOOL)isConnected:(CBPeripheral *) peripheral;
-(void)cancelActiveConnections;
-(void)disconnectFromPeripheral:(CBPeripheral *) peripheral;
-(void)disconnectHand:(HandModel *) hand;

@end
