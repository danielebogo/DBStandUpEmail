//
//  TPSGUserCredentials.m
//  tripsygo
//
//  Created by Daniele Bogo on 20/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBSEUserCredentials.h"


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
        NSString *email = [(__bridge NSDictionary *)result objectForKey:(__bridge id) kSecAttrAccount];
        NSData *data = [(__bridge NSDictionary *)result objectForKey:(__bridge id) kSecAttrGeneric];
        NSString *token = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (email && token) {
            self.userEmail = email;
            self.userToken = token;

            DLog(@"User credentials %@ - %@", self.userEmail, self.userToken);
        }
    }
}

- (void)saveCredentials
{
        NSMutableDictionary *query = [NSMutableDictionary dictionary];

        [query setObject:(__bridge id) kSecClassGenericPassword forKey:(__bridge id) kSecClass];
        [query setObject:kDBSEKeychainServiceName forKey:(__bridge id) kSecAttrService];

        OSStatus err = SecItemDelete((__bridge CFDictionaryRef) query);
        if (self.userEmail && self.userToken && (err == noErr || err == errSecItemNotFound)) {
            [query removeAllObjects];

            [query setObject:(__bridge id) kSecClassGenericPassword forKey:(__bridge id) kSecClass];
            [query setObject:kDBSEKeychainServiceName forKey:(__bridge id) kSecAttrService];
            [query setObject:self.userEmail forKey:(__bridge id) kSecAttrAccount];
            [query setObject:[self.userToken dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id) kSecAttrGeneric];

            SecItemAdd((__bridge CFDictionaryRef) query, NULL);
        }
}

- (void)logout
{
    self.userEmail = nil;
    self.userToken = nil;
    [self saveCredentials];
}

- (BOOL)isLoggedIn
{
    return [self.userEmail isValidString] && [self.userToken isValidString];
}

//- (TPSGUser *)userFromCredentials
//{
//    return [TPSGUser MR_findFirstByAttribute:@"userEmail"
//                                   withValue:self.userEmail
//                                   inContext:[NSManagedObjectContext MR_defaultContext]];
//}
//
//- (TPSGUser *)userForDictionary:(NSDictionary *)dictionary
//{
//    NSDictionary *userModel = [dictionary copy];
//    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
//    
//    TPSGUser *user = [self userFromCredentials];
//    
//    if (![user isValidObject]) {
//        user = [TPSGUser MR_createEntityInContext:context];
//    }
//    
//    [user setData:userModel];
//    [context MR_saveToPersistentStoreAndWait];
//    
//    return user;
//}


@end