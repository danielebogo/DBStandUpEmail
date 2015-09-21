//
//  DBSEHttpClient+Digests.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEHttpClient.h"

@interface DBSEHttpClient (Digests)

- (NSURLSessionDataTask *)digests:(AFHTTPSessionManagerBlockSuccess)successBlock
                          failure:(AFHTTPSessionManagerBlockError)failureBlock
                           teamId:(NSString *)teamId
                        startDate:(NSString *)startDate
                          endDate:(NSString *)endDate;

@end