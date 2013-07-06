//
//  HandsCell.h
//  Burning Hands
//
//  Created by Daniel Valencia on 7/5/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandsCell : NSObject

@property (nonatomic, strong) UIBezierPath* path;
@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic, strong) UIColor* color;

-(id) initWithPath:(UIBezierPath*)path x:(int)x y:(int)y;
-(BOOL) containsPoint:(CGPoint)point;
-(NSString*) coordinateKey;

@end
