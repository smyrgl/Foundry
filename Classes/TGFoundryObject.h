//
//  TGFoundryObject.h
//  
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import <Foundation/Foundation.h>


/**
 
 *  ENUM that provides the different property types you can set for a Foundry build spec when conforming to the `TGFoundryObject` protocol.
 
 */

typedef NS_ENUM(NSUInteger, FoundryPropertyType) {
    
    /**
     
     *  Property represents a user's first name.
     
     */
    FoundryPropertyTypeFirstName,
    
    /**
     
     *  Property represents a user's last name.
     
     */
    FoundryPropertyTypeLastName,
    
    /**
     
     *  Property represents a user's full name.  May be assigned Prefixes (such as "Mr.", "Mrs.", "Dr.", etc) or Suffixes (such as "Jr." or "III") or both.
     
     */
    FoundryPropertyTypeFullName,
    
    /**
     
     *  Property represents a full address string.  Will be assigned a value in the format "123 Main Street, Redwood City, CA 94062".
     
     */
    FoundryPropertyTypeAddress,
    
    /**
     
     *  Property represents a street name.  Will be asigned a street name value in the format of "Main Street".
     
     */
    FoundryPropertyTypeStreetName,
    
    /**
     
     *  Property represents a city name.
     
     */
    FoundryPropertyTypeCity,
    
    /**
     
     *  Property represents a state.  Will return one of the valid US 50 states.
     
     */
    FoundryPropertyTypeState,
    
    /**
     
     *  Property represents a zip code, will be assigned a zip code string with the format "xxxxx" or "xxxxx-xxxx".
     
     */
    FoundryPropertyTypeZipCode,
    
    /**
     
     *  Property represents a country, will be assigned a valid country name.
     
     */
    FoundryPropertyTypeCountry,
    
    /**
     
     *  Property represents a latitude, will be assigned a valid latitude value.  Note that because this uses Key-value coding you can use an `NSString`, `double` or event `float` for this attribute type, it's totally up to you.
     
     */
    FoundryPropertyTypeLatitude,
    
    /**
     
     *  Property represents a longitude, will be assigned a valid longitude value.  Note that because this uses Key-value coding you can use an `NSString`, `double` or event `float` for this attribute type, it's totally up to you.
     
     */
    FoundryPropertyTypeLongitude,
    
    /**
     
     *  Property represents a user's email, will be assigned a validly formatted email.
     
     */
    FoundryPropertyTypeEmail,
    
    /**
     
     *  Property represents a URL, will be assigned a validly formatted URL.
     
     */
    FoundryPropertyTypeURL,
    
    /**
     
     *  Property represents an IPv4 address, will be assigned a validly formatted IP.
     
     */
    FoundryPropertyTypeipV4Address,
    
    /**
     
     *  Property represents an IPv6 address, will be assigned a validly formatted IP.
     
     */
    FoundryPropertyTypeipV6Address,
    
    /**
     
     *  Property represents a text blurb, will have a short amount of lorem ipsum words assigned.
     
     */
    FoundryPropertyTypeLoremIpsumShort,
    
    /**
     
     *  Property represents a text blurb, will have a paragraph of lorem ipsum words assigned.
     
     */
    FoundryPropertyTypeLoremIpsumMedium,
    
    /**
     
     *  Property represents a long text blurb, will have several paragraphs of lorem ipsum words assigned.
     
     */
    FoundryPropertyTypeLoremIpsumLong,
    
    /**
     
     *  Property represents a phone number, will have a valid phone number string in a random format such as "xxx-xxx-xxxx" or "(xxx)-xxx-xxxx" assigned.
     
     */
    FoundryPropertyTypePhoneNumber,
    
    /**
     
     *  Property represents a unique identifier, will have a UUID generated and assigned.
     
     */
    FoundryPropertyTypeUUID,
    
    /**
     
     *  Property represents a type not easily expressed by the other types.  Allows to customize the property creation using `foundryAttributeForProperty:` method on `TGFoundryObject` protocol.
     
     */
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
