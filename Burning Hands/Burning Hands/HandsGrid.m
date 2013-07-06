//
//  HandsGrid.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/4/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsGrid.h"

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

@property (nonatomic, strong) NSMutableArray* pathArray;
@property (nonatomic, strong) NSMutableArray* pathsToFill;

@end

@implementation HandsGrid

- (id)init {
    CGRect drawRect = CGRectMake(20, 40, WIDTH, HEIGHT);

    self = [super initWithFrame:drawRect];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.pathArray = [[NSMutableArray alloc] init];
        self.pathsToFill = [[NSMutableArray alloc] init];
        
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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self.pathArray removeAllObjects];
    [[UIColor whiteColor] setFill];
    [[UIColor blackColor] setStroke];
    
    for(int x=0; x < NUM_COLS; x++)
    {
        for(int y=0; y < NUM_ROWS; y++)
        {
            [self createCellOnX:x Y:y];
        }
    }
    
    if(self.pathsToFill.count > 0)
    {
        for (UIBezierPath *path in self.pathsToFill)
        {
            [[UIColor redColor] setFill];
            [path fill];
            [path stroke];
        }
        [self.pathsToFill removeAllObjects];
    }
    
    // Drawing code
}

-(void)updateLocation:(CGPoint)location
{
    for(UIBezierPath *path in self.pathArray)
    {
        if([path containsPoint:location])
        {
            [self.pathsToFill addObject:path];
            [self setNeedsDisplay];
            return;
        }
    }
}




- (void)createCellOnX:(int)x Y:(int)y
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
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
    
    [aPath fill];
    [aPath stroke];
    
    [self.pathArray addObject:aPath];
}


@end
