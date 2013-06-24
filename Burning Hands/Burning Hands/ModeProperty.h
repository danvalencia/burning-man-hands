//
//  Property.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModeProperty : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) UInt8 code;
@property (nonatomic, readonly) UInt8 size;

-(id)initWithName:(NSString*)name code:(UInt8)code andSize:(UInt8)size;

@end
