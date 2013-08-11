//
//  HandModel.h
//  Burning Hands
//
//  Created by Daniel Valencia on 8/8/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface Hand : NSObject

@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, assign) CFUUIDRef uuid;

-(id)initWithUUID:(NSString *)uuid;
-(BOOL)isConnected;

@end
