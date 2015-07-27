//
//  NSObject+ModelMapping.m
//  tripsygo
//
//  Created by Daniele Bogo on 27/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "NSObject+ModelMapping.h"

@implementation NSObject (ModelMapping)

+ (NSDictionary *)objectMapping
{
    return nil;
}

- (id)setData:(NSDictionary *)dictionary
{
    [[self.class objectMapping] enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if (dictionary[value] && [self respondsToSelector:NSSelectorFromString(key)]) {
            [self setValue:dictionary[value] forKey:key];
        }
    }];
    
    return self;
}

- (NSDictionary *)inverseMapping
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [[self.class objectMapping] enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if ([self valueForKey:key] && [self respondsToSelector:NSSelectorFromString(key)]) {
            [dictionary setValue:[self valueForKey:key] forKey:value];
        }
    }];
    
    return [dictionary copy];
}

@end