//
//  ModeDataController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ModeDataController.h"
#import "ModeProperty.h"

@interface ModeDataController()

-(void)initializeDefaultDataList;

@end

@implementation ModeDataController

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (void)initializeDefaultDataList
{
    NSMutableArray *modesList = [[NSMutableArray alloc] init];
    self.masterModesList = modesList;
    ModeProperty *modeProperty = [[ModeProperty alloc] initWithName:@"Color" code:0x01 andSize:3];
    NSArray *propertyList = [[NSArray alloc] initWithObjects:modeProperty, nil];
    Mode *mode = [[Mode alloc] initWithName:@"Color Set" andProperties:propertyList];
    [self addMode:mode];
}

- (void)setMasterModesList:(NSMutableArray *)newList
{
    if(_masterModesList != newList)
    {
        _masterModesList = [newList mutableCopy];
    }
}

- (NSUInteger)countOfList
{
    return [self.masterModesList count];
}

- (Mode *)objectInListAtIndex:(NSUInteger)theIndex
{
    return [self.masterModesList objectAtIndex:theIndex];
}

- (void)addMode:(Mode *)mode
{
    [self.masterModesList addObject:mode];
}

@end
