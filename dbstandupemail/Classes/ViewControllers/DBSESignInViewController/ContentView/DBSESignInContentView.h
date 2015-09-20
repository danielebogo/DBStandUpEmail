//
//  DBSESignInContentView.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

@import UIKit;

#import "DBSETextField.h"


@interface DBSESignInContentView : UIView

@property (nonatomic, readonly) DBSETextField *usedTextField;
@property (nonatomic, readonly) NSMutableDictionary *fields;
@property (nonatomic, copy) void(^didSelectSigniInButton)(void);

@end
