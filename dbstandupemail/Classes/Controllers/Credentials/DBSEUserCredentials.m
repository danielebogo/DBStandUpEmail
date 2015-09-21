//
//  TPSGUserCredentials.m
//  tripsygo
//
//  Created by Daniele Bogo on 20/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEUserCredentials.h"

#import <MagicalRecord/MagicalRecord.h>


NSString *const kDBSEKeychainServiceName = @"kDBSEKeychainServiceName";


@implementation DBSEUserCredentials

+ (instancetype)sharedInstance
{
    static DBSEUserCredentials *credentials = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        credentials = [DBSEUserCredentials new];
    });
    
    return credentials;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadCredentialsIfFound];
    }
    return self;
}

- (void)setUserAuthId:(NSString *)userAuthId
{
    _userAuthId = userAuthId;
    
    if ([userAuthId isValidString]) {
        [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:[self dbse_sqliteName]];
    }
}


#pragma mark - Public methods

- (void)loadCredentialsIfFound
{
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    
    [query setObject:(__bridge id) kSecClassGenericPassword forKey:(__bridge id) kSecClass];
    [query setObject:kDBSEKeychainServiceName forKey:(__bridge id) kSecAttrService];
    
    [query setObject:(id) kCFBooleanTrue forKey:(__bridge id) kSecReturnAttributes];
    [query setObject:(__bridge id) kSecMatchLimitOne forKey:(__bridge id) kSecMatchLimit];
    
    CFTypeRef result = NULL;
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef) query, &result);
    
    if (err == noErr && result) {
        NSString *authId = [(__bridge NSDictionary *)result objectForKey:(__bridge id) kSecAttrAccount];
        NSData *data = [(__bridge NSDictionary *)result objectForKey:(__bridge id) kSecAttrGeneric];
        NSString *token = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (authId && token) {
            self.userAuthId = authId;
            self.userAuthToken = token;
            
            DLog(@"User credentials %@ - %@", self.userAuthId, self.userAuthToken);
        }
    }
}

- (void)saveCredentials
{
    NSMutableDictionary *query = [NSMutableDictionary dictionary];

    [query setObject:(__bridge id) kSecClassGenericPassword forKey:(__bridge id) kSecClass];
    [query setObject:kDBSEKeychainServiceName forKey:(__bridge id) kSecAttrService];

    OSStatus err = SecItemDelete((__bridge CFDictionaryRef) query);
    if (self.userAuthId && self.userAuthToken && (err == noErr || err == errSecItemNotFound)) {
        [query removeAllObjects];

        [query setObject:(__bridge id) kSecClassGenericPassword forKey:(__bridge id) kSecClass];
        [query setObject:kDBSEKeychainServiceName forKey:(__bridge id) kSecAttrService];
        [query setObject:self.userAuthId forKey:(__bridge id) kSecAttrAccount];
        [query setObject:[self.userAuthToken dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id) kSecAttrGeneric];

        SecItemAdd((__bridge CFDictionaryRef) query, NULL);
    }
}

- (void)logout
{
    self.userAuthId = nil;
    self.userAuthToken = nil;
    [self saveCredentials];
}

- (BOOL)isLoggedIn
{
    return [self.userAuthId isValidString] && [self.userAuthToken isValidString];
}


#pragma mark - Private methods

- (NSString *)dbse_sqliteName
{
    return [NSString stringWithFormat:@"%@.sqlite", self.userAuthId];
}


@end