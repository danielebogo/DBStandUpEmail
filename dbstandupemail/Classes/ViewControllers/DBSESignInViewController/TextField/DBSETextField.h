//
//  TPSGTextField.h
//  tripsygo
//
//  Created by Daniele Bogo on 21/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, DBSEFieldsType) {
    TPSGFieldsTypeEmail,
    TPSGFieldsTypePassword,
    TPSGFieldsTypeNone
};


@interface DBSETextField : UIView

@property (nonatomic, readonly) UITextField *textField;

@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UIReturnKeyType returnKeyType;

@property (nonatomic, assign) BOOL secureTextEntry;

@property (nonatomic, assign) DBSEFieldsType fieldType;

@property (nonatomic, copy) void(^textfieldDidBeginEditing)(DBSETextField *inputText);
@property (nonatomic, copy) void(^textfieldDidEndEditing)(DBSETextField *inputText);
@property (nonatomic, copy) void(^textfieldShouldReturn)(DBSETextField *inputText);
@property (nonatomic, copy) void(^textfieldShouldChangeText)(DBSETextField *inputText, NSString *newText);

+ (NSString *)placeholderForType:(DBSEFieldsType)type;

- (instancetype)initWithType:(DBSEFieldsType)type;

@end