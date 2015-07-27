//
//  NSString+Localizable.m
//  tripsygo
//
//  Created by Daniele Bogo on 21/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "NSString+Localizable.h"

@implementation NSString (Localizable)

- (NSString *)localizedString
{
    return NSLocalizedString(self, nil);
}

@end


@implementation NSString (ValidateEmail)

- (BOOL)isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end