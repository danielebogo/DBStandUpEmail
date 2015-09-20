//
//  TPSGAlert.m
//  tripsygo
//
//  Created by Daniele Bogo on 22/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEAlert.h"

static NSString *NSStringFromAlertEvent(DBSEAlertEvents event) {
    switch (event) {
        case DBSEAlertEventEmailNotValid:
            return [@"alert_token" localizedString];

        case DBSEAlertEventEmptyField:
            return [@"alert_empty_field" localizedString];
    }
}

@implementation DBSEAlert

+ (void)alertForEvent:(DBSEAlertEvents)event
{
    [self tpsg_alertWithMessage:NSStringFromAlertEvent(event)
                          title:[@"alert_attention" localizedString]];
}

+ (void)alertForEvent:(DBSEAlertEvents)event field:(NSString *)field
{
    [self tpsg_alertWithMessage:[NSString stringWithFormat:NSStringFromAlertEvent(event), field]
                          title:[@"alert_attention" localizedString]];
}

+ (void)tpsg_alertWithMessage:(NSString *)message title:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
    });
}

@end