//
//  UIColor+Hex.h
//  BSUCatalog
//
//  Created by Matteo Gobbi on 11/12/2014.
//  Copyright (c) 2014 Busuu. All rights reserved.
//

@import UIKit;

@interface UIColor (Hex)

+ (UIColor*)dbse_colorWithHexValue:(uint)hexValue andAlpha:(float)alpha;
+ (UIColor*)dbse_colorWithHexString:(NSString *)hexString andAlpha:(float)alpha;

@end
