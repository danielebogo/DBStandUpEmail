//
//  DBSEContentManager.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEContentManager.h"

#import "DBSEHttpClient+Team.h"
#import "DBSEHttpClient+Digests.h"

#import "DBSEDataAccessObject+Team.h"

#import "Team+CoreDataProperties.h"

#import "NSDate+Utilities.h"


@implementation DBSEContentManager {
    DBSEHttpClient *client_;
    DBSEDataAccessObject *dataAccessObject_;
    NSDateFormatter *dateFormatter_;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        client_ = [DBSEHttpClient client];
        dataAccessObject_ = [DBSEDataAccessObject new];
        
        dateFormatter_ = [NSDateFormatter new];
        dateFormatter_.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}


#pragma mark - Public methods

- (void)findFirstTeam:(void(^)(Team *savedTeam))block
{
    Team *team = [dataAccessObject_ findFirstTeam];
    
    if (!team) {
        [client_ teams:^(NSURLSessionDataTask *task, id responseObject) {
            if ([task.response dbse_responseSucceded]) {
                if (((NSArray *)responseObject).count > 0) {
                    block([dataAccessObject_ createTeamFromObject:responseObject[0]]);
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            DLog(@"Eror %@", error);
            block(nil);
        }];
    } else {
        block(team);
    }
}

- (void)findDigestsWithTeamId:(NSString *)teamId
                        block:(void(^)(NSArray *digests, NSError *error))block
{
    NSDate *now = [NSDate date];
    NSDate *daysAgo = [now dateBySubtractingDays:5];
    
    NSString *endDateString = [dateFormatter_ stringFromDate:now];
    NSString *startDateString = [dateFormatter_ stringFromDate:daysAgo];
    
    [client_ digests:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *data = ((NSArray *)responseObject).reverseObjectEnumerator.allObjects;
        DLog(@"success %@", data);
        block(data, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"error %@", error);
        block(nil, error);
    } teamId:teamId startDate:startDateString endDate:endDateString];
}

@end