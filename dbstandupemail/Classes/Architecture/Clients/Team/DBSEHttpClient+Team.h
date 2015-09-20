//
//  DBSEHttpClient+Team.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEHttpClient.h"


@interface DBSEHttpClient (Team)

- (NSURLSessionDataTask *)teams:(AFHTTPSessionManagerBlockSuccess)successBlock
                        failure:(AFHTTPSessionManagerBlockError)failureBlock;

@end