//
//  DBSEDataAccessObject+Team.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEDataAccessObject+Team.h"

#import <MagicalRecord/MagicalRecord.h>


@implementation DBSEDataAccessObject (Team)

- (Team *)findTeamById:(NSNumber *)teamId
{
    return [Team MR_findFirstByAttribute:@"teamId"
                               withValue:teamId
                               inContext:[NSManagedObjectContext MR_defaultContext]];
}

- (Team *)findFirstTeam
{
    return [Team MR_findFirst];
}

- (Team *)createTeamFromObject:(NSDictionary *)object
{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    Team *team = [Team MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [team setData:object];
    
    [context MR_saveToPersistentStoreAndWait];
    
    return team;
}

@end