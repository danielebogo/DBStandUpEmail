//
//  UIColor+TPSGColors.m
//  tripsygo
//
//  Created by Daniele Bogo on 20/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "UIColor+DBSEColors.h"
#import "UIColor+Hex.h"


@implementation UIColor (DBSEColors)

+ (UIColor *)dbse_darkGrey
{
    static UIColor *color = nil;
    if (color == nil) {
        color = [UIColor tpsg_colorWithHexValue:0x232a2b andAlpha:1.0];
    }
    return color;
}

+ (UIColor *)dbse_lightGrey
{
    static UIColor *color = nil;
    if (color == nil) {
        color = [UIColor tpsg_colorWithHexValue:0x84878a andAlpha:1.0];
    }
    return color;
}

+ (UIColor *)dbse_darkBlue
{
    static UIColor *color = nil;
    if (color == nil) {
        color = [UIColor tpsg_colorWithHexValue:0x2c83c9 andAlpha:1.0];
    }
    return color;
}

+ (UIColor *)dbse_lightBlue
{
    static UIColor *color = nil;
    if (color == nil) {
        color = [UIColor tpsg_colorWithHexValue:0xf0f4f7 andAlpha:1.0];
    }
    return color;
}

@end