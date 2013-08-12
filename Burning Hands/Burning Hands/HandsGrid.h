//
//  HandsGrid.h
//  Burning Hands
//
//  Created by Daniel Valencia on 7/4/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hand.h"
#import "HandsCell.h"

@protocol HandsGridDelegate;

@class HandsCell;

@interface HandsGrid : UIView

//-(id)initMirrored;
-(void)updateLocation:(CGPoint)location;
-(id)initWithHand:(Hand *)hand transX:(int)tx transY:(int)ty scaleX:(int)sx scaleY:(int)sy;

@property (nonatomic, strong) id <HandsGridDelegate> delegate;
@property (nonatomic, strong) UIColor* currentColor;
@property (nonatomic, strong) Hand* hand;

@end

@protocol HandsGridDelegate <NSObject>

@required
- (void)cellTouched:(HandsCell*)cell;

@end

