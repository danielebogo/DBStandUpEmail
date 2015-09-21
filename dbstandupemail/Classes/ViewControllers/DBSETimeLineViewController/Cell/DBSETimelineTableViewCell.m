//
//  DBSETimelineTableViewCell.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 21/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSETimelineTableViewCell.h"

#import "UIColor+Hex.h"

#import <Masonry/Masonry.h>


@implementation DBSETimelineTableViewCell {
    NSArray *colors_;
    UIImageView *userImageView_;
    UILabel *userNameLabel_;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        colors_ = @[ @"#e381c4", @"#a3e381", @"e38381" ];
        
        [self dbse_buildUI];
        [self dbse_addConstraints];
    }
    return self;
}


#pragma mark - Public methods

- (void)setUserName:(NSString *)userName userPicture:(NSString *)userPicture
{
    userImageView_.hidden = NO;
    userNameLabel_.hidden = userImageView_.isHidden;
    
    userNameLabel_.text = userName;
    
    self.textLabel.text = @"";
    self.imageView.image = nil;
}

- (void)setUserMessage:(NSString *)message icon:(NSString *)icon
{
    userImageView_.hidden = YES;
    userNameLabel_.hidden = userImageView_.isHidden;
    
    self.textLabel.text = message;
    self.textLabel.font = [icon isValidString] ? [UIFont dbse_fontTypeThin] : [UIFont dbse_fontTypeThinItalic];
    self.imageView.image = [icon isValidString] ? [UIImage imageNamed:icon] : nil;
}


#pragma mark - Private methods

- (void)dbse_buildUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textLabel.numberOfLines = 0;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    userImageView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AvatarPlaceholder"]];
    userImageView_.backgroundColor = [UIColor dbse_colorWithHexString:colors_[(arc4random() % colors_.count)]
                                                             andAlpha:1.0];
    userImageView_.layer.cornerRadius = 40.0;
    userImageView_.clipsToBounds = YES;
    [self.contentView addSubview:userImageView_];
    
    userNameLabel_ = [UILabel new];
    userNameLabel_.numberOfLines = 1;
    userNameLabel_.font = [UIFont dbse_fontTypeRegular];
    userNameLabel_.textColor = [UIColor dbse_darkGrey];
    [self.contentView addSubview:userNameLabel_];
}

- (void)dbse_addConstraints
{
    __weak typeof(self)weakSelf = self;
    
    [userImageView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20.0);
        make.left.mas_equalTo(20.0);
        make.size.mas_equalTo((CGSize){ 80.0, 80.0 });
    }];
    
    [userNameLabel_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).with.insets((UIEdgeInsets){ 20.0, 120.0, 20.0, 20.0 });
    }];
}

@end
