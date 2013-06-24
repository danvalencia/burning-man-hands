//
//  Mode.h
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mode : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, readonly) NSArray *properties;

-(id)initWithName:(NSString *)name andProperties:(NSArray *)properties;

@end
