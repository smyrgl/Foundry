//
//  Animal.h
//  FoundryTests
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *species;
@property (nonatomic, assign) BOOL isExtinct;

@end
