//
//  NSObject+ModelMapping.h
//  tripsygo
//
//  Created by Daniele Bogo on 27/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

@import Foundation;

@interface NSObject (ModelMapping)

+ (NSDictionary *)objectMapping;

- (id)setData:(NSDictionary *)dictionary;
- (NSDictionary *)inverseMapping;

@end