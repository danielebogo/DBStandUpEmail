//
//  DBSEDataAccessObject+Team.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEDataAccessObject.h"

#import "Team.h"


@interface DBSEDataAccessObject (Team)

- (Team *)findTeamById:(NSNumber *)teamId;
- (Team *)findFirstTeam;
- (Team *)createTeamFromObject:(NSDictionary *)object;

@end