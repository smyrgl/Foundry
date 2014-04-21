//
//  TGFoundryObject.h
//  
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FoundryPropertyType) {
    FoundryPropertyTypeFirstName,
    FoundryPropertyTypeLastName,
    FoundryPropertyTypeFullName,
    FoundryPropertyTypeAddress,
    FoundryPropertyTypeStreetName,
    FoundryPropertyTypeCity,
    FoundryPropertyTypeState,
    FoundryPropertyTypeZipCode,
    FoundryPropertyTypeCountry,
    FoundryPropertyTypeLatitude,
    FoundryPropertyTypeLongitude,
    FoundryPropertyTypeEmail,
    FoundryPropertyTypeURL,
    FoundryPropertyTypeipV4Address,
    FoundryPropertyTypeipV6Address,
    FoundryPropertyTypeLoremIpsumShort,
    FoundryPropertyTypeLoremIpsumMedium,
    FoundryPropertyTypeLoremIpsumLong,
    FoundryPropertyTypePhoneNumber,
    FoundryPropertyTypeUUID,
    FoundryPropertyTypeCustom,
};

@protocol TGFoundryObject <NSObject>

@required
+ (NSDictionary *)foundryBuildSpecs;

@optional
+ (id)foundryAttributeForProperty:(NSString *)property;
+ (void)foundryWillBuildObject;
+ (void)foundryDidBuildObject:(id)object;

@end
