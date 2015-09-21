//
//  DBSETimelineTableViewDataSource.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 21/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

@import Foundation;


typedef NS_ENUM(NSUInteger, DBSETimeLineCellType) {
    DBSETimeLineCellTypeUser,
    DBSETimeLineCellTypeDone,
    DBSETimeLineCellTypeWorking,
    DBSETimeLineCellTypeBlocked,
    DBSETimeLineCellTypeEmpty
};


@interface DBSETimelineTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, copy) NSArray *digests;

- (DBSETimeLineCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)userNameAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)userMessageAtIndexPath:(NSIndexPath *)indexPath;

- (UIFont *)userMessageFontAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)dateForSection:(NSUInteger)section;

@end