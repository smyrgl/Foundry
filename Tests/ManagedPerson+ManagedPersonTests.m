//
//  ManagedPerson+ManagedPersonTests.m
//  FoundryTests
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import "ManagedPerson+ManagedPersonTests.h"

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
             };
}

+ (id)foundryAttributeForProperty:(NSString *)property
{
    if ([property isEqualToString:@"numberOfChildren"]) {
        return [NSNumber numberWithInteger:arc4random_uniform(5)];
    }
    
    return nil;
}

@end
