//
//  DBSETimelineTableViewDelegate.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 21/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSETimelineTableViewDelegate.h"
#import "DBSETimelineTableViewDataSource.h"


@implementation DBSETimelineTableViewDelegate


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBSETimelineTableViewDataSource *datasource = (DBSETimelineTableViewDataSource *)tableView.dataSource;
    
    DBSETimeLineCellType type = [datasource cellTypeAtIndexPath:indexPath];
    
    if (type == DBSETimeLineCellTypeUser) {
        return 120.0;
    }
    
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.0;
}

@end