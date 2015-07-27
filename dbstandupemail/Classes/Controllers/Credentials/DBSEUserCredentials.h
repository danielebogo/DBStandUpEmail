//
//  TPSGUserCredentials.h
//  tripsygo
//
//  Created by Daniele Bogo on 20/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import Foundation;


extern NSString *const kDBSEKeychainServiceName;


//@class TPSGUser;
@interface DBSEUserCredentials : NSObject

@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userToken;

+ (instancetype)sharedInstance;

- (void)loadCredentialsIfFound;
- (void)saveCredentials;
- (void)logout;
- (BOOL)isLoggedIn;

//- (TPSGUser *)userForDictionary:(NSDictionary *)dictionary;
//- (TPSGUser *)userFromCredentials;

@end