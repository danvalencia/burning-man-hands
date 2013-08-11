//
//  HandsModel.h
//  Burning Hands
//
//  Created by Daniel Valencia on 8/10/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hand.h"

@interface HandsModel : NSObject

@property (nonatomic, strong) Hand *rightHand;
@property (nonatomic, strong) Hand *leftHand;

+(HandsModel *)sharedInstance;

@end
