//
//  Animal.m
//  FoundryTests
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import "Animal.h"

@implementation Animal

+ (NSDictionary *)foundryBuildSpecs
{
    return @{
             @"name":[NSNumber numberWithInteger:FoundryPropertyTypeLoremIpsumShort],
             @"isInsane":[NSNumber numberWithInteger:FoundryPropertyTypeZipCode]
             };
}

@end
