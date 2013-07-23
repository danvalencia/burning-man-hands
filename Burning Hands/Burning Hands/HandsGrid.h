//
//  HandsGrid.h
//  Burning Hands
//
//  Created by Daniel Valencia on 7/4/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandsCell.h"

@protocol HandsGridDelegate;

@interface HandsGrid : UIView

-(void)updateLocation:(CGPoint)location;

@property (nonatomic, strong) id <HandsGridDelegate> delegate;
@property (nonatomic, strong) UIColor* currentColor;

@end

@protocol HandsGridDelegate <NSObject>

@required
- (void)cellTouched:(HandsCell*)cell;

@end

