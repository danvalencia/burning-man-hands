//
//  HandsCell.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/5/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsCell.h"
#import "GridMapper.h"

@interface HandsCell()
{
    GridMapper *gridMapper;
    NSArray *cellMapping;
}

-(BOOL)isEqualToCell:(HandsCell *)otherCell;
-(void)initCellMapping;

@end

@implementation HandsCell

@synthesize x;
@synthesize y;
@synthesize path;
@synthesize color;

-(id) initWithPath:(UIBezierPath*)thePath x:(int)xCoord y:(int)yCoord
{
    self = [super init];
    if (self) {
        self.path = thePath;
        self.x = xCoord;
        self.y = yCoord;
        self.color = [UIColor whiteColor];
        [self initCellMapping];
    }
    return self;
}

-(id) initWithCoordinate:(int)_x y:(int)_y
{
    return [self initWithPath:NULL x:_x y:_y];
}


-(BOOL) containsPoint:(CGPoint)point
{
    return [self.path containsPoint:point];
}

-(NSString*) coordinateKey
{
    return [NSString stringWithFormat:@"%d,%d", self.x, self.y];
}

-(int) xMapping
{
    return cellMapping[0];
}

-(int) yMapping
{
    return cellMapping[1];
}

-(void)initCellMapping
{
    cellMapping = [[GridMapper sharedMapper] mappingFor:self];
}

- (BOOL) isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToCell:other];
}

- (NSUInteger)hash
{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + self.y;
    result = prime * result + self.x;
    return result;
}

-(BOOL) isEqualToCell:(HandsCell *)otherCell
{
    if (self == otherCell)
        return YES;
    if (self.x == otherCell.x && self.y == otherCell.y)
        return YES;
    return NO;
}


@end
