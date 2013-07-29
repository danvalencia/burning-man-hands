//
//  Burning_HandsTests.m
//  Burning HandsTests
//
//  Created by Daniel Valencia on 2/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "Burning_HandsTests.h"
#import "ColorUtils.h"

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

- (void)testExample
{
    UIColor* myColor = [UIColor cyanColor];
    UInt8 *bytes = [ColorUtils getRGBAsBytes:myColor];
    NSLog(@"%d,%d,%d", bytes[0], bytes[1], bytes[2]);
}

@end
