//
//  ManagedPerson.h
//  FoundryTests
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ManagedPerson : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zipCode;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * ipV4Address;
@property (nonatomic, retain) NSString * hobbies;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * extendedBio;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSNumber * numberOfChildren;

@end
