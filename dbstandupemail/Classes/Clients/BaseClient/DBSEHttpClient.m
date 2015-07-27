//
//  TPSGHttpClient.m
//  tripsygo
//
//  Created by Daniele Bogo on 04/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEHttpClient.h"

static NSString *const kDBSEBaseURL = @"https://standupmail-production.herokuapp.com/api";


@implementation DBSEHttpClient

#pragma mark - Life cycle

- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:kDBSEBaseURL]];
    if (self) {
        DLog(@"BASE %@", self.baseURL);
    }
    return self;
}


#pragma mark - Override Methods

- (NSDictionary *)parameters:(NSDictionary *)dictionary includingAuthentication:(BOOL)auth
{
    NSMutableDictionary *defaultDictionary = [NSMutableDictionary dictionary];
    //    [defaultDictionary setValuesForKeysWithDictionary:@{ @"API-Key":kFublesApiKey }];
    //
    //    if ( dictionary ) {
    //        [defaultDictionary setValuesForKeysWithDictionary:dictionary];
    //    }
    //
    //    if ( [[[User sharedUser] credentials] isValidObject] && auth ) {
    //        [defaultDictionary setValuesForKeysWithDictionary:@{ @"user_id":[[[[User sharedUser] credentials] userId] stringValue],
    //                                                             @"token":[[[User sharedUser] credentials] token] }];
    //    }
    //
    //    NSString *lang = [NSLocale preferredLanguages][0];
    //    NSString *langKey = _languages[lang] ?: @"en_GB";
    //    [defaultDictionary setValue:langKey forKey:@"locale"];
    
    return [defaultDictionary copy];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *request = [super requestWithMethod:method URLString:URLString parameters:parameters];
    return [self db_addDefaultHeaderFieldsForRequest:request];
}

#pragma mark - Private methods

- (NSMutableURLRequest *)db_addDefaultHeaderFieldsForRequest:(NSMutableURLRequest *)request
{
    //////////////////////////////////////////////////////////////////////
    //                                                                  //
    //  If you use default values within your request, add values here  //
    //                                                                  //
    //////////////////////////////////////////////////////////////////////
    
    if ([[DBSEUserCredentials sharedInstance] isLoggedIn]) {
        [request setValue:[DBSEUserCredentials sharedInstance].userToken forHTTPHeaderField:@"Authorization"];
    }
    
    return request;
}


@end