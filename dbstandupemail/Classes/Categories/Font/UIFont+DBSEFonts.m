//
//  UIFont+TPSGFonts.m
//  tripsygo
//
//  Created by Daniele Bogo on 20/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "UIFont+DBSEFonts.h"

static const CGFloat kDBSEDefaultFontSize = 16.0;

static NSString* NSStringFontNameFromType(DBSEFonts type) {
    switch (type) {
        case DBSEFontRegular:
            return @"Roboto-Regular";

        case DBSEFontItalic:
            return @"Roboto-Italic";

        case DBSEFontThin:
            return @"Roboto-Thin";

        case DBSEFontThinItalic:
            return @"Roboto-ThinItalic";

    }
}


@implementation UIFont (TPSGFonts)

+ (UIFont *)dbse_fontTypeRegular
{
    return [self dbse_fontWithType:DBSEFontRegular size:kDBSEDefaultFontSize];
}

+ (UIFont *)dbse_fontTypeItalic
{
    return [self dbse_fontWithType:DBSEFontItalic size:kDBSEDefaultFontSize];
}

+ (UIFont *)dbse_fontTypeThin
{
    return [self dbse_fontWithType:DBSEFontThin size:kDBSEDefaultFontSize];
}

+ (UIFont *)dbse_fontTypeThinItalic
{
    return [self dbse_fontWithType:DBSEFontThinItalic size:kDBSEDefaultFontSize];
}

+ (UIFont *)dbse_fontWithType:(DBSEFonts)type size:(CGFloat)fontSize
{
    return [UIFont fontWithName:NSStringFontNameFromType(type) size:fontSize];
}

@end