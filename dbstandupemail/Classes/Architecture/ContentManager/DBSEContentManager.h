//
//  DBSEContentManager.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

@import Foundation;

#import "DBSEHttpClient+Team.h"


@interface DBSEContentManager : NSObject

- (void)findTeamsWithSuccessBlock:(AFHTTPSessionManagerBlockSuccess)successBlock
                     failureBlock:(AFHTTPSessionManagerBlockError)failureBlock;

@end