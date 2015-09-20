//
//  DBSEHttpClient+Team.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEHttpClient+Team.h"

@implementation DBSEHttpClient (Team)

- (NSURLSessionDataTask *)teams:(AFHTTPSessionManagerBlockSuccess)successBlock
                        failure:(AFHTTPSessionManagerBlockError)failureBlock
{
    return [self GET:@"teams" parameters:nil success:successBlock failure:failureBlock];
}

@end