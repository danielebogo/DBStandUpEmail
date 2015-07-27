//
//  DBHTTPClient+NewOperationMethods.m
//  tripsygo
//
//  Created by Daniele Bogo on 04/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBHTTPClient+NewOperationMethods.h"

@implementation DBHTTPClient (NewOperationMethods)

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(AFHTTPRequestOperationBlockSuccess)success
{
    self.successBlock = success;
    return [self GET:URLString parameters:parameters success:self.successBlock failure:self.errorBlock];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(AFHTTPRequestOperationBlockSuccess)success
{
    self.successBlock = success;
    return [self POST:URLString parameters:parameters success:self.successBlock failure:self.errorBlock];
}

- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(AFHTTPRequestOperationBlockSuccess)success
{
    self.successBlock = success;
    return [self PUT:URLString parameters:parameters success:self.successBlock failure:self.errorBlock];
}

- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                           success:(AFHTTPRequestOperationBlockSuccess)success
{
    self.successBlock = success;
    return [self DELETE:URLString parameters:parameters success:self.successBlock failure:self.errorBlock];
}

@end