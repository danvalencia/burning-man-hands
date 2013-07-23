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
    HandsCell* selectedColorCell;
}

-(void)initPallete;
-(void)initSelectedColorCell;
-(void)createCell:(int) index withColor:(NSString*) color;
-(void)drawCell:(HandsCell*)cell;
-(void)initGestureRecognizers;
-(IBAction)tapRecognized:(UITapGestureRecognizer *)recognizer;


@end

@implementation ColorSelector

- (id)init
{
    CGRect drawRect = CGRectMake(20, 10, WIDTH, CELL_HEIGHT);
    self = [super initWithFrame:drawRect];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initPallete];
        [self initSelectedColorCell];
        [self initGestureRecognizers];
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
              @"#0000FF",
              @"#FFFFFF",
              @"#FF00FF",
              @"#000000", nil ];
    cells = [[NSMutableDictionary alloc] init];
    
    int i = 0;
    
    for (id color in colors)
    {
        [self createCell:i++ withColor:color];
    }
}

-(void)initSelectedColorCell
{
    // Set the starting point of the shape.
    float initialPosX = 1;
    float initialPosY = 0;
    
    UIBezierPath *aPath = [self createPathOnX:initialPosX Y:initialPosY];
    selectedColorCell = [[HandsCell alloc] initWithPath:aPath x:0 y:0];
    [selectedColorCell setColor:[ColorUtils colorFromHexString:@"#FF0000"]];
}

-(void)initGestureRecognizers
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [self addGestureRecognizer:tapRecognizer];
}

- (IBAction)tapRecognized:(UITapGestureRecognizer *)recognizer {
    // Get the location of the gesture
    CGPoint location = [recognizer locationInView:self];
    for(id key in cells)
    {
        HandsCell* cell = [cells objectForKey:key];
        
        if([cell containsPoint:location])
        {
            selectedColorCell.color = cell.color;
            //[self.delegate cellTouched:cell];
            //cell.color = [UIColor redColor];
            [self setNeedsDisplay];
            return;
        }
    }

    
    NSLog(@"Location found in %f, %f", location.x, location.y);
}


-(void)createCell:(int) index withColor:(NSString*) color
{
    // Set the starting point of the shape.
    float initialPosX = PALLETE_START_X + (index * CELL_WIDTH);
    float initialPosY = 0;
    
    UIBezierPath *aPath = [self createPathOnX:initialPosX Y:initialPosY];
    HandsCell *cell = [[HandsCell alloc] initWithPath:aPath x:index y:0];
    [cell setColor:[ColorUtils colorFromHexString:color]];
    [cells setObject:cell forKey:[cell coordinateKey]];
    
}

- (UIBezierPath *)createPathOnX:(float)x Y:(float)y
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(x, y)];
    
    // Draw the lines.
    [aPath addLineToPoint:CGPointMake(x, y + CELL_HEIGHT)];
    [aPath addLineToPoint:CGPointMake(x + CELL_WIDTH, y + CELL_HEIGHT)];
    [aPath addLineToPoint:CGPointMake(x + CELL_WIDTH, y)];
    [aPath closePath];
    
    aPath.lineWidth = 1;
    return aPath;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(graphicsContext);
    
    [self drawCell:selectedColorCell];
    for(id key in cells)
    {
        HandsCell* cell = [cells objectForKey:key];
        [self drawCell:cell];
    }
    CGContextRestoreGState(graphicsContext);
}

-(UIColor*)selectedColor
{
    return selectedColorCell.color;
}

-(void)drawCell:(HandsCell*)cell
{
    [cell.color setFill];
    [cell.path fill];
    [cell.path stroke];
}

@end
