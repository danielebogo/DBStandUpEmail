//
//  DBSEViewController.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import UIKit;

#import "DBSEShieldView.h"


@interface DBSEViewController : UIViewController

@property (nonatomic, readonly) DBSEShieldView *shieldView;
@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, assign, getter=isConstraintsApplied) BOOL applyConstraints;

@end