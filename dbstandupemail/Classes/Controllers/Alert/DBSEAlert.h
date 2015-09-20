//
//  TPSGAlert.h
//  tripsygo
//
//  Created by Daniele Bogo on 22/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import Foundation;


typedef NS_ENUM(NSUInteger, DBSEAlertEvents) {
    DBSEAlertEventEmailNotValid,
    DBSEAlertEventEmptyField
};

@interface DBSEAlert : NSObject

+ (void)alertForEvent:(DBSEAlertEvents)event;
+ (void)alertForEvent:(DBSEAlertEvents)event field:(NSString *)field;

@end