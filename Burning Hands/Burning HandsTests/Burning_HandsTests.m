//
//  Burning_HandsTests.m
//  Burning HandsTests
//
//  Created by Daniel Valencia on 2/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "Burning_HandsTests.h"
#import "ColorUtils.h"
#import "HandsCell.h"
#import "GridMapper.h"

@implementation Burning_HandsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testColorUtils
{
    UIColor* myColor = [UIColor cyanColor];
    UInt8 *bytes = [ColorUtils getRGBAsBytes:myColor];
    NSLog(@"%d,%d,%d", bytes[0], bytes[1], bytes[2]);
}

-(void)testShouldReturnCorrectMapping
{
    HandsCell *cell = [[HandsCell alloc] initWithCoordinate:1 y:11];
    GridMapper *mapper = [[GridMapper alloc] init];
    NSArray *mappedCoordinates = [mapper mappingFor:cell];
    
    NSNumber *xVal = mappedCoordinates[0];
    NSNumber *yVal = mappedCoordinates[1];
    
    STAssertEquals(xVal, @0, @"x coordinate should equal 0");
    STAssertEquals(yVal, @0, @"y coordinate should equal 0");
}

@end
