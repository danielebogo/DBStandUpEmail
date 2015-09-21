//
//  DBSETimelineTableViewDelegate.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 21/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSETimelineTableViewDelegate.h"
#import "DBSETimelineTableViewDataSource.h"
#import "DBSETimelineTableView.h"


static const CGFloat kDBSEHeaderHeight = 60.0;
static const CGFloat kDBSECellHeight = 50.0;


@implementation DBSETimelineTableViewDelegate {
    NSMutableParagraphStyle *paragraphStyle_;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        paragraphStyle_ = [NSMutableParagraphStyle new];
        paragraphStyle_.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle_.alignment = NSTextAlignmentLeft;
    }
    return self;
}


- (CGFloat)dbse_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBSETimelineTableViewDataSource *datasource = (DBSETimelineTableViewDataSource *)tableView.dataSource;
    NSString *message = [datasource userMessageAtIndexPath:indexPath];
    
    NSDictionary *attributes = @{ NSFontAttributeName:[datasource userMessageFontAtIndexPath:indexPath],
                                  NSParagraphStyleAttributeName:paragraphStyle_ };
    
    CGFloat width = CGRectGetWidth(tableView.frame);
    CGRect bounds = [message boundingRectWithSize:CGSizeMake(width, 0.0) options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:attributes context:NULL];
    
    if (message.length == 0) {
        return 0.0;
    }
    
    CGFloat height = roundf(CGRectGetHeight(bounds) + 30);
    
    if (height < kDBSECellHeight) {
        height = kDBSECellHeight;
    }
    
    return height;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBSETimelineTableViewDataSource *datasource = (DBSETimelineTableViewDataSource *)tableView.dataSource;
    
    DBSETimeLineCellType type = [datasource cellTypeAtIndexPath:indexPath];
    
    if (type == DBSETimeLineCellTypeUser) {
        return 120.0;
    }
    
    return [self dbse_tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kDBSEHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DBSETimelineTableViewDataSource *datasource = (DBSETimelineTableViewDataSource *)tableView.dataSource;
    
    UIView *container = [[UIView alloc] initWithFrame:(CGRect){ 0.0, 0.0, CGRectGetWidth(tableView.bounds), kDBSEHeaderHeight }];
    container.backgroundColor = [UIColor whiteColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:(CGRect){ 20.0, 0.0, CGRectGetWidth(container.bounds) - 20.0, kDBSEHeaderHeight }];
    headerLabel.numberOfLines = 1;
    headerLabel.font = [UIFont dbse_fontWithType:DBSEFontRegular size:24.0];
    headerLabel.textColor = [UIColor dbse_darkGrey];
    headerLabel.text = [datasource dateForSection:section];
    [container addSubview:headerLabel];
    
    return container;
}

@end