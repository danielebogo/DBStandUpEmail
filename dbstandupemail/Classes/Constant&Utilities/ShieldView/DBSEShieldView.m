//
//  DBSEShieldView.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEShieldView.h"

#import <Masonry/Masonry.h>
#import <DGActivityIndicatorView/DGActivityIndicatorView.h>


@implementation DBSEShieldView {
    DGActivityIndicatorView *activityIndicatorView_;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self dbse_buildUI];
        [self dbse_addConstraints];
    }
    return self;
}


#pragma mark - Public methods

- (void)beginShieldingView:(UIView *)view andInvoke:(DBSEShieldBlock)block
{
    if ( [self superview] == view ) {
        if ( block ) {
            block();
        }
        return;
    } else if ( [self superview] ) {
        [self endShieldingViewAndInvoke:^{
            [self beginShieldingView:view andInvoke:block];
        }];
        return;
    }
    
    self.frame = view.bounds;
    self.hidden = NO;
    self.alpha = 0.0;

    [activityIndicatorView_ startAnimating];
    
    [view addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        self.alpha = 1.0;
    } completion:^(BOOL done) {
        if (block)
            block();
    }];
}

- (void)endShieldingViewAndInvoke:(DBSEShieldBlock)block
{
    if ( ![self superview] ) {
        if ( block )
            block();
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [activityIndicatorView_ stopAnimating];
        
        [self removeFromSuperview];
        
        if (block)
            block();
    }];
}

- (void)endShieldingView
{
    [self endShieldingViewAndInvoke:nil];
}

- (void)beginShieldingView:(UIView *)view;
{
    [self beginShieldingView:view andInvoke:nil];
}


#pragma mark - Private methods

- (void)dbse_buildUI
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.85];
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    activityIndicatorView_ = [[DGActivityIndicatorView alloc]
                              initWithType:DGActivityIndicatorAnimationTypeDoubleBounce];
    activityIndicatorView_.frame = self.bounds;
    [self addSubview:activityIndicatorView_];
}

- (void)dbse_addConstraints
{
    __weak typeof(self)weakSelf = self;
    
    [activityIndicatorView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
    }];
}

@end
