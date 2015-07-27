//
//  NSString+Localizable.h
//  tripsygo
//
//  Created by Daniele Bogo on 21/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Localizable)

- (NSString *)localizedString;

@end


@interface NSString (ValidateEmail)

- (BOOL)isValidEmail;

@end