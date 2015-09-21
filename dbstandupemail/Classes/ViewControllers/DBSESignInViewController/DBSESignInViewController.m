//
//  DBSESignInViewController.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSESignInViewController.h"
#import "DBSESignInContentView.h"
#import "DBSEAlert.h"

#import "DBSEContentManager.h"

#import "Team.h"

#import <Masonry/Masonry.h>


@interface DBSESignInViewController ()

@end

@implementation DBSESignInViewController {
    DBSEContentManager *contentManager_;
    DBSESignInContentView *contentView_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    contentManager_ = [DBSEContentManager new];
    
    [self dbse_buildUI];
    [self dbse_addConstraints];
}


#pragma mark - Private methods

- (void)dbse_buildUI
{
    __weak typeof(self)weakSelf = self;
    
    contentView_ = [DBSESignInContentView new];
    contentView_.didSelectSigniInButton = ^{
        [weakSelf dbse_goAhead];
    };
    [self.view addSubview:contentView_];
}

- (void)dbse_addConstraints
{
    __weak typeof(self)weakSelf = self;
    
    [contentView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

- (void)dbse_goAhead
{
    [contentView_.usedTextField.textField resignFirstResponder];

    NSString *token = contentView_.fields[@(TPSGFieldsTypeAuthToken)];
    NSString *authId = contentView_.fields[@(TPSGFieldsTypeAuthId)];
    
    if (![token isValidString] || ![authId isValidString]) {
        NSString *field = [DBSETextField placeholderForType:![token isValidString] ? TPSGFieldsTypeAuthToken : TPSGFieldsTypeAuthId];
        [DBSEAlert alertForEvent:DBSEAlertEventEmptyField field:field];
        return;
    }
    
    [DBSEUserCredentials sharedInstance].userAuthToken = token;
    [DBSEUserCredentials sharedInstance].userAuthId = authId;
    
    //Call end point
    DLog(@"Fields %@", contentView_.fields);

    __weak typeof(self)weakSelf = self;
    
    [self.shieldView beginShieldingView:self.view];
    
    [contentManager_ findFirstTeam:^(Team *savedTeam) {
        [weakSelf.shieldView endShieldingView];
        
        if (savedTeam) {
            [[DBSEUserCredentials sharedInstance] saveCredentials];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kDBSEUpdateRootViewController object:nil];
            });
        }
    }];
}


@end