//
//  DBSEContentManager.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEContentManager.h"


@implementation DBSEContentManager {
    DBSEHttpClient *client_;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        client_ = [DBSEHttpClient client];
    }
    return self;
}


#pragma mark - Public methods

- (void)findTeamsWithSuccessBlock:(AFHTTPSessionManagerBlockSuccess)successBlock
                     failureBlock:(AFHTTPSessionManagerBlockError)failureBlock
{
    [client_ teams:successBlock failure:failureBlock];
}

@end