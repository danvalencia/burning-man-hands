//
//  GridMapper.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/28/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "GridMapper.h"

@interface GridMapper()
{
    NSDictionary *mappingDictionary;
}

-(void) initMapping;

@end

@implementation GridMapper

static  GridMapper *_sharedMapper = nil;

-(id)init
{
    self = [super init];
    if (self) {
        [self initMapping];
    }
    return self;

}

+(id)sharedMapper
{
    @synchronized(self)
    {
        if(!_sharedMapper)
        {
            _sharedMapper = [[self alloc] init];
        }
    }
    return _sharedMapper;
}

-(void)initMapping
{
    mappingDictionary = @{
                @"1,11" : @[@0, @0],
                @"1,12" : @[@0, @1],
                @"1,13" : @[@0, @2],
                @"1,14" : @[@0, @3],
                @"0,13" : @[@0, @4],
                @"0,14" : @[@0, @5],
                @"0,15" : @[@0, @6],
                @"0,16" : @[@0, @7],
                @"0,17" : @[@0, @8],
                @"7,10" : @[@6, @4],
                @"7,11" : @[@6, @5],
                @"7,12" : @[@6, @6],
                @"7,13" : @[@6, @7],
                @"7,14" : @[@6, @8],
                @"8,11" : @[@7, @0],
                @"8,12" : @[@7, @1],
                @"8,13" : @[@7, @2],
                @"9,12" : @[@7, @3],
                @"9,13" : @[@7, @4],
                @"9,14" : @[@7, @5],
                @"10,14": @[@7, @6],
                @"10,15": @[@7, @7],
                @"10,16": @[@7, @8],
    };
}

-(NSArray *) mappingFor:(HandsCell *)cell
{
    NSArray *mappedCoordinate = mappingDictionary[[cell coordinateKey]];
    if(mappedCoordinate == nil)
    {
        mappedCoordinate = @[ @(cell.x - 1), @(cell.y) ];
    }
    return mappedCoordinate;
}
               
               

@end
