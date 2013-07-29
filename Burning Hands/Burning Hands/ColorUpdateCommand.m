//
//  ColorUpdateCommand.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/25/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ColorUpdateCommand.h"
#import "ColorUtils.h"

#define COMMAND 0x03

@interface ColorUpdateCommand()

@property (nonatomic, strong) HandsCell *cell;

@end

@implementation ColorUpdateCommand

-(id)initWithCell:(HandsCell *)theCell
{
    self = [super init];
    if (self) {
        self.cell = theCell;
    }
    return self;
}

-(NSData *) getData
{
    UInt8* colorBytes = [ColorUtils getRGBAsBytes:self.cell.color];
    UInt8 xPos = (UInt8)self.cell.x;
    UInt8 yPos = (UInt8)self.cell.y;
    
    UInt8 *commandArray = malloc(sizeof(UInt8) * 6);
    commandArray[0] = COMMAND;
    commandArray[1] = colorBytes[0];
    commandArray[2] = colorBytes[1];
    commandArray[3] = colorBytes[2];
    commandArray[4] = xPos;
    commandArray[5] = yPos;
    
    NSData* data = [[NSData alloc] initWithBytes:commandArray length:6];
    return data;
}

@end
