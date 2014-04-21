//
//  NSObject+Foundry.m
//  
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import "NSObject+Foundry.h"
#import <MBFaker/MBFaker.h>
#import <objc/runtime.h>

@implementation NSObject (Foundry)

+ (instancetype)foundryBuild
{
    [self foundryWillBuildObject];
    id newObject = [[self alloc] init];
    NSDictionary *attributes = [self foundryAttributes];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *attribute = attributes[propertyName];
            if (attribute) {
                [newObject setValue:attribute forKey:propertyName];
            }
        }
    }
    free(properties);
    [self foundryDidBuildObject:newObject];
    return newObject;
}

+ (NSArray *)foundryBuildNumber:(NSUInteger)number
{
    NSMutableArray *returnArray = [NSMutableArray new];
    for (int i = 0; i < number; i++) {
        [returnArray addObject:[self foundryBuild]];
    }
    
    return [NSArray arrayWithArray:returnArray];
}

+ (NSDictionary *)foundryBuildSpecs
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

+ (NSDictionary *)foundryAttributes
{
    NSMutableDictionary *attributesDict = [NSMutableDictionary new];
    NSDictionary *spec = [self foundryBuildSpecs];
    for (NSString *key in [spec allKeys]) {
        FoundryPropertyType type = [spec[key] integerValue];
        
        switch (type) {
            case FoundryPropertyTypeFirstName:
                [attributesDict setObject:[MBFakerName firstName] forKey:key];
                break;
            case FoundryPropertyTypeLastName:
                [attributesDict setObject:[MBFakerName lastName] forKey:key];
                break;
            case FoundryPropertyTypeFullName:
                [attributesDict setObject:[MBFakerName name] forKey:key];
                break;
            case FoundryPropertyTypeAddress:
                [attributesDict setObject:[MBFakerAddress streetAddress] forKey:key];
                break;
            case FoundryPropertyTypeStreetName:
                [attributesDict setObject:[MBFakerAddress streetName] forKey:key];
                break;
            case FoundryPropertyTypeCity:
                [attributesDict setObject:[MBFakerAddress city] forKey:key];
                break;
            case FoundryPropertyTypeState:
                [attributesDict setObject:[MBFakerAddress city] forKey:key];
                break;
            case FoundryPropertyTypeZipCode:
                [attributesDict setObject:[MBFakerAddress zipCode] forKey:key];
                break;
            case FoundryPropertyTypeCountry:
                [attributesDict setObject:[MBFakerAddress country] forKey:key];
                break;
            case FoundryPropertyTypeLatitude:
            {
                double low_bound = -90.00000000;
                double high_bound = 90.00000000;
                double rndValue = (((double)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
                [attributesDict setObject:[NSNumber numberWithDouble:rndValue] forKey:key];
            }
                break;
            case FoundryPropertyTypeLongitude:
            {
                double low_bound = -180.00000000;
                double high_bound = 180.00000000;
                double rndValue = (((double)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
                [attributesDict setObject:[NSNumber numberWithDouble:rndValue] forKey:key];
            }
                break;
            case FoundryPropertyTypeEmail:
                [attributesDict setObject:[MBFakerInternet email] forKey:key];
                break;
            case FoundryPropertyTypeURL:
                [attributesDict setObject:[MBFakerInternet url] forKey:key];
                break;
            case FoundryPropertyTypeipV4Address:
                [attributesDict setObject:[MBFakerInternet ipV4Address] forKey:key];
                break;
            case FoundryPropertyTypeipV6Address:
                [attributesDict setObject:[MBFakerInternet ipV6Address] forKey:key];
                break;
            case FoundryPropertyTypeLoremIpsumShort:
                [attributesDict setObject:[MBFakerLorem words:arc4random_uniform(5)] forKey:key];
                break;
            case FoundryPropertyTypeLoremIpsumMedium:
                [attributesDict setObject:[MBFakerLorem sentences:arc4random_uniform(5)] forKey:key];
                break;
            case FoundryPropertyTypeLoremIpsumLong:
                [attributesDict setObject:[MBFakerLorem paragraphs:arc4random_uniform(5)] forKey:key];
                break;
            case FoundryPropertyTypePhoneNumber:
                [attributesDict setObject:[MBFakerPhoneNumber phoneNumber] forKey:key];
                break;
            case FoundryPropertyTypeUUID:
                [attributesDict setObject:[[NSUUID UUID] UUIDString] forKey:key];
                break;
            case FoundryPropertyTypeCustom:
                [attributesDict setObject:[self foundryAttributeForProperty:key] forKey:key];
                break;
            default:
                break;
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:attributesDict];
}

+ (NSArray *)foundryAttributesNumber:(NSUInteger)number
{
    NSMutableArray *returnArray = [NSMutableArray new];
    for (int x = 0; x < number; x++) {
        [returnArray addObject:[self foundryAttributes]];
    }
    
    return [NSArray arrayWithArray:returnArray];
}

+ (void)foundryWillBuildObject
{
    // Override and customize
}

+ (void)foundryDidBuildObject:(id)object
{
    // Override and customize
}

@end
