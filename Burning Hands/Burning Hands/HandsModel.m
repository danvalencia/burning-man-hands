//
//  HandsModel.m
//  Burning Hands
//
//  Created by Daniel Valencia on 8/10/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsModel.h"
#import "Hand.h"

@interface HandsModel()

-(void)initHands;

@end

@implementation HandsModel

static HandsModel* _instance = NULL;

-(id)init
{
    self = [super init];
    if(self)
    {
        [self initHands];
    }
    return self;
}

+(HandsModel *)sharedInstance
{
    @synchronized(self)
    {
        if (!_instance)
        {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}


-(void) initHands
{
    self.rightHand = [[Hand alloc] initWithUUID:@"F0573D38-3AE0-CB56-CA5F-2130EA4A6140"];
    self.leftHand = [[Hand alloc] initWithUUID:@"CDA99567-1DAD-4422-65A0-3118878A8863"];
}


@end
