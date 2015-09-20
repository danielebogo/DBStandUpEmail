//
//  NSString+Encryption.h
//  medwhat
//
//  Created by Daniele Bogo on 16/08/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import Foundation;
@import UIKit;


@interface NSString (Encryption)

- (NSString *)sha1;

- (NSString *)md5;

- (NSString *)base64Encoded;
- (NSString *)base64Decoded;

+ (NSString *)hmacSha1WithSecret:(NSString *)secret data:(NSString *)data;

@end