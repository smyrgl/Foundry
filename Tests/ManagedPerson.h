//
//  ManagedPerson.h
//  FoundryTests
//
//  Created by Hirad Motamed on 2015-03-02.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ManagedAnimal;

@interface ManagedPerson : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * extendedBio;
@property (nonatomic, retain) NSString * hobbies;
@property (nonatomic, retain) NSString * ipV4Address;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numberOfChildren;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSString * zipCode;
@property (nonatomic, retain) NSSet *pets;
@end

@interface ManagedPerson (CoreDataGeneratedAccessors)

- (void)addPetsObject:(ManagedAnimal *)value;
- (void)removePetsObject:(ManagedAnimal *)value;
- (void)addPets:(NSSet *)values;
- (void)removePets:(NSSet *)values;

@end
