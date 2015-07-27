//
//  NSDictionary+Succeeded.h
//  tripsygo
//
//  Created by Daniele Bogo on 04/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import Foundation;

@interface NSDictionary (Succeeded)

- (BOOL)succeeded;
- (void)showError;
- (NSString *)errorMessage;

@end