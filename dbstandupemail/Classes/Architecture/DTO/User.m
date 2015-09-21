//
//  User.m
//  
//
//  Created by Daniele Bogo on 20/09/2015.
//
//

#import "User.h"


@implementation User

+ (NSDictionary *)objectMapping
{
    return @{ @"userId":@"id", @"email":@"email", @"userName":@"name", @"picture":@"picture" };
}

@end
