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

@interface NSManagedObject (Foundry) <TGFoundryObject>

+ (instancetype)foundryBuildWithContext:(NSManagedObjectContext *)context;
+ (NSArray *)foundryBuildNumber:(NSUInteger)number withContext:(NSManagedObjectContext *)context;
+ (instancetype)foundryCreateWithContext:(NSManagedObjectContext *)context;
+ (NSArray *)foundryCreateNumber:(NSUInteger)number withContext:(NSManagedObjectContext *)context;

@end
