//
//  HandsGrid.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/4/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsGrid.h"
#import "HandsCell.h"

#define WIDTH 280
#define HEIGHT 360
#define NUM_COLS 11
#define NUM_ROWS 23
#define COL_WIDTH (WIDTH / NUM_COLS)
#define ROW_WIDTH (HEIGHT / NUM_ROWS)
#define NUM_CELLS (NUM_COLS * NUM_ROWS)
#define LINE_WIDTH 1

@interface HandsGrid()

- (void)createCellOnX:(int)x Y:(int)y;
- (void)initializeCells;

@property (nonatomic, strong) NSMutableDictionary* cells;

@end

@implementation HandsGrid

- (id)init {
    CGRect drawRect = CGRectMake(20, 40, WIDTH, HEIGHT);

    self = [super initWithFrame:drawRect];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.cells = [[NSMutableDictionary alloc] init];
        [self initializeCells];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{    
    for(id key in self.cells)
    {
        HandsCell* cell = [self.cells objectForKey:key];
        [cell.color setFill];
        [cell.path fill];
        [cell.path stroke];
    }
}

-(void)updateLocation:(CGPoint)location
{
    for(id key in self.cells)
    {
        HandsCell* cell = [self.cells objectForKey:key];
        
        if([cell containsPoint:location])
        {
            cell.color = [UIColor redColor];
            [self setNeedsDisplay];
            return;
        }
    }
}

-(void) initializeCells
{
    for(int x=0; x < NUM_COLS; x++)
    {
        for(int y=0; y < NUM_ROWS; y++)
        {
            [self createCellOnX:x Y:y];
        }
    }

}

- (void)createCellOnX:(int)x Y:(int)y
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    HandsCell *cell = [[HandsCell alloc] initWithPath:aPath x:x y:y];
        
    float initialPosX = 1.0 + (x * COL_WIDTH);
    float initialPosY = 1.0 + (y * ROW_WIDTH);
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(initialPosX, initialPosY)];
    
    // Draw the lines.
    [aPath addLineToPoint:CGPointMake(initialPosX, initialPosY + ROW_WIDTH)];
    [aPath addLineToPoint:CGPointMake(initialPosX + COL_WIDTH, initialPosY + ROW_WIDTH)];
    [aPath addLineToPoint:CGPointMake(initialPosX + COL_WIDTH, initialPosY)];
    //[aPath addLineToPoint:CGPointMake(0, 0)];
    [aPath closePath];
    
    aPath.lineWidth = LINE_WIDTH;
        
    [self.cells setObject:cell forKey:[cell coordinateKey]];
}


@end
