//
//  Coordinate.m
//  Burning Hands
//
//  Created by Daniel Valencia on 8/13/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

-(id)initWithX:(int)theX y:(int)theY
{
    self = [super init];
    if(self)
    {
        self.x = theX;
        self.y = theY;
    }
    return self;
}

@end
