//
//  Team.m
//  
//
//  Created by Daniele Bogo on 20/09/2015.
//
//

#import "Team.h"
#import "User.h"

#import <MagicalRecord/MagicalRecord.h>


static NSString *const kDBSEUserRelationMappingKey = @"members";


@implementation Team


#pragma mark - Mapping

+ (NSDictionary *)objectMapping
{
    return @{ @"teamId":@"id", @"email":@"email", @"name":@"name", @"members":@"members" };
}

- (id)setData:(NSDictionary *)dictionary
{
    [[self.class objectMapping] enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if (dictionary[value] && [self respondsToSelector:NSSelectorFromString(key)]) {
            if ([key isEqualToString:kDBSEUserRelationMappingKey]) {
                User *user = [User MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                [user setData:dictionary];
                [self addMembersObject:user];
            } else {
                [self setValue:dictionary[value] forKey:key];
            }
        }
    }];
    
    return self;
}

@end