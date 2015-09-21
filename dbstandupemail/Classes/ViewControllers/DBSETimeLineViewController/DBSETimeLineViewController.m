//
//  DBSETimeLineViewController.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSETimeLineViewController.h"
#import "DBSETimelineTableView.h"
#import "DBSETimelineTableViewDataSource.h"
#import "DBSETimelineTableViewDelegate.h"
#import "DBSEContentManager.h"

#import "Team.h"

#import <Masonry/Masonry.h>


@interface DBSETimeLineViewController ()

@end

@implementation DBSETimeLineViewController {
    DBSETimelineTableView *tableView_;
    DBSETimelineTableViewDataSource *datasource_;
    DBSETimelineTableViewDelegate *delegate_;
    DBSEContentManager *contentManager_;
    Team *team_;
    UIImageView *logoImageView_;
    UIView *strokeView_;
    UIButton *logoutButton_;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        contentManager_ = [DBSEContentManager new];
        datasource_ = [DBSETimelineTableViewDataSource new];
        delegate_ = [DBSETimelineTableViewDelegate new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self)weakSelf = self;
    
    [contentManager_ findFirstTeam:^(Team *savedTeam) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            if (savedTeam) {
                strongSelf->team_ = savedTeam;
                
                [strongSelf dbse_buildUI];
                [strongSelf dbse_addConstraints];
            }
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self dbse_loadTimeline];
}


#pragma mark - Private methods

- (void)dbse_buildUI
{
    logoImageView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoNavigation"]];
    [self.view addSubview:logoImageView_];

    logoutButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton_.backgroundColor = [UIColor dbse_darkBlue];
    logoutButton_.titleLabel.font = [UIFont dbse_fontTypeRegular];
    logoutButton_.layer.cornerRadius = 3.0f;
    [logoutButton_ setTitle:[@"logout_button_title" localizedString].uppercaseString forState:UIControlStateNormal];
    [logoutButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton_ addTarget:self action:@selector(dbse_logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton_];

    strokeView_ = [UIView new];
    strokeView_.backgroundColor = [UIColor dbse_lightGrey];
    [self.view addSubview:strokeView_];
    
    tableView_ = [DBSETimelineTableView tableView];
    tableView_.dataSource = datasource_;
    tableView_.delegate = delegate_;
    [tableView_ setup];
    [self.view addSubview:tableView_];
    
    [self.shieldView beginShieldingView:self.view];
}

- (void)dbse_addConstraints
{
    __weak typeof(self)weakSelf = self;
    
    [logoImageView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            make.left.equalTo(strongSelf.view).with.offset(20.0);
            make.top.equalTo(strongSelf.view).with.offset(40.0);
        }
    }];
    
    [logoutButton_ mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            make.right.equalTo(strongSelf.view).with.offset(-20.0);
            make.top.equalTo(strongSelf.view).with.offset(40.0);
            make.width.mas_equalTo(110.0);
            make.height.mas_equalTo(35.0);
        }
    }];
    
    [strokeView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            make.top.equalTo(strongSelf.view).with.offset(95.0);
            make.left.equalTo(strongSelf.view);
            make.right.equalTo(strongSelf.view);
            make.height.mas_equalTo(1.0);
        }
    }];
    
    [tableView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            make.top.equalTo(strongSelf->strokeView_.mas_bottom);
            make.left.equalTo(strongSelf.view);
            make.right.equalTo(strongSelf.view);
            make.bottom.equalTo(strongSelf.view);
        }
    }];
}

- (void)dbse_logout
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDBSELogout object:nil];
}

- (void)dbse_loadTimeline
{
    __weak typeof(self)weakSelf = self;
    
    [contentManager_ findDigestsWithTeamId:team_.teamId.stringValue
                                     block:^(NSArray *digests, NSError *error) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            [strongSelf.shieldView endShieldingView];
            
            if (!error) {
                strongSelf->datasource_.digests = digests;
                [strongSelf->tableView_ reloadData];
            }
        }
    }];
}

@end