//
//  NSString+Encryption.m
//  medwhat
//
//  Created by Daniele Bogo on 16/08/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "NSString+Encryption.h"

#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>


@implementation NSString (Encryption)

- (NSString *)sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for( NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++ ) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

- (NSString *)base64Encoded
{
    NSData *nsdata = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    if ( [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 ) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [nsdata base64Encoding];
#pragma clang diagnostic pop
    }
    
    return [nsdata base64EncodedStringWithOptions:0];
}

- (NSString *)base64Decoded
{
    NSData *nsdata;
    
    if ( [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 ) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        nsdata = [[NSData alloc] initWithBase64Encoding:self];
#pragma clang diagnostic pop
    } else {
        nsdata = [[NSData alloc] initWithBase64EncodedString:self options:0];
    }
    
    return [[NSString alloc] initWithData:nsdata encoding:NSUTF8StringEncoding];
}

+ (NSString *)hmacSha1WithSecret:(NSString *)secret data:(NSString *)data
{
    const char *cKey = [secret cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    return [HMAC base64EncodedStringWithOptions:0];
}

@end