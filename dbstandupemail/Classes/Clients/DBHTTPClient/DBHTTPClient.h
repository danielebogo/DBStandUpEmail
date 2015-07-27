//
//  DBHTTPClient.h
//  tripsygo
//
//  Created by Daniele Bogo on 04/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

extern NSString *const kDBMethodGET;
extern NSString *const kDBMethodPOST;
extern NSString *const kDBMethodPUT;
extern NSString *const kDBMethodDELETE;

typedef void (^AFHTTPRequestOperationBlockError)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^AFHTTPRequestOperationBlockSuccess)(AFHTTPRequestOperation *operation, id responseObject);


@interface DBHTTPClient : AFHTTPRequestOperationManager

@property (nonatomic, copy) AFHTTPRequestOperationBlockError errorBlock;
@property (nonatomic, copy) AFHTTPRequestOperationBlockSuccess successBlock;
@property (nonatomic, assign, getter=areAllOperationsCancelled) BOOL cancelAllOperations;

+ (instancetype)client;

- (void)startReachabilityMonitor;
- (void)checkAndCancelAllOperations;

- (NSDictionary *)authParameter;
- (NSDictionary *)parameters:(NSDictionary *)dictionary includingAuthentication:(BOOL)auth;
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters;

@end


@interface AFHTTPRequestOperation (SuccessLog)

- (void) successLog;

@end