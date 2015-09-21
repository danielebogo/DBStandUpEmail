//
//  DBSETimelineTableViewDataSource.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 21/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSETimelineTableViewDataSource.h"
#import "DBSETimelineTableViewCell.h"


static NSString *const kDBSEDateKey = @"date";
static NSString *const kDBSEMessageKey = @"message";
static NSString *const kDBSEMessagesKey = @"messages";
static NSString *const kDBSEUserMessageKey = @"msg";
static NSString *const kDBSECellKey = @"cell";
static NSString *const kDBSETypeKey = @"type";
static NSString *const kDBSEUserNameKey = @"user_name";
static NSString *const kDBSEUserIdKey = @"user_id";

static NSString *const kDBSEUserKey = @"user";
static NSString *const kDBSEBlockedKey = @"blocked";
static NSString *const kDBSEDoneKey = @"done";
static NSString *const kDBSEWorkingKey = @"working";
static NSString *const kDBSEEmptyKey = @"empty";


static NSString *NSStringIconNameFromDBSETimeLineCellType(DBSETimeLineCellType type)
{
    switch (type) {
        case DBSETimeLineCellTypeBlocked:
            return @"CrossIcon";
            break;
            
        case DBSETimeLineCellTypeDone:
            return @"TickerIcon";
            break;
            
        case DBSETimeLineCellTypeWorking:
            return @"ArrowIcon";
            break;
            
        default:
            return nil;
            break;
    }
    
    return nil;
}

static DBSETimeLineCellType DBSETimeLineCellTypeFromString(NSString *string)
{
    if ([string isEqualToString:kDBSEUserKey]) {
        return DBSETimeLineCellTypeUser;
    } else if ([string isEqualToString:kDBSEBlockedKey]) {
        return DBSETimeLineCellTypeBlocked;
    } else if ([string isEqualToString:kDBSEDoneKey]) {
        return DBSETimeLineCellTypeDone;
    } else if ([string isEqualToString:kDBSEWorkingKey]) {
        return DBSETimeLineCellTypeWorking;
    }
    
    return DBSETimeLineCellTypeEmpty;
}


@implementation DBSETimelineTableViewDataSource {
    NSMutableArray *daysArray_;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        daysArray_ = [NSMutableArray new];
    }
    return self;
}


#pragma mark - Setter / Getter

- (void)setDigests:(NSArray *)digests
{
    [digests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *date = [NSMutableDictionary dictionary];
        NSMutableArray *cells = [NSMutableArray array];
        
        [(NSArray *)obj[kDBSEMessagesKey]
         enumerateObjectsUsingBlock:^(id  _Nonnull message, NSUInteger idx, BOOL * _Nonnull stop) {
             NSMutableDictionary *userCell = [NSMutableDictionary dictionary];
             userCell[kDBSETypeKey] = kDBSEUserKey;
             userCell[kDBSEUserNameKey] = message[kDBSEUserNameKey];
             userCell[kDBSEUserIdKey] = message[kDBSEUserIdKey];
             [cells addObject:userCell];
             
             if ([(NSArray *)message[kDBSEMessageKey] count] > 0) {
                 [(NSArray *)message[kDBSEMessageKey]
                  enumerateObjectsUsingBlock:^(id  _Nonnull userMessage, NSUInteger idx, BOOL * _Nonnull stop) {
                      NSMutableDictionary *messageCell = [NSMutableDictionary dictionary];
                      messageCell[kDBSETypeKey] = userMessage[kDBSETypeKey];
                      messageCell[kDBSEUserMessageKey] = userMessage[kDBSEUserMessageKey];
                      [cells addObject:messageCell];
                  }];
             } else {
                 NSMutableDictionary *emtpyCell = [NSMutableDictionary dictionary];
                 emtpyCell[kDBSETypeKey] = kDBSEEmptyKey;
                 emtpyCell[kDBSEUserMessageKey] = @"Didn't answer";
                 [cells addObject:emtpyCell];
             }
        }];
        
        date[kDBSEDateKey] = obj[kDBSEDateKey];
        date[kDBSECellKey] = cells;
        
        [daysArray_ addObject:date];
    }];
    
    _digests = [daysArray_ copy];
}


#pragma mark - Public methods

- (DBSETimeLineCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = [self dbse_cellDataAtIndexPath:indexPath];
    return DBSETimeLineCellTypeFromString((NSString *)cellData[kDBSETypeKey]);
}

- (NSString *)userNameAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = [self dbse_cellDataAtIndexPath:indexPath];
    return cellData[kDBSEUserNameKey];
}

- (NSString *)userMessageAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = [self dbse_cellDataAtIndexPath:indexPath];
    return cellData[kDBSEUserMessageKey];
}


#pragma mark - Private methods

- (NSDictionary *)dbse_cellDataAtIndexPath:(NSIndexPath *)indexPath
{
    return _digests[indexPath.section][kDBSECellKey][indexPath.row];
}

- (NSString *)bsu_messageIconForIndexPath:(NSIndexPath *)indexPath
{
    DBSETimeLineCellType type = [self cellTypeAtIndexPath:indexPath];
    return NSStringIconNameFromDBSETimeLineCellType(type);
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _digests.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_digests[section][kDBSECellKey]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBSETimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DBSETimelineTableViewCell dbse_identifier] forIndexPath:indexPath];
    
    DBSETimeLineCellType type = [self cellTypeAtIndexPath:indexPath];
    
    switch (type) {
        case DBSETimeLineCellTypeUser:
            [cell setUserName:[self userNameAtIndexPath:indexPath]
                  userPicture:nil];
            break;
            
        case DBSETimeLineCellTypeBlocked:
        case DBSETimeLineCellTypeDone:
        case DBSETimeLineCellTypeWorking:
        case DBSETimeLineCellTypeEmpty:
            [cell setUserMessage:[self userMessageAtIndexPath:indexPath]
                            icon:[self bsu_messageIconForIndexPath:indexPath]];
            break;
    }
    
    return cell;
}

@end