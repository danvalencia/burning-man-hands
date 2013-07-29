//
//  ColorUtils.h
//  Burning Hands
//
//  Created by Daniel Valencia on 7/22/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorUtils : NSObject

+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (UInt8 *) getRGBAsBytes:(UIColor *)color;

@end
