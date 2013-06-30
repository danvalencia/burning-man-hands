//
//  Property.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModePropertyDefinition : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) UInt8 code;
@property (nonatomic, readonly) UInt8 size;
@property (nonatomic, readonly) NSString *type;

-(id)initWithName:(NSString *)name code:(UInt8)code size:(UInt8)size type:(NSString *)type;

@end
