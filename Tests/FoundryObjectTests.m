//
//  FoundryObjectTests.m
//  FoundryTests
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import <XCTest/XCTest.h>
#import "Person.h"
#import "Animal.h"

@interface FoundryObjectTests : XCTestCase

@end

@implementation FoundryObjectTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBuildObject
{
    Person *person = [Person foundryBuild];
    XCTAssert(person, @"There must be a person object returned");
}

- (void)testBatchBuildObjects
{
    NSArray *peopleArray = [Person foundryBuildNumber:10];
    XCTAssert(peopleArray.count == 10, @"There must be 10 people");
    for (id person in peopleArray) {
        XCTAssert([person class] == [Person class], @"The class of each object must be of Person type");
    }
}

- (void)testObjectAttributes
{
    NSDictionary *attributes = [Person foundryAttributes];
    NSDictionary *specs = [Person foundryBuildSpecs];
    XCTAssert(attributes.count == specs.count, @"The attributes dictionary must contain the same number of keys as the specs dictionary");
}

- (void)testBatchObjectAttributes
{
    NSArray *batchAttributes = [Person foundryAttributesNumber:10];
    NSDictionary *specs = [Person foundryBuildSpecs];
    XCTAssert(batchAttributes.count == 10, @"There must be 10 attribute dictionaries returned");
    for (NSDictionary *batchDict in batchAttributes) {
        XCTAssert([batchDict allKeys].count == specs.count, @"The number of keys in each batch dictionary must equal the number of keys in the spec dictionary");
    }
}

- (void)testInvalidAttributeInBuildSpec
{
    Animal *newAnimal;
    XCTAssertNoThrow(newAnimal = [Animal foundryBuild], @"Build should not throw an error");
    XCTAssert(newAnimal, @"There must be an animal returned");
    XCTAssert(newAnimal.name, @"There must be a name");
}

- (void)testMissingAttributesInBuildSpec
{
    Animal *newAnimal;
    XCTAssertNoThrow(newAnimal = [Animal foundryBuild], @"Build should not throw an error");
    XCTAssert(newAnimal, @"There must be an animal returned");
    XCTAssert(!newAnimal.species, @"There should not be a species set");
}

@end
