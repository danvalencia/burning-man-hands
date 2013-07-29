//
//  GridMapper.h
//  Burning Hands
//
//  Created by Daniel Valencia on 7/28/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandsCell.h"   

@interface GridMapper : NSObject

-(HandsCell *) getMappingFor:(HandsCell *)cell;

@end
