//
//  DBSETimelineTableView.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSETimelineTableView.h"
#import "DBSETimelineTableViewCell.h"


@implementation DBSETimelineTableView

+ (instancetype)tableView
{
    return [[self alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}


#pragma mark - Public methods

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundView = nil;
    self.separatorColor = [UIColor whiteColor];
    
    [self registerClass:[DBSETimelineTableViewCell class]
 forCellReuseIdentifier:[DBSETimelineTableViewCell dbse_identifier]];
}

@end