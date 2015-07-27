//
//  NSObject+ObjectValidation.m
//  tripsygo
//
//  Created by Daniele Bogo on 20/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "NSObject+ObjectValidation.h"

@implementation NSObject (ObjectValidation)

- (BOOL)isValidObject
{
    return (self && ![self isEqual:[NSNull null]] && [self isKindOfClass:[NSObject class]]);
}

- (BOOL)isValidString
{
    return ([self isValidObject] && [self isKindOfClass:[NSString class]] && ![(NSString *)self isEqualToString:@""]);
}

@end