//
//  DBSESignInViewController.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSESignInViewController.h"
#import "DBSETextField.h"


#import <PureLayout/PureLayout.h>


@interface DBSESignInViewController ()

@end

@implementation DBSESignInViewController {
    UIImageView *logoImageView_;
    DBSETextField *emailField_, *passwordField_, *usedTextField_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dbse_buildUI];
    [self dbse_addConstraints];
}


#pragma mark - Private methods

- (void)dbse_buildUI
{
    logoImageView_ = [UIImageView newAutoLayoutView];
    logoImageView_.image = [UIImage imageNamed:@"LogoSmall"];
    [self.view addSubview:logoImageView_];
    
    __weak typeof(self)weakSelf = self;
    
    void (^textfieldShouldChangeText)(DBSETextField *inputText, NSString *newText) = ^(DBSETextField *inputText, NSString *newText) {
//        __strong typeof(weakSelf)strongSelf = weakSelf;
//        strongSelf->fields_[@(inputText.fieldType)] = [newText isValidString] ? newText : @"";
    };
    
    void(^textfieldDidBeginEditing)(DBSETextField *inputText) = ^(DBSETextField *inputText) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf->usedTextField_ = inputText;
    };
    
    emailField_ = [[DBSETextField alloc] initWithType:TPSGFieldsTypeEmail];
    emailField_.returnKeyType = UIReturnKeyNext;
    emailField_.keyboardType = UIKeyboardTypeEmailAddress;
    emailField_.fieldType = TPSGFieldsTypeEmail;
    emailField_.textfieldDidBeginEditing = textfieldDidBeginEditing;
    emailField_.textfieldShouldReturn = ^(DBSETextField *inputText) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf->passwordField_.textField becomeFirstResponder];
    };
    emailField_.textfieldShouldChangeText = textfieldShouldChangeText;
    [self.view addSubview:emailField_];
    
    passwordField_ = [[DBSETextField alloc] initWithType:TPSGFieldsTypePassword];
    passwordField_.fieldType = TPSGFieldsTypePassword;
    passwordField_.secureTextEntry = YES;
    passwordField_.returnKeyType = UIReturnKeyDone;
    passwordField_.textfieldDidBeginEditing = textfieldDidBeginEditing;
    passwordField_.textfieldShouldReturn = ^(DBSETextField *inputText) {

    };
    passwordField_.textfieldShouldChangeText = textfieldShouldChangeText;
    [self.view addSubview:passwordField_];
}

- (void)dbse_addConstraints
{
    [logoImageView_ autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [logoImageView_ autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:50.0f];
    
    [emailField_ autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:logoImageView_ withOffset:50.0f];
    [emailField_ autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20.0f];
    [emailField_ autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-20.0f];
    [emailField_ autoSetDimension:ALDimensionHeight toSize:40.0f];
    
    [passwordField_ autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:emailField_ withOffset:20.0f];
    [passwordField_ autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20.0f];
    [passwordField_ autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-20.0f];
    [passwordField_ autoSetDimension:ALDimensionHeight toSize:40.0f];
}

@end