//
//  VerticalLoopCommand.m
//  Burning Hands
//
//  Created by Daniel Valencia on 8/16/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "VerticalLoopCommand.h"
#import "HandsModel.h"
#import "ColorUtils.h"

@interface VerticalLoopCommand(){
    UInt8* colorArray;
    NSInteger* loopType;
}

@end
@implementation VerticalLoopCommand

-(id)initWithColor:(NSString *)theColor andType:(NSInteger *)theLoopType
{
    self = [super init];
    if (self) {
        NSString* hexColor = [ColorUtils padWithZeros:theColor];
        colorArray = [ColorUtils convertHexStringToByteArray:hexColor];
        loopType = theLoopType;
    }
    return self;
}


-(NSData *)getData
{
    UInt8 command[4] = {};
    
    if(loopType == 0)
    {
        command[0] = 0x01;
    }else{
        command[0] = 0x02;
    }
    command[1] = colorArray[0];
    command[2] = colorArray[1];
    command[3] = colorArray[2];
    
    NSLog(@"Sending command: %d; Red: %d; Green %d; Blue %d", command[0], command[1], command[2], command[3]);
        
    NSData* data = [[NSData alloc] initWithBytes:command length:4];
    return data;
}

@end
