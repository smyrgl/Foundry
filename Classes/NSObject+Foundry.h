//
//  NSObject+Foundry.h
//  
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import <Foundation/Foundation.h>
#import "TGFoundryObject.h"

/**
 Category for NSObject based Models.  Should also work equally well with pretty much any model derivitive in Objective-C but if you want to use CoreData then you should be looking at `NSManagedObject+Foundry.h`.
 */

@interface NSObject (Foundry) <TGFoundryObject>

///------------
/// @name Build
///------------

/**
 *  Builds and returns a new object using Foundry process.  Object must adopt the `TGFoundryObject` protocol method `foundryBuildSpecs` or else this will throw an exception.
 *
 *  @return Instance of the class fully populated with test data per your build specs.
 */

+ (instancetype)foundryBuild;

/**
 *  Builds and returns an array of objects using the Foundry process.
 *
 *  @param number Number of objects you wish to create.
 *
 *  @return Array of newly created objects.
 */

+ (NSArray *)foundryBuildNumber:(NSUInteger)number;

///-----------------
/// @name Attributes
///-----------------

/**
 *  Provides a dictionary of test values based on your object Foundry build spec.  This is similar to `foundryBuild` except that instead of creating an instance of the class, it creates an NSDictionary with values that can populate a valid object.
 *
 *  @return Dictionary of values per the object build spec.
 */

+ (NSDictionary *)foundryAttributes;

/**
 *  Returns an array of object attribute dictionaries which is the equivalent of calling `foundryAttributes` multiple times.
 *
 *  @param number Number of attribute dictionaries you want to create.
 *
 *  @return Array of NSDictionary objects with valid object attributes per the object build spec.
 */

+ (NSArray *)foundryAttributesNumber:(NSUInteger)number;

@end
