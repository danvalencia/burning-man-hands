//
//  GridMapper.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/28/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "GridMapper.h"
#import "Coordinate.h"

@interface GridMapper()
{
    NSMutableDictionary *mappingDictionary;
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
    mappingDictionary = [[NSMutableDictionary alloc] init];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:0 y:0] forKey:@"1,11"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:0 y:1] forKey:@"1,12"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:0 y:2] forKey:@"1,13"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:0 y:3] forKey:@"1,14"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:0 y:4] forKey:@"0,13"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:0 y:5] forKey:@"0,14"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:0 y:6] forKey:@"0,15"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:0 y:7] forKey:@"0,16"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:0 y:8] forKey:@"0,17"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:6 y:4] forKey:@"7,10"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:6 y:5] forKey:@"7,11"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:6 y:6] forKey:@"7,12"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:6 y:7] forKey:@"7,13"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:6 y:8] forKey:@"7,14"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:7 y:0] forKey:@"8,11"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:7 y:1] forKey:@"8,12"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:7 y:2] forKey:@"8,13"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:7 y:3] forKey:@"9,12"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:7 y:4] forKey:@"9,13"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:7 y:5] forKey:@"9,14"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:7 y:6] forKey:@"10,14"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:7 y:7] forKey:@"10,15"];
    [mappingDictionary setObject:[[Coordinate alloc] initWithX:7 y:8] forKey:@"10,16"];
}

-(Coordinate *) mappingFor:(HandsCell *)cell
{
    if(cell.x == 0 && cell.y ==0)
    {
        int x = cell.x;
        NSLog(@"zero comma zero");
    }
    
    Coordinate *mappedCoordinate = [mappingDictionary objectForKey:[cell coordinateKey]];
    if(!mappedCoordinate)
    {
        mappedCoordinate = [[Coordinate alloc] initWithX:(cell.x - 1) y:cell.y];
    }
    return mappedCoordinate;
}
               
               

@end
