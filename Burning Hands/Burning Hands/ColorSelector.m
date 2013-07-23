//
//  ColorSelector.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/22/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ColorSelector.h"
#import "Constants.h"
#import "HandsCell.h"
#import "ColorUtils.h"

#define CELL_WIDTH 30
#define CELL_HEIGHT 30
#define PALLETE_START_X (CELL_WIDTH + 10) 

@interface ColorSelector() {
    NSMutableDictionary* cells;
    NSArray* colors;
}

-(void)initPallete;
-(void)createCell:(int) index withColor:(NSString*) color;

@end

@implementation ColorSelector

- (id)init
{
    CGRect drawRect = CGRectMake(20, 5, WIDTH, CELL_HEIGHT);
    self = [super initWithFrame:drawRect];
    if (self) {
        [self initPallete];
    }
    return self;
}

-(void)initPallete
{
    colors = [[NSArray alloc] initWithObjects:
              @"#FF0000",
              @"#FFFF00",
              @"#00FF00",
              @"#00FFFF",
              @"#FFFFFF",
              @"#FF00FF",
              @"#000000", nil ];
    cells = [[NSMutableDictionary alloc] init];
    
    int i = 1;
    
    for (id color in colors)
    {
        [self createCell:i++ withColor:color];
    }
}

-(void)createCell:(int) index withColor:(NSString*) color
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    float initialPosX = PALLETE_START_X + (index * CELL_WIDTH);
    float initialPosY = 0;
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(initialPosX, initialPosY)];
    
    // Draw the lines.
    [aPath addLineToPoint:CGPointMake(initialPosX, initialPosY + CELL_HEIGHT)];
    [aPath addLineToPoint:CGPointMake(initialPosX + CELL_WIDTH, initialPosY + CELL_HEIGHT)];
    [aPath addLineToPoint:CGPointMake(initialPosX + CELL_WIDTH, initialPosY)];
    [aPath closePath];
    
    aPath.lineWidth = 1;
    HandsCell *cell = [[HandsCell alloc] initWithPath:aPath x:index y:0];
    [cell setColor:[ColorUtils colorFromHexString:color]];
    [cells setObject:cell forKey:[cell coordinateKey]];

}


- (void)drawRect:(CGRect)rect
{
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(graphicsContext);
        
    for(id key in cells)
    {
        HandsCell* cell = [cells objectForKey:key];
        [cell.color setFill];
        [cell.path fill];
        [cell.path stroke];
    }
    CGContextRestoreGState(graphicsContext);
}

@end
