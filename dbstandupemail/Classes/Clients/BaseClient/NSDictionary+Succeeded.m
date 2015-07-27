//
//  NSDictionary+Succeeded.m
//  tripsygo
//
//  Created by Daniele Bogo on 04/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "NSDictionary+Succeeded.h"

@implementation NSDictionary (Succeeded)

- (BOOL)succeeded
{
    return  self && self[@"status"] && [self[@"status"] boolValue];
}

- (NSString *)errorMessage
{
    return self && self[@"error"] ? self[@"error"] : @"";
}

- (void)showError
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention", @"Attention") message:[self errorMessage] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Ok", @"Ok"), nil] show];
    });
}

@end