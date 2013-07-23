//
//  HandsGrid.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/4/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsGrid.h"
#import "HandsCell.h"
#import "Constants.h"

#define NUM_COLS 11
#define NUM_ROWS 23
#define COL_WIDTH (WIDTH / NUM_COLS)
#define ROW_WIDTH (HEIGHT / NUM_ROWS)
#define NUM_CELLS (NUM_COLS * NUM_ROWS)
#define LINE_WIDTH 1


@interface HandsGrid()
{
    NSMutableArray *disabledCells;
}

- (void)createCellOn:(int)x y:(int)y;
- (void)initCells;
- (CGPoint)switchCoordinateSystem:(CGPoint)point;
- (void)initTransform;
- (void)initDisabledCells;

@property (nonatomic, strong) NSMutableDictionary* cells;
@property (nonatomic) CGAffineTransform affineTransform;

@end

@implementation HandsGrid

@synthesize delegate;

- (id)init {
    CGRect drawRect = CGRectMake(20, 40, WIDTH, HEIGHT);

    self = [super initWithFrame:drawRect];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.cells = [[NSMutableDictionary alloc] init];
        [self initTransform];
        [self initDisabledCells];
        [self initCells];
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(graphicsContext);
    
    CGContextTranslateCTM(graphicsContext, 0.0, HEIGHT);
    CGContextScaleCTM(graphicsContext, 1.0, -1.0);
    
    for(id key in self.cells)
    {
        HandsCell* cell = [self.cells objectForKey:key];
        [cell.color setFill];
        [cell.path fill];
        [cell.path stroke];
    }
    CGContextRestoreGState(graphicsContext);
}

-(void)updateLocation:(CGPoint)location
{
    CGPoint transformedLocation = [self switchCoordinateSystem:location];
    
    for(id key in self.cells)
    {
        HandsCell* cell = [self.cells objectForKey:key];
        
        if([cell containsPoint:transformedLocation])
        {
            [self.delegate cellTouched:cell];
            cell.color = [UIColor redColor];
            [self setNeedsDisplay];
            return;
        }
    }
}

-(void) initCells
{
    for(int x=0; x < NUM_COLS; x++)
    {
        for(int y=0; y < NUM_ROWS; y++)
        {
            NSString *cellKey = [NSString stringWithFormat:@"%d,%d", x, y];
            if (! [disabledCells containsObject:cellKey])
            {
                [self createCellOn:x y:y];
            }
        }
    }

}

- (void) initDisabledCells
{
    disabledCells = [[NSMutableArray alloc] init];
    [disabledCells addObject:@"0,0"];
    [disabledCells addObject:@"0,1"];
    [disabledCells addObject:@"0,2"];
    [disabledCells addObject:@"0,3"];
    [disabledCells addObject:@"0,4"];
    [disabledCells addObject:@"0,5"];
    [disabledCells addObject:@"0,6"];
    [disabledCells addObject:@"0,7"];
    [disabledCells addObject:@"0,8"];
    [disabledCells addObject:@"0,9"];
    [disabledCells addObject:@"0,10"];
    [disabledCells addObject:@"0,11"];
    [disabledCells addObject:@"0,12"];
    [disabledCells addObject:@"0,18"];
    [disabledCells addObject:@"0,19"];
    [disabledCells addObject:@"0,20"];
    [disabledCells addObject:@"0,21"];
    [disabledCells addObject:@"0,22"];
    [disabledCells addObject:@"1,0"];
    [disabledCells addObject:@"1,1"];
    [disabledCells addObject:@"1,2"];
    [disabledCells addObject:@"1,3"];
    [disabledCells addObject:@"1,4"];
    [disabledCells addObject:@"1,5"];
    [disabledCells addObject:@"1,6"];
    [disabledCells addObject:@"1,7"];
    [disabledCells addObject:@"1,8"];
    [disabledCells addObject:@"1,9"];
    [disabledCells addObject:@"1,15"];
    [disabledCells addObject:@"1,16"];
    [disabledCells addObject:@"1,17"];
    [disabledCells addObject:@"1,18"];
    [disabledCells addObject:@"1,19"];
    [disabledCells addObject:@"1,20"];
    [disabledCells addObject:@"1,21"];
    [disabledCells addObject:@"1,22"];
    [disabledCells addObject:@"2,22"];
    [disabledCells addObject:@"3,15"];
    [disabledCells addObject:@"3,16"];
    [disabledCells addObject:@"3,17"];
    [disabledCells addObject:@"3,18"];
    [disabledCells addObject:@"3,19"];
    [disabledCells addObject:@"3,20"];
    [disabledCells addObject:@"3,21"];
    [disabledCells addObject:@"3,22"];
    [disabledCells addObject:@"5,15"];
    [disabledCells addObject:@"5,16"];
    [disabledCells addObject:@"5,17"];
    [disabledCells addObject:@"5,18"];
    [disabledCells addObject:@"5,19"];
    [disabledCells addObject:@"5,20"];
    [disabledCells addObject:@"5,21"];
    [disabledCells addObject:@"5,22"];
    [disabledCells addObject:@"6,22"];
    [disabledCells addObject:@"7,0"];
    [disabledCells addObject:@"7,1"];
    [disabledCells addObject:@"7,2"];
    [disabledCells addObject:@"7,3"];
    [disabledCells addObject:@"7,4"];
    [disabledCells addObject:@"7,5"];
    [disabledCells addObject:@"7,6"];
    [disabledCells addObject:@"7,7"];
    [disabledCells addObject:@"7,8"];
    [disabledCells addObject:@"7,9"];
    [disabledCells addObject:@"7,15"];
    [disabledCells addObject:@"7,16"];
    [disabledCells addObject:@"7,17"];
    [disabledCells addObject:@"7,18"];
    [disabledCells addObject:@"7,19"];
    [disabledCells addObject:@"7,20"];
    [disabledCells addObject:@"7,21"];
    [disabledCells addObject:@"7,22"];
    [disabledCells addObject:@"8,0"];
    [disabledCells addObject:@"8,1"];
    [disabledCells addObject:@"8,2"];
    [disabledCells addObject:@"8,3"];
    [disabledCells addObject:@"8,4"];
    [disabledCells addObject:@"8,5"];
    [disabledCells addObject:@"8,6"];
    [disabledCells addObject:@"8,7"];
    [disabledCells addObject:@"8,8"];
    [disabledCells addObject:@"8,9"];
    [disabledCells addObject:@"8,14"];
    [disabledCells addObject:@"8,15"];
    [disabledCells addObject:@"8,16"];
    [disabledCells addObject:@"8,17"];
    [disabledCells addObject:@"8,18"];
    [disabledCells addObject:@"8,19"];
    [disabledCells addObject:@"8,20"];
    [disabledCells addObject:@"8,21"];
    [disabledCells addObject:@"8,22"];
    [disabledCells addObject:@"9,0"];
    [disabledCells addObject:@"9,1"];
    [disabledCells addObject:@"9,2"];
    [disabledCells addObject:@"9,3"];
    [disabledCells addObject:@"9,4"];
    [disabledCells addObject:@"9,5"];
    [disabledCells addObject:@"9,6"];
    [disabledCells addObject:@"9,7"];
    [disabledCells addObject:@"9,8"];
    [disabledCells addObject:@"9,9"];
    [disabledCells addObject:@"9,10"];
    [disabledCells addObject:@"9,14"];
    [disabledCells addObject:@"9,15"];
    [disabledCells addObject:@"9,16"];
    [disabledCells addObject:@"9,17"];
    [disabledCells addObject:@"9,18"];
    [disabledCells addObject:@"9,19"];
    [disabledCells addObject:@"9,20"];
    [disabledCells addObject:@"9,21"];
    [disabledCells addObject:@"9,22"];
    [disabledCells addObject:@"10,0"];
    [disabledCells addObject:@"10,1"];
    [disabledCells addObject:@"10,2"];
    [disabledCells addObject:@"10,3"];
    [disabledCells addObject:@"10,4"];
    [disabledCells addObject:@"10,5"];
    [disabledCells addObject:@"10,6"];
    [disabledCells addObject:@"10,7"];
    [disabledCells addObject:@"10,8"];
    [disabledCells addObject:@"10,9"];
    [disabledCells addObject:@"10,10"];
    [disabledCells addObject:@"10,11"];
    [disabledCells addObject:@"10,12"];
    [disabledCells addObject:@"10,16"];
    [disabledCells addObject:@"10,17"];
    [disabledCells addObject:@"10,18"];
    [disabledCells addObject:@"10,19"];
    [disabledCells addObject:@"10,20"];
    [disabledCells addObject:@"10,21"];
    [disabledCells addObject:@"10,22"];




}

- (void)createCellOn:(int)x y:(int)y
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
    [aPath closePath];
    
    aPath.lineWidth = LINE_WIDTH;
        
    [self.cells setObject:cell forKey:[cell coordinateKey]];
}

- (void)initTransform
{
    self.affineTransform = CGAffineTransformTranslate(self.transform, 0.0, HEIGHT);
    self.affineTransform = CGAffineTransformScale(self.affineTransform, 1.0, -1.0);
}


- (CGPoint)switchCoordinateSystem:(CGPoint)point
{
    CGPoint newPoint = CGPointApplyAffineTransform(point, self.affineTransform);
    return newPoint;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint nowPoint = [touches.anyObject locationInView:self];
    [self updateLocation:nowPoint];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint nowPoint = [touches.anyObject locationInView:self];
    [self updateLocation:nowPoint];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //clear cell array
    CGPoint nowPoint = [touches.anyObject locationInView:self];
    CGPoint translatedPoint = [self switchCoordinateSystem:nowPoint];
    NSLog(@"Touches Ended on %f,%f!", translatedPoint.x, translatedPoint.y);

}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // clear cell array
    CGPoint nowPoint = [touches.anyObject locationInView:self];
    CGPoint translatedPoint = [self switchCoordinateSystem:nowPoint];
    NSLog(@"Touches Cancelled on %f,%f!", translatedPoint.x, translatedPoint.y);
}

@end
