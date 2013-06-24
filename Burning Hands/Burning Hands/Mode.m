//
//  Mode.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "Mode.h"

@implementation Mode

@synthesize name = _name;
@synthesize properties = _properties;

-(id) initWithName:(NSString *)name andProperties:(NSArray *)properties
{
    self = [super init];
    if(self)
    {
        _name = name;
        _properties = properties;
    }
    return self;
}

@end
