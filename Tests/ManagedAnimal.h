//
//  ManagedAnimal.h
//  FoundryTests
//
//  Created by Hirad Motamed on 2015-03-02.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ManagedPerson;

@interface ManagedAnimal : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * species;
@property (nonatomic, retain) NSNumber * isExtinct;
@property (nonatomic, retain) ManagedPerson *owner;

@end
