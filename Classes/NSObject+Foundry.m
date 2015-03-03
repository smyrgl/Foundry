//
//  NSObject+Foundry.m
//  
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import "NSObject+Foundry.h"
#import <Gizou/Gizou.h>
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

+ (NSDictionary *)foundryAttributes {
    return [self foundryAttributesWithSpec:[self foundryBuildSpecs]];
}

+ (NSDictionary *)foundryAttributesWithSpec:(NSDictionary*)spec
{
    NSMutableDictionary *attributesDict = [NSMutableDictionary new];
    for (NSString *key in [spec allKeys]) {
        FoundryPropertyType type = [spec[key] integerValue];
        
        switch (type) {
            case FoundryPropertyTypeFirstName:
                [attributesDict setObject:[GZNames firstName] forKey:key];
                break;
            case FoundryPropertyTypeLastName:
                [attributesDict setObject:[GZNames lastName] forKey:key];
                break;
            case FoundryPropertyTypeFullName:
                [attributesDict setObject:[GZNames name] forKey:key];
                break;
            case FoundryPropertyTypeAddress:
                [attributesDict setObject:[GZLocations streetAddress] forKey:key];
                break;
            case FoundryPropertyTypeStreetName:
                [attributesDict setObject:[GZLocations streetName] forKey:key];
                break;
            case FoundryPropertyTypeCity:
                [attributesDict setObject:[GZLocations city] forKey:key];
                break;
            case FoundryPropertyTypeState:
                [attributesDict setObject:[GZLocations city] forKey:key];
                break;
            case FoundryPropertyTypeZipCode:
                [attributesDict setObject:[GZLocations zipCode] forKey:key];
                break;
            case FoundryPropertyTypeCountry:
                [attributesDict setObject:[GZLocations country] forKey:key];
                break;
            case FoundryPropertyTypeLatitude:
            {
                [attributesDict setObject:[NSNumber numberWithDouble:[GZLocations latitude]] forKey:key];
            }
                break;
            case FoundryPropertyTypeLongitude:
            {
                [attributesDict setObject:[NSNumber numberWithDouble:[GZLocations longitude]] forKey:key];
            }
                break;
            case FoundryPropertyTypeEmail:
                [attributesDict setObject:[GZInternet email] forKey:key];
                break;
            case FoundryPropertyTypeURL:
                [attributesDict setObject:[GZInternet url] forKey:key];
                break;
            case FoundryPropertyTypeipV4Address:
                [attributesDict setObject:[GZInternet ipV4Address] forKey:key];
                break;
            case FoundryPropertyTypeipV6Address:
                [attributesDict setObject:[GZInternet ipv6Address] forKey:key];
                break;
            case FoundryPropertyTypeLoremIpsumShort:
                [attributesDict setObject:[GZWords sentence] forKey:key];
                break;
            case FoundryPropertyTypeLoremIpsumMedium:
                [attributesDict setObject:[GZWords paragraph] forKey:key];
                break;
            case FoundryPropertyTypeLoremIpsumLong:
                [attributesDict setObject:[GZWords paragraphs] forKey:key];
                break;
            case FoundryPropertyTypePhoneNumber:
                [attributesDict setObject:[GZPhoneNumbers phoneNumber] forKey:key];
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
