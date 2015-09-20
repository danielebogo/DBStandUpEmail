//
//  DBSETimeLineViewController.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSETimeLineViewController.h"
#import "DBSETimelineTableView.h"


@interface DBSETimeLineViewController ()

@end

@implementation DBSETimeLineViewController {
    DBSETimelineTableView *tableView_;
    UIImageView *logoImageView_;
    UIView *strokeView_;
    UIButton *logoutButton_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dbse_buildUI];
    [self dbse_addConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self dbse_loadTeam];
}


#pragma mark - Private methods

- (void)dbse_buildUI
{
//    logoImageView_ = [UIImageView newAutoLayoutView];
//    logoImageView_.image = [UIImage imageNamed:@"LogoNavigation"];
//    [self.view addSubview:logoImageView_];
//    
//    logoutButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
//    logoutButton_.translatesAutoresizingMaskIntoConstraints = NO;
//    logoutButton_.backgroundColor = [UIColor dbse_darkBlue];
//    logoutButton_.titleLabel.font = [UIFont dbse_fontTypeRegular];
//    logoutButton_.layer.cornerRadius = 3.0f;
//    [logoutButton_ setTitle:[@"logout_button_title" localizedString].uppercaseString forState:UIControlStateNormal];
//    [logoutButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [logoutButton_ addTarget:self action:@selector(dbse_logout) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:logoutButton_];
//    
//    strokeView_ = [UIView newAutoLayoutView];
//    strokeView_.backgroundColor = [UIColor dbse_lightGrey];
//    [self.view addSubview:strokeView_];
//    
//    tableView_ = [DBSETimelineTableView tableView];
//    [tableView_ setup];
//    [self.view addSubview:tableView_];
}

- (void)dbse_addConstraints
{
//    [logoImageView_ autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20.f];
//    [logoImageView_ autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:40.f];
//    
//    [logoutButton_ autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-20.0f];
//    [logoutButton_ autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:40.0f];
//    [logoutButton_ autoSetDimensionsToSize:(CGSize){ 110.0f, 35.0f }];
//    
//    [strokeView_ autoSetDimension:ALDimensionHeight toSize:1.f];
//    [strokeView_ autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets){ 95.f, 0.f, 0.f, 0.f }
//                                          excludingEdge:ALEdgeBottom];
//    
//    [tableView_ autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
//    [tableView_ autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:strokeView_];
}

- (void)dbse_logout
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDBSELogout object:nil];
}

- (void)dbse_loadTeam
{
//    __weak typeof(self)weakSelf = self;
//    
//    [self.shieldView beginShieldingView:self.view];
//    
//    [timelineClient_ getTeam:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"TEAM: %@", responseObject);
//        
//        __strong typeof(weakSelf)strongSelf = weakSelf;
//        
//        if ([responseObject isValidObject] &&
//            [operation.response succeded] ) {
//            [strongSelf dbse_loadTimeline];
//        } else {
//            [strongSelf.shieldView endShieldingView];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
}

- (void)dbse_loadTimeline
{
//    __weak typeof(self)weakSelf = self;
//    
//    [timelineClient_ getTimeline:^(AFHTTPRequestOperation *operation, id responseObject) {
//        __strong typeof(weakSelf)strongSelf = weakSelf;
//        
//        [strongSelf.shieldView endShieldingView];
//        
//        if ([responseObject isValidObject] &&
//            [operation.response succeded] ) {
//        }
//    } teamId:@511];
}

@end