//
//  NSManagedObject+Foundry.m
//  
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import "NSManagedObject+Foundry.h"

@implementation NSManagedObject (Foundry)

+ (instancetype)foundryBuild
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You cannot use %@ with a managed object, use foundryBuildWithContext or foundryCreateWithContext instead", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

+ (instancetype)foundryBuildWithContext:(NSManagedObjectContext *)context
{
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
    NSDictionary *attributes = [self foundryAttributes];
    NSDictionary *propertiesByName = object.entity.propertiesByName;
    for (NSString *propertyName in [propertiesByName allKeys]) {
        if (attributes[propertyName]) {
            if ([propertiesByName[propertyName] isKindOfClass:[NSAttributeDescription class]]) {
                [object setValue:attributes[propertyName] forKey:propertyName];
            } else if ([propertiesByName[propertyName] isKindOfClass:[NSRelationshipDescription class]]) {
                
            }
        }
    }
    
    return object;
}

+ (NSArray *)foundryBuildNumber:(NSUInteger)number withContext:(NSManagedObjectContext *)context
{
    NSMutableArray *returnArray = [NSMutableArray new];
    for (int i = 0; i < number; i++) {
        [returnArray addObject:[self foundryBuildWithContext:context]];
    }
    
    return [NSArray arrayWithArray:returnArray];
}

+ (instancetype)foundryCreateWithContext:(NSManagedObjectContext *)context
{
    NSManagedObject *object = [self foundryBuildWithContext:context];
    [context save:nil];
    return object;
}

+ (NSArray *)foundryCreateNumber:(NSUInteger)number withContext:(NSManagedObjectContext *)context
{
    NSArray *builtEntities = [self foundryBuildNumber:number withContext:context];
    [context save:nil];
    return builtEntities;
}

#pragma mark - Private

+ (NSString *)entityName
{
    return NSStringFromClass(self);
}

@end
