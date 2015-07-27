//
//  UIFont+TPSGFonts.h
//  tripsygo
//
//  Created by Daniele Bogo on 20/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, DBSEFonts) {
    DBSEFontRegular,
    DBSEFontItalic,
    DBSEFontThin,
    DBSEFontThinItalic
};


@interface UIFont (DBSEFonts)

+ (UIFont *)dbse_fontTypeRegular;
+ (UIFont *)dbse_fontTypeItalic;
+ (UIFont *)dbse_fontTypeThin;
+ (UIFont *)dbse_fontTypeThinItalic;
+ (UIFont *)dbse_fontWithType:(DBSEFonts)type size:(CGFloat)fontSize;

@end