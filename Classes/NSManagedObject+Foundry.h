//
//  NSManagedObject+Foundry.h
//  
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import <CoreData/CoreData.h>
#import "NSObject+Foundry.h"
#import "TGFoundryObject.h"

/**
 *  Category for `NSManagedObject` based models.  Because of the lifecycle differences between `NSObject` and `NSManagedObject` it is necessary to use these methods instead of the `foundryBuild` based ones on `NSManagedObject` classes (which will throw exceptions) just as you don't use the regular init methods on NSManagedObjects.
 
    In addition to an equivalent to `foundryBuild` for managed objects, this class also provides the unique `foundryCreateWithContext:` method which builds an object and saves the context before returning.
 */

@interface NSManagedObject (Foundry) <TGFoundryObject>

///------------
/// @name Build
///------------

/**
 *  Creates a new instance of your `NSManagedObject` subclass and inserts it into the provided `NSManagedObjectContext` with values assigned based on your Foundry build spec.
 *
 *  @param context The context you want to insert the object into.
 *
 *  @return The newly created instance of your class.
 */

+ (instancetype)foundryBuildWithContext:(NSManagedObjectContext *)context;

/**
 *  Creates a series of your `NSManagedObject` subclass and inserts them into the provided `NSManagedObjectContext`.  Equivalent to calling `foundryBuildWithContext:` multiple times.
 *
 *  @param number  Number of objects you want to create.
 *  @param context Context you want to insert the objects into.
 *
 *  @return Array of newly inserted objects.
 */

+ (NSArray *)foundryBuildNumber:(NSUInteger)number withContext:(NSManagedObjectContext *)context;

///-------------
/// @name Create
///-------------

/**
 *  Similar to `foundryBuildWithContext:` but after inserting the object into the provided context and assigning values based on the build spec it then saves the context.
 *
 *  @param context Context you want the object inserted into and saved.
 *
 *  @return The newly created and saved instance of your class.
 */

+ (instancetype)foundryCreateWithContext:(NSManagedObjectContext *)context;

/**
 *  Same as `foundryCreateWithContext:` but with multiple objects.  Note that this will create, insert and assign values to all of the objects before saving the context so the context will only save a single time, not once for each object.
 *
 *  @param number  Number of objects you want to create and save.
 *  @param context Context you want the objects inserted into and saved.
 *
 *  @return Array of newly created and saved instances of your class.
 */

+ (NSArray *)foundryCreateNumber:(NSUInteger)number withContext:(NSManagedObjectContext *)context;

@end
