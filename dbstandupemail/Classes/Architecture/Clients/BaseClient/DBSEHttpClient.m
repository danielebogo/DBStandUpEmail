//
//  TPSGHttpClient.m
//  tripsygo
//
//  Created by Daniele Bogo on 04/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEHttpClient.h"

#import "NSString+Encryption.h"

static NSString *const kDBBaseURL = @"https://www.standupmail.com/api/external/v1";


@implementation DBSEHttpClient {
    NSDateFormatter *dateFormatter_;
    NSLocale *usLocale_;
}


#pragma mark - Life cycle

+ (instancetype)client
{
    return [[self alloc] initWithURL:kDBBaseURL];
}

- (instancetype)initWithURL:(NSString *)URL
{
    self = [super initWithURL:URL];
    if (self) {
        DLog(@"BASE %@", self.baseURL);
        
        usLocale_ = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        
        dateFormatter_ = [NSDateFormatter new];
        dateFormatter_.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
        dateFormatter_.locale = usLocale_;
    }
    return self;
}


#pragma mark - Override Methods

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nonnull, NSError * _Nonnull))completionHandler
{
    NSMutableURLRequest *req = (NSMutableURLRequest *)request;
    
    if ([[DBSEUserCredentials sharedInstance] isLoggedIn]) {
        NSString *contenType = [request.HTTPBody isValidObject] ? @"application/json" : @"";
        
        NSString *date = [dateFormatter_ stringFromDate:[NSDate date]];
        date = [date stringByReplacingOccurrencesOfString:@"am" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"a.m." withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"AM" withString:@""];

        date = [date stringByReplacingOccurrencesOfString:@"pm" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"p.m." withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"PM" withString:@""];

        date = [date stringByReplacingOccurrencesOfString:@"  " withString:@" "];
        
        NSString *relativePath = request.URL.relativePath;
        NSString *query = request.URL.query;
        
        if ([query isValidString]) {
            relativePath = [relativePath stringByAppendingString:@"?"];
            relativePath = [relativePath stringByAppendingString:query];
        }
        
        NSString *canonicalString = [NSString stringWithFormat:@"%@,,%@,%@", contenType, relativePath, date];
        
        NSString *signature = [NSString hmacSha1WithSecret:[DBSEUserCredentials sharedInstance].userAuthToken data:canonicalString];
        
        NSString *auth = [NSString stringWithFormat:@"APIAuth %@:%@", [DBSEUserCredentials sharedInstance].userAuthId, signature];
        
        [req setValue:date forHTTPHeaderField:@"Date"];
        [req setValue:auth forHTTPHeaderField:@"Authorization"];
        
        if ([contenType isValidString]) {
            [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
        
        DLog(@"request %@", request.allHTTPHeaderFields);
        DLog(@"canonical %@", canonicalString);
    }
    
    return [super dataTaskWithRequest:req completionHandler:completionHandler];
}


@end