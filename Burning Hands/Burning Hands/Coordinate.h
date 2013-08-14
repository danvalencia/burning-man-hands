//
//  Coordinate.h
//  Burning Hands
//
//  Created by Daniel Valencia on 8/13/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject

@property (nonatomic) int x;
@property (nonatomic) int y;

-(id)initWithX:(int)x y:(int)y;

@end
