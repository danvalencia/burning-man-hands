//
//  ModeDataController.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mode.h"

@interface ModeDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterModesList;

- (NSUInteger)countOfList;
- (Mode *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addMode:(Mode *)mode;

@end
