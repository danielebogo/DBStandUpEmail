//
//  DBSEShieldView.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import UIKit;

typedef void(^DBSEShieldBlock)();

@interface DBSEShieldView : UIView

- (void)beginShieldingView:(UIView *)view andInvoke:(DBSEShieldBlock)block;
- (void)endShieldingViewAndInvoke:(DBSEShieldBlock)block;

- (void)beginShieldingView:(UIView *)view;
- (void)endShieldingView;

@end