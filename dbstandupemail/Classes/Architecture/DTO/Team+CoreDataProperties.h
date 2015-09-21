//
//  Team+CoreDataProperties.h
//  
//
//  Created by Daniele Bogo on 20/09/2015.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Team.h"

NS_ASSUME_NONNULL_BEGIN

@interface Team (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *teamId;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<User *> *members;

@end

@interface Team (CoreDataGeneratedAccessors)

- (void)addMembersObject:(User *)value;
- (void)removeMembersObject:(User *)value;
- (void)addMembers:(NSSet<User *> *)values;
- (void)removeMembers:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
