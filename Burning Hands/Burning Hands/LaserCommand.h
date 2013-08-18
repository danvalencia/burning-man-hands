//
//  LaserCommand.h
//  Burning Hands
//
//  Created by Daniel Valencia on 8/17/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLECommand.h"

@interface LaserCommand : NSObject<BLECommand>

-(id)initWithDelay;

@end
