//
//  BLECommand.h
//  Burning Hands
//
//  Created by Daniel Valencia on 7/25/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BLECommand <NSObject>

@required

-(NSData*)getData;

@end
