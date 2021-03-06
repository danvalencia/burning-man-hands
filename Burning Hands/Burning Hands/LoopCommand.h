//
//  VerticalLoopCommand.h
//  Burning Hands
//
//  Created by Daniel Valencia on 8/16/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLECommand.h"

@interface LoopCommand : NSObject<BLECommand>

-(id)initWithColor:(NSString *)color andType:(NSInteger *)loopType;

@end
