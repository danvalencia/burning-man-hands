//
//  Property.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ModePropertyDefinition.h"

@implementation ModePropertyDefinition

@synthesize name = _name;
@synthesize code = _code;
@synthesize size = _size;
@synthesize type = _type;

-(id)initWithName:(NSString *)name code:(UInt8)code size:(UInt8)size type:(NSString *)type
{
    
    
    self = [super init];
    if(self)
    {
        _name = name;
        _code = code;
        _size = size;
        _type = type;
    }
    return self;
}
@end