//
//  HandModel.m
//  Burning Hands
//
//  Created by Daniel Valencia on 8/8/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "Hand.h"
#import "BLEManager.h"

@implementation Hand

-(id)initWithUUID:(NSString *)uuid
{
    self = [super init];
    if(self)
    {
        self.uuid = CFUUIDCreateFromString(kCFAllocatorDefault, (__bridge CFStringRef)(uuid));
    }
    return self;
}

-(BOOL)isConnected
{
    return self.peripheral && self.peripheral.isConnected;
}

//-(void)connectTo:(CBPeripheral *)thePeripheral
//{
//    if ([self isConnected]) {
//        [self disconnect];
//    }
//    
//    self.peripheral = thePeripheral;
//    [[BLEManager sharedInstance] connectToPeripheral:self.peripheral];
//}
//
//-(void)disconnect
//{
//    if (self.peripheral) {
//        [[BLEManager sharedInstance] disconnectFromPeripheral:self.peripheral];
//        self.peripheral = nil;
//    }
//}

@end
