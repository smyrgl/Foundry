//
//  ManagedPerson+ManagedPersonTests.m
//  FoundryTests
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import "ManagedPerson+ManagedPersonTests.h"
#import "ManagedAnimal.h"

@implementation ManagedPerson (ManagedPersonTests)

+ (NSDictionary *)foundryBuildSpecs
{
    return @{
             @"name": [NSNumber numberWithInteger:FoundryPropertyTypeFullName],
             @"address": [NSNumber numberWithInteger:FoundryPropertyTypeAddress],
             @"city": [NSNumber numberWithInteger:FoundryPropertyTypeCity],
             @"state": [NSNumber numberWithInteger:FoundryPropertyTypeState],
             @"zipCode": [NSNumber numberWithInteger:FoundryPropertyTypeZipCode],
             @"country": [NSNumber numberWithInteger:FoundryPropertyTypeCountry],
             @"latitude": [NSNumber numberWithInteger:FoundryPropertyTypeLatitude],
             @"longitude": [NSNumber numberWithInteger:FoundryPropertyTypeLongitude],
             @"email": [NSNumber numberWithInteger:FoundryPropertyTypeEmail],
             @"url": [NSNumber numberWithInteger:FoundryPropertyTypeURL],
             @"ipV4Address": [NSNumber numberWithInteger:FoundryPropertyTypeipV4Address],
             @"ipV6Address": [NSNumber numberWithInteger:FoundryPropertyTypeipV6Address],
             @"hobbies": [NSNumber numberWithInteger:FoundryPropertyTypeLoremIpsumShort],
             @"bio": [NSNumber numberWithInteger:FoundryPropertyTypeLoremIpsumMedium],
             @"extendedBio": [NSNumber numberWithInteger:FoundryPropertyTypeLoremIpsumLong],
             @"phoneNumber": [NSNumber numberWithInteger:FoundryPropertyTypePhoneNumber],
             @"uuid": [NSNumber numberWithInteger:FoundryPropertyTypeUUID],
             @"numberOfChildren": [NSNumber numberWithInteger:FoundryPropertyTypeCustom],
             @"pets": @(FoundryPropertyTypeSpecificRelationship)
             };
}

+ (id)foundryAttributeForProperty:(NSString *)property
{
    if ([property isEqualToString:@"numberOfChildren"]) {
        return [NSNumber numberWithInteger:arc4random_uniform(5)];
    }
    
    return nil;
}

+ (id)foundryRelatedObjectForProperty:(NSString *)property
                            inContext:(NSManagedObjectContext *)context {
    if ([property isEqualToString:@"pets"]) {
        NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([ManagedAnimal class])];
        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        // hypothetically, we would search for a specific item here
        NSError* error;
        NSArray* fetchResults = [context executeFetchRequest:fetchRequest error:&error];
        if (fetchRequest == nil) {
            // Log Error
            return nil;
        }
        ManagedAnimal* animal = [fetchResults firstObject];
        if (animal) {
            return [NSSet setWithObject:animal];
        }
    }
    
    return nil;
}

@end
