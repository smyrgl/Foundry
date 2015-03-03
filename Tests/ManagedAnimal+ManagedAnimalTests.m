//
//  ManagedAnimal+ManagedAnimalTests.m
//  FoundryTests
//
//  Created by Hirad Motamed on 2015-03-02.
//
//

#import "ManagedAnimal+ManagedAnimalTests.h"

@implementation ManagedAnimal (ManagedAnimalTests)

+(NSDictionary *)foundryBuildSpecs {
    return @{
             @"name": @(FoundryPropertyTypeFirstName),
             @"species": @(FoundryPropertyTypeCustom),
             @"isExtinct": @(FoundryPropertyTypeCustom),
             @"owner": @(FoundryPropertyTypeAnyRelationship)
             };
}

+(id)foundryAttributeForProperty:(NSString *)property {
    if ([property isEqualToString:@"isExtinct"]) {
        return @NO;
    }
    else if ([property isEqualToString:@"species"]) {
        return @"dog";
    }
    
    return nil;
}

@end
