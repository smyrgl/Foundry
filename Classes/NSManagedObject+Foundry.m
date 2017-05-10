//
//  NSManagedObject+Foundry.m
//  
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import "NSManagedObject+Foundry.h"

@interface NSObject (FoundryPrivate)
+(NSDictionary *)foundryAttributesWithSpec:(NSDictionary*)spec;
@end



@implementation NSManagedObject (Foundry)

+ (instancetype)foundryBuild
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You cannot use %@ with a managed object, use foundryBuildWithContext or foundryCreateWithContext instead", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

+ (instancetype)foundryBuildWithContext:(NSManagedObjectContext *)context {
    [self foundryWillBuildObject];
    id instance = [self foundryBuildWithContext:context usingSpec:[self foundryBuildSpecs]];
    [self foundryDidBuildObject:instance];

    return instance;
}

+ (instancetype)foundryBuildWithContext:(NSManagedObjectContext *)context usingSpec:(NSDictionary*)spec
{
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
    NSDictionary *attributes = [self foundryAttributesWithSpec:spec];
    NSDictionary *propertiesByName = object.entity.propertiesByName;
    for (NSString *propertyName in [propertiesByName allKeys]) {
        if ([propertiesByName[propertyName] isKindOfClass:[NSAttributeDescription class]] &&
            attributes[propertyName]) {
            [object setValue:attributes[propertyName] forKey:propertyName];
        } else if ([propertiesByName[propertyName] isKindOfClass:[NSRelationshipDescription class]] &&
                   spec[propertyName]) {
            NSRelationshipDescription* relationship = propertiesByName[propertyName];
            id relatedObject;
            FoundryPropertyType type = [spec[propertyName] integerValue];
            if (type == FoundryPropertyTypeAnyRelationship) {
                NSEntityDescription* relatedEntity = [relationship destinationEntity];
                Class targetClass = NSClassFromString([relatedEntity managedObjectClassName]);
                NSRelationshipDescription* inverse = [relationship inverseRelationship];
                NSMutableDictionary* targetSpec = [[targetClass foundryBuildSpecs] mutableCopy];
                if (inverse) {
                    [targetSpec removeObjectForKey:[inverse name]];
                }
                relatedObject = [targetClass foundryBuildWithContext:context usingSpec:targetSpec];
                relatedObject = [relationship isToMany]? [NSSet setWithObject:relatedObject] : relatedObject;
            }
            else if (type == FoundryPropertyTypeSpecificRelationship) {
                relatedObject = [self foundryRelatedObjectForProperty:propertyName
                                                            inContext:context];
            }
            [object setValue:relatedObject forKey:propertyName];
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
