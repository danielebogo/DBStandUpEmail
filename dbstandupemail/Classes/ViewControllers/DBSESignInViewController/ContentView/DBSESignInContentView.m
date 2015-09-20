//
//  DBSESignInContentView.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 20/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

#import "DBSESignInContentView.h"
#import "DBSEAlert.h"

#import <Masonry/Masonry.h>


@implementation DBSESignInContentView {
    DBSETextField *tokenField_, *authIdField_;
    UIImageView *logoImageView_;
    UIButton *signButton_;
    UILabel *titleLabel_;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _fields = [NSMutableDictionary new];
        
        [self dbse_buildUI];
        [self dbse_addConstraints];
    }
    return self;
}


#pragma mark - Private methods

- (void)dbse_buildUI
{
    logoImageView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoSmall"]];
    [self addSubview:logoImageView_];
    
    titleLabel_ = [UILabel new];
    titleLabel_.textAlignment = NSTextAlignmentCenter;
    titleLabel_.textColor = [UIColor dbse_darkGrey];
    titleLabel_.font = [UIFont dbse_fontWithType:DBSEFontRegular size:20.f];
    titleLabel_.text = [@"signin_title" localizedString];
    [self addSubview:titleLabel_];
    
    __weak typeof(self)weakSelf = self;
    
    void (^textfieldShouldChangeText)(DBSETextField *inputText, NSString *newText) = ^(DBSETextField *inputText, NSString *newText) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.fields[@(inputText.fieldType)] = [newText isValidString] ? newText : @"";
    };
    
    void(^textfieldDidBeginEditing)(DBSETextField *inputText) = ^(DBSETextField *inputText) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf->_usedTextField = inputText;
    };
    
    tokenField_ = [[DBSETextField alloc] initWithType:TPSGFieldsTypeAuthToken];
    tokenField_.returnKeyType = UIReturnKeyNext;
    tokenField_.fieldType = TPSGFieldsTypeAuthToken;
    tokenField_.textfieldDidBeginEditing = textfieldDidBeginEditing;
    tokenField_.textfieldShouldReturn = ^(DBSETextField *inputText) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf->tokenField_.textField becomeFirstResponder];
    };
    tokenField_.textfieldShouldChangeText = textfieldShouldChangeText;
    [self addSubview:tokenField_];
    
    authIdField_ = [[DBSETextField alloc] initWithType:TPSGFieldsTypeAuthId];
    authIdField_.returnKeyType = UIReturnKeyDone;
    authIdField_.textfieldDidBeginEditing = textfieldDidBeginEditing;
    authIdField_.textfieldShouldReturn = ^(DBSETextField *inputText) {
        [weakSelf dbse_goAhead];
    };
    authIdField_.textfieldShouldChangeText = textfieldShouldChangeText;
    [self addSubview:authIdField_];
    
    signButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
    signButton_.translatesAutoresizingMaskIntoConstraints = NO;
    signButton_.backgroundColor = [UIColor dbse_darkBlue];
    signButton_.titleLabel.font = [UIFont dbse_fontTypeRegular];
    signButton_.layer.cornerRadius = 3.0f;
    [signButton_ setTitle:[@"signin_button_title" localizedString].uppercaseString forState:UIControlStateNormal];
    [signButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signButton_ addTarget:self action:@selector(dbse_goAhead) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:signButton_];
    
#ifdef DEBUG
    _fields[@(TPSGFieldsTypeAuthToken)] = @"Y2fqH5V+uNIoEPIoC0VDW/5J3T4KiSDH0WLoOFYp2S40MRSOih2bHn5EQourG8kTIxkdxbSQmmbd2Odaa2vFnQ==";
    _fields[@(TPSGFieldsTypeAuthId)] = @"1276";
    
    tokenField_.textField.text = _fields[@(TPSGFieldsTypeAuthToken)];
    authIdField_.textField.text = _fields[@(TPSGFieldsTypeAuthId)];
#endif
}

- (void)dbse_addConstraints
{
    __weak typeof(self)weakSelf = self;
    
    [logoImageView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50.0);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    [titleLabel_ mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            make.top.equalTo(strongSelf->logoImageView_.mas_bottom).with.offset(35.0);
            make.left.equalTo(strongSelf).with.offset(20.0);
            make.right.equalTo(strongSelf).with.offset(-20.0);
        }
    }];
    
    [tokenField_ mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            make.top.equalTo(strongSelf->titleLabel_.mas_bottom).with.offset(20.0);
            make.left.equalTo(strongSelf).with.offset(20.0);
            make.right.equalTo(strongSelf).with.offset(-20.0);
            make.height.mas_equalTo(40.0);
        }
    }];
    
    [authIdField_ mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            make.top.equalTo(strongSelf->tokenField_.mas_bottom).with.offset(20.0);
            make.left.equalTo(strongSelf).with.offset(20.0);
            make.right.equalTo(strongSelf).with.offset(-20.0);
            make.height.mas_equalTo(40.0);
        }
    }];
    
    [signButton_ mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        if (strongSelf) {
            make.centerX.equalTo(strongSelf.mas_centerX);
            make.top.equalTo(strongSelf->authIdField_.mas_bottom).with.offset(20.0);
            make.height.mas_equalTo(40.0);
            make.width.mas_equalTo(115.0);
        }
    }];
}

- (void)dbse_goAhead
{
    if (self.didSelectSigniInButton) {
        self.didSelectSigniInButton();
    }
}


@end