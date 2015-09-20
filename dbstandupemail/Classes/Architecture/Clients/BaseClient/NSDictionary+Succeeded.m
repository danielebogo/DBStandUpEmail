//
//  NSDictionary+Succeeded.m
//  tripsygo
//
//  Created by Daniele Bogo on 04/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "NSDictionary+Succeeded.h"


@implementation NSURLResponse (Succeeded)

- (BOOL)dbse_responseSucceded
{
    return ((NSHTTPURLResponse *)self).statusCode == 200 || ((NSHTTPURLResponse *)self).statusCode == 201;
}

@end