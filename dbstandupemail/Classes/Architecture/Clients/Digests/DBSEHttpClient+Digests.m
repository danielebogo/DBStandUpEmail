//
//  DBSEHttpClient+Digests.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEHttpClient+Digests.h"


@implementation DBSEHttpClient (Digests)

- (NSURLSessionDataTask *)digests:(AFHTTPSessionManagerBlockSuccess)successBlock
                          failure:(AFHTTPSessionManagerBlockError)failureBlock
                           teamId:(NSString *)teamId
                        startDate:(NSString *)startDate
                          endDate:(NSString *)endDate
{
    return [self GET:[NSString stringWithFormat:@"teams/%@/digests", teamId]
          parameters:@{ @"start_date":startDate, @"end_date":endDate }
             success:successBlock
             failure:failureBlock];
}

@end