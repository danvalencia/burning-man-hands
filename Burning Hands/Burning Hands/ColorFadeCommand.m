//
//  ColorFadeCommand.m
//  Burning Hands
//
//  Created by Daniel Valencia on 8/17/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ColorFadeCommand.h"

@implementation ColorFadeCommand

-(NSData *)getData
{
    UInt8 command[1] = {};
    
    command[0] = 0x06;
    
    NSLog(@"Sending command: %d", command[0]);
    
    NSData* data = [[NSData alloc] initWithBytes:command length:1];
    return data;
}

@end
