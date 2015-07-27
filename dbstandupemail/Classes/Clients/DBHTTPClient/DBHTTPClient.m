//
//  DBHTTPClient.m
//  tripsygo
//
//  Created by Daniele Bogo on 04/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBHTTPClient.h"

NSString *const kDBMethodGET    = @"GET";
NSString *const kDBMethodPOST   = @"POST";
NSString *const kDBMethodPUT    = @"PUT";
NSString *const kDBMethodDELETE = @"DELETE";


@implementation DBHTTPClient
@synthesize responseSerializer = _responseSerializer;
@synthesize requestSerializer = _requestSerializer;
@synthesize reachabilityManager = _reachabilityManager;


#pragma mark - Factory methods

+ (instancetype)client
{
    return [self new];
}


#pragma mark - Life cycle

- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:@"http://bogodaniele.com"]];
    if (self) {
        DLog(@"BASE %@", self.baseURL);
        
        _responseSerializer = [AFJSONResponseSerializer serializer];
        _requestSerializer = [AFHTTPRequestSerializer serializer];
        
        [self startReachabilityMonitor];
    }
    return self;
}


#pragma mark - Override Blocks

- (AFHTTPRequestOperationBlockError) errorBlock {
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationBlockError errorBlock = ^( AFHTTPRequestOperation *operation, NSError *error ) {
        if ( weakSelf.successBlock ) {
            weakSelf.successBlock(operation, operation.responseObject);
        }
        
        [weakSelf db_actionForStatusCode:operation.response.statusCode];
        
        DLog(@"------ REQUEST ERROR LOG ------");
        DLog(@"Request %@", [operation.request.URL absoluteString]);
        DLog(@"Status Code %ld", (long)operation.response.statusCode);
        DLog(@"Headers %@", operation.response.allHeaderFields);
        DLog(@"Error %@", error.localizedDescription);
        DLog(@"Request Body %@", [[NSString alloc] initWithData:(NSData *)[(NSURLRequest *)operation.request HTTPBody] encoding:NSASCIIStringEncoding]);
        DLog(@"-------------------------------");
    };
    
    return errorBlock;
}


#pragma mark - Override Methods

- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters
                        success:(AFHTTPRequestOperationBlockSuccess)success
                        failure:(AFHTTPRequestOperationBlockError)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:kDBMethodGET URLString:URLString parameters:parameters];
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    [operation.responseSerializer setAcceptableContentTypes:[self db_contentTypes]];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters
                         success:(AFHTTPRequestOperationBlockSuccess)success
                         failure:(AFHTTPRequestOperationBlockError)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:kDBMethodPOST URLString:URLString parameters:parameters];
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    [operation.responseSerializer setAcceptableContentTypes:[self db_contentTypes]];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)PUT:(NSString *)URLString parameters:(id)parameters
                        success:(AFHTTPRequestOperationBlockSuccess)success
                        failure:(AFHTTPRequestOperationBlockError)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:kDBMethodPUT URLString:URLString parameters:parameters];
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    [operation.responseSerializer setAcceptableContentTypes:[self db_contentTypes]];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters
                           success:(AFHTTPRequestOperationBlockSuccess)success
                           failure:(AFHTTPRequestOperationBlockError)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:kDBMethodDELETE URLString:URLString parameters:parameters];
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    [operation.responseSerializer setAcceptableContentTypes:[self db_contentTypes]];
    [self.operationQueue addOperation:operation];
    
    return operation;
}


#pragma mark - Public methods

- (void)startReachabilityMonitor
{
    NSOperationQueue *operationQueue = self.operationQueue;
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                DLog(@"Reachability Ok");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                DLog(@"Reachability Ok");
                break;
        }
    }];
    
    [_reachabilityManager startMonitoring];
}

- (void)checkAndCancelAllOperations
{
    if (self.operationQueue.operationCount > 0) {
        [self.operationQueue cancelAllOperations];
        _cancelAllOperations = YES;
    }
}

- (NSDictionary *)authParameter
{
    return [self parameters:nil includingAuthentication:YES];
}

- (NSDictionary *)parameters:(NSDictionary *)dictionary includingAuthentication:(BOOL)auth
{
    return nil;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *request = [_requestSerializer requestWithMethod:method
                                                               URLString:[self db_absoluteURLStringFrom:URLString]
                                                              parameters:parameters
                                                                   error:nil];
#ifdef DEBUG
    [request setTimeoutInterval:25];
#else
    [request setTimeoutInterval:25];
#endif
    
    DLog(@"PATH %@", request.URL);
    
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

//    [request setValue:@"value" forHTTPHeaderField:@"key-field"];
    return request;
}

- (NSSet *)db_contentTypes
{
    return [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", nil];
}

- (NSString *)db_absoluteURLStringFrom:(NSString *)URLString
{
    return [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
}

- (void)db_actionForStatusCode:(NSInteger)statusCode
{
    switch (statusCode) {
        case 401:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDBSELogout object:nil];
            break;
            
        default:
            break;
    }
}

@end


@implementation AFHTTPRequestOperation (SuccessLog)

- (void)successLog
{
    DLog(@"------ REQUEST SUCCESS LOG ------");
    DLog(@"Request %@", [self.request.URL absoluteString]);
    DLog(@"Status Code %ld", (long)self.response.statusCode);
    DLog(@"Headers %@", self.response.allHeaderFields);
    DLog(@"-------------------------------");
}

@end