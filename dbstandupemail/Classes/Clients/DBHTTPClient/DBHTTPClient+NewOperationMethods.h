//
//  DBHTTPClient+NewOperationMethods.h
//  tripsygo
//
//  Created by Daniele Bogo on 04/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBHTTPClient.h"


@interface DBHTTPClient (NewOperationMethods)

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(AFHTTPRequestOperationBlockSuccess)success;
- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(AFHTTPRequestOperationBlockSuccess)success;
- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(AFHTTPRequestOperationBlockSuccess)success;
- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                           success:(AFHTTPRequestOperationBlockSuccess)success;

@end