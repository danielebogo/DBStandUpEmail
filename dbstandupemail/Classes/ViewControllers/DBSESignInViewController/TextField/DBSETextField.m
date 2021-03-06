//
//  TPSGTextField.m
//  tripsygo
//
//  Created by Daniele Bogo on 21/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSETextField.h"

#import <Masonry/Masonry.h>


static NSString *NSStringFromFieldType(DBSEFieldsType type)
{
    switch (type) {
        case TPSGFieldsTypeAuthToken:
            return [@"signup_placeholder_token" localizedString];

        case TPSGFieldsTypeAuthId:
            return [@"signup_placeholder_auth_id" localizedString];

        case TPSGFieldsTypeNone:
            return @"";

    }
}


@interface DBSETextField () <UITextFieldDelegate, UIGestureRecognizerDelegate>

@end

@implementation DBSETextField {
    UIImageView *iconView_;
    NSString *title_;
    NSLayoutConstraint *leftInset_;
    BOOL constraintsIsApplied_;
}

+ (NSString *)placeholderForType:(DBSEFieldsType)type
{
    return NSStringFromFieldType(type);
}

- (instancetype)initWithType:(DBSEFieldsType)type
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        title_ = [self.class placeholderForType:type];
        
        _fieldType = type;
        
        [self dbse_buildUI];
    }
    return self;
}


#pragma mark - Private methods

- (void)dbse_buildUI
{
    self.backgroundColor = [UIColor dbse_lightBlue];
    self.layer.cornerRadius = 3.0;
    
    NSDictionary *attributes = @{ NSForegroundColorAttributeName:[UIColor dbse_darkGrey],
                                  NSFontAttributeName:[UIFont dbse_fontTypeThin] };
    
    _textField = [UITextField new];
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.backgroundColor = [UIColor clearColor];
    _textField.textColor = [UIColor dbse_darkBlue];
    _textField.font = [UIFont dbse_fontTypeRegular];
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.tintColor = [UIColor dbse_darkBlue];
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:title_.capitalizedString attributes:attributes];
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.secureTextEntry = NO;
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.keyboardAppearance = UIKeyboardAppearanceDark;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    iconView_ = [UIImageView new];
    iconView_.hidden = YES;
    [self addSubview:iconView_];
}

- (void)dbse_addConstraints
{
    CGFloat left = [_icon isValidObject] ? 50.0f : 15.0f;
    UIEdgeInsets insets = (UIEdgeInsets){ 0, left, 0, 15.0f };
    
    __weak typeof(self)weakSelf = self;
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(insets);
    }];
    
    [iconView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf)strongSelf = weakSelf;

        if (strongSelf) {
            make.left.equalTo(strongSelf).with.offset(15.0);
            make.centerY.equalTo(strongSelf);
        }
    }];
}


#pragma mark - Gesture

- (void)createTapGesturOnView:(id)view
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapGesture setCancelsTouchesInView:NO];
    [tapGesture setDelegate:self];
    [view addGestureRecognizer:tapGesture];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    if ([recognizer view] == self) {
        [_textField becomeFirstResponder];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![NSStringFromClass(touch.view.class) isEqualToString:@"UITextField"];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.textfieldDidBeginEditing) {
        self.textfieldDidBeginEditing(self);
    }

    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.textfieldDidEndEditing) {
        self.textfieldDidEndEditing(self);
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.textfieldShouldChangeText) {
        self.textfieldShouldChangeText(self, [textField.text stringByReplacingCharactersInRange:range withString:string]);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.textfieldShouldReturn) {
        self.textfieldShouldReturn(self);
        return YES;
    }
    return NO;
}


#pragma mark - Override

- (void)setIcon:(UIImage *)icon
{
    _icon = icon;
    iconView_.hidden = ![icon isValidObject];
    iconView_.image = icon;
    
    if ([leftInset_ isValidObject]) {
        leftInset_.constant = [icon isValidObject] ? 55.0f : 0.0f;
    }
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _textField.keyboardType = keyboardType;
}

- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    _textField.returnKeyType = returnKeyType;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _textField.secureTextEntry = secureTextEntry;
}

- (void)updateConstraints
{
    if (!constraintsIsApplied_) {
        [self dbse_addConstraints];
        
        constraintsIsApplied_ = YES;
    }
    
    [super updateConstraints];
}

@end