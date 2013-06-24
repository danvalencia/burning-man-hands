//
//  Loader.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/2/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "Loader.h"

@interface Loader()
- (NSArray *) buildImagesForAnimation;
@end

@implementation Loader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.animationImages = [self buildImagesForAnimation];
        self.animationDuration = 1.0f;
        self.animationRepeatCount = 0;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        self.animationImages = [self buildImagesForAnimation];
        self.animationDuration = 1.0f;
        self.animationRepeatCount = 0;
        [self startAnimating];
        [self setHidden:NO];
        
    }
    return self;
}

-(NSArray *)buildImagesForAnimation
{
    return [NSArray arrayWithObjects:
            [UIImage imageNamed:@"frame-1.gif"],
            [UIImage imageNamed:@"frame-2.gif"],
            [UIImage imageNamed:@"frame-3.gif"],
            [UIImage imageNamed:@"frame-4.gif"],
            [UIImage imageNamed:@"frame-5.gif"],
            [UIImage imageNamed:@"frame-6.gif"],
            [UIImage imageNamed:@"frame-7.gif"],
            [UIImage imageNamed:@"frame-8.gif"],
            [UIImage imageNamed:@"frame-9.gif"],
            [UIImage imageNamed:@"frame-10.gif"],
            [UIImage imageNamed:@"frame-11.gif"],
            [UIImage imageNamed:@"frame-12.gif"],
            [UIImage imageNamed:@"frame-13.gif"],
            [UIImage imageNamed:@"frame-14.gif"],
            [UIImage imageNamed:@"frame-15.gif"],
            [UIImage imageNamed:@"frame-16.gif"],
            [UIImage imageNamed:@"frame-17.gif"],
            [UIImage imageNamed:@"frame-18.gif"],
            [UIImage imageNamed:@"frame-19.gif"],
            [UIImage imageNamed:@"frame-20.gif"],
            [UIImage imageNamed:@"frame-21.gif"],
            [UIImage imageNamed:@"frame-22.gif"],
            [UIImage imageNamed:@"frame-23.gif"],
            [UIImage imageNamed:@"frame-24.gif"],
            [UIImage imageNamed:@"frame-25.gif"],
            [UIImage imageNamed:@"frame-26.gif"],
            [UIImage imageNamed:@"frame-27.gif"],
            [UIImage imageNamed:@"frame-28.gif"],
            [UIImage imageNamed:@"frame-29.gif"],
            [UIImage imageNamed:@"frame-30.gif"],nil];
}

@end
