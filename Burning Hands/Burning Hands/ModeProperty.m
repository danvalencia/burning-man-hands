//
//  Property.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ModeProperty.h"

@implementation ModeProperty

@synthesize name = _name;
@synthesize code = _code;
@synthesize size = _size;

-(id)initWithName:(NSString *)name code:(UInt8)code andSize:(UInt8)size
{
    self = [super init];
    if(self)
    {
        _name = name;
        _code = code;
        _size = size;
    }
    return self;
}
@end