//
//  ColorUtils.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/22/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ColorUtils.h"

@implementation ColorUtils

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UInt8 *) getRGBAsBytes:(UIColor *)color
{
    const float* components = CGColorGetComponents(color.CGColor);
    UInt8* bytes = malloc(sizeof(UInt8) * 3);
    for (int i = 0; i < 3; i++) {
        bytes[i] = (UInt8)(components[i] * 255);
        
    }
    return bytes;
}


@end
