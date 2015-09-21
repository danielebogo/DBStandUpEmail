//
//  TPSGUserCredentials.h
//  tripsygo
//
//  Created by Daniele Bogo on 20/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import Foundation;


extern NSString *const kDBSEKeychainServiceName;


@interface DBSEUserCredentials : NSObject

@property (nonatomic, strong) NSString *userAuthId;
@property (nonatomic, strong) NSString *userAuthToken;

+ (instancetype)sharedInstance;

- (void)loadCredentialsIfFound;
- (void)saveCredentials;
- (void)logout;
- (BOOL)isLoggedIn;

@end