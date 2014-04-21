//
//  NSObject+Foundry.h
//  
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import <Foundation/Foundation.h>
#import "TGFoundryObject.h"

@interface NSObject (Foundry) <TGFoundryObject>

+ (instancetype)foundryBuild;
+ (NSArray *)foundryBuildNumber:(NSUInteger)number;
+ (NSDictionary *)foundryAttributes;
+ (NSArray *)foundryAttributesNumber:(NSUInteger)number;

@end
