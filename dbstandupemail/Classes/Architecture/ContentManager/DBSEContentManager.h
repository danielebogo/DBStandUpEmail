//
//  DBSEContentManager.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

@import Foundation;


@class Team;
@interface DBSEContentManager : NSObject

- (void)findFirstTeam:(void(^)(Team *savedTeam))block;
- (void)findDigestsWithTeamId:(NSString *)teamId
                        block:(void(^)(NSArray *digests, NSError *error))block;

@end