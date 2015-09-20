//
//  DBSETimelineTableView.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSETimelineTableView.h"

@implementation DBSETimelineTableView

+ (instancetype)tableView
{
    return [[self alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}


#pragma mark - Public methods

- (void)setup
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundView = nil;
}

@end