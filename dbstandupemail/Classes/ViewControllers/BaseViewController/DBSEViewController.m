//
//  DBSEViewController.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEViewController.h"


@interface DBSEViewController ()

@end

@implementation DBSEViewController
@synthesize shieldView = _shieldView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.navigationTitle;
}


#pragma mark - Override

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (DBSEShieldView *)shieldView
{
    if (!_shieldView) {
        _shieldView = [DBSEShieldView new];
    }
    
    return _shieldView;
}

@end