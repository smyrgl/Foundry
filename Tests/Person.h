//
//  Person.h
//  Foundry
//
//  Created by John Tumminaro on 4/21/14.
//  Copyright (c) 2014 Tiny Little Gears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Foundry.h"

@interface Person : NSObject <TGFoundryObject>

@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *zipCode;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *ipV4Address;
@property (nonatomic, copy) NSString *ipV6Address;
@property (nonatomic, copy) NSString *hobbies;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *extendedBio;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, assign) int numberOfChildren;

@end
