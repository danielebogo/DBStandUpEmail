//
//  UITableViewCell+Identifier.m
//  tripsygo
//
//  Created by Daniele Bogo on 01/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "UITableViewCell+Identifier.h"

@implementation UITableViewCell (Identifier)

+ (NSString *)identifier
{
    return [NSString stringWithFormat:@"k%@Identifier", NSStringFromClass([self class])];
}

@end