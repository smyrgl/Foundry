# Foundry

[![Build Status](https://travis-ci.org/smyrgl/Foundry.svg?branch=master)](https://travis-ci.org/smyrgl/Foundry)
[![Version](http://cocoapod-badges.herokuapp.com/v/Foundry/badge.png)](http://cocoadocs.org/docsets/Foundry)
[![Platform](http://cocoapod-badges.herokuapp.com/p/Foundry/badge.png)](http://cocoadocs.org/docsets/Foundry)

## Introduction

### What is Foundry?

Foundry is a library for Objective-C developers that can take a lot of pain out of unit testing.  One of the biggest problems during unit testing is the manufacturing of proper test/mock model objects.  Imagine you have a situation where you have a "Person" object that you want to test.  A person has properties like a name, email address, password, etc and so you would need to find a method for creating these test objects.

#### Static method

This is the simplest method where you just create objects and assign them static values like so.

```objective-c
Person *testPerson = [Person new];
testPerson.name = @"Randy Marsh";
testPerson.email = @"badboyrandy@gmail.com";
testPerson.password = @"secret";
```

Well that's easy enough.  Problem is it creates a very narrow path that doesn't really create great tests that are checking the durability of your models.  Let's look at a few problems here:

- All of the values are using a fixed length.  So when doing UI testing we won't be able to see what happens when the values go outside the fixed values we provide.  
- If we need to create several objects we need to copy/paste the same code with different values.  We could use the same values but then we can't test for unique values.
- It requires a lot of maintainence to go back and change these static mocks as we update properties.  

So this method works for little stuff but is quickly unmanageable.  What else is there?

#### Fake data using random strings

This method sucks but we have all used it at some point or another.  It goes something like this: first we define a utility method we can call to generate random strings of a given length, then we do stuff like this:

```objective-c
Person *testPerson = [Person new];
testPerson.name = randomStringWithCharacterCount(10);
testPerson.email = [NSString stringWithFormat@"%@@%@.com", randomStringWithCharacterCount(6), randomStringWithCharacterCount(6)];
testPerson.password = randomStringWithCharacterCount(arc4_random_uniform(8) + 6);
```

This method allow us to create a "dynamic" object that can then be produced many times and get different values.  But it still has a lot of problems:

- This method produces garbage values that aren't indicative of real data.  Random character strings may be good for password generators but not for properties on model objects.
- Because the strings are completely random they won't allow for testing validations without a lot of customization.
- They tend to be very brittle like static data and require a lot of maintainence as you change the model object around.
- They generally suck your will to live.

We can do better right?

#### "Real" fake data using a fake data library

This is a good approach and it involves the use of a fake data library (such as [Gizou](https://github.com/smyrgl/Gizou) which Foundry is built on) to populate the model properties.  Because the data is assembled from a large prebundled set of valid names, prefixes, suffixes, etc it provides very real looking data.  To use it you might do something like this.

```objective-c
Person *testPerson = [Person new];
testPerson.name = [GZNames name];
testPerson.email = [GZInternet email];
testPerson.password = [GZWords word];
```

Ok that's quite a bit better and we now have some nice dynamic objects with real looking data.  But we still have a few disadvantages:

- These factories still require setup and maintainence for each class we create and are a pain to update every time we change a property.
- We need to define constructor methods for each class to build the objects and then provide our own loops to churn out a series of them.
- With Core Data objects we would need to also handle inserting the object into the managed object context and then the save operation.
- We still don't have any ability to customize depedent properties at runtime for special tests.  Setting this up would require even more work.

What we really need is something like [factory_girl](https://github.com/thoughtbot/factory_girl) but for Objective-C...

## Using Foundry

Enter Foundry.  It aims to solve all of these problems by giving you easy ways to mint model objects using "real" data with special handling for Core Data entities and runtime property setting.  All we have to do to get started (after installing Foundry using CocoaPods and importing the "Foundry.h" header) is to take our Person model and adopt the TGFoundryObject protocol.

### With NSObject models

```objective-c

@interface Person : NSObject <TGFoundryObject>
...

```

Then just create a build spec for the object by implementing the single required method `foundryBuildSpecs`.  A build spec is a dictionary that tells Foundry how to build your model and looks like this:

```objective-c
+ (NSDictionary *)foundryBuildSpecs
{
	return @{
		@"name": [NSNumber numberWithInteger:FoundryPropertyTypeName],
		@"email": [NSNumber numberWithInteger:FoundryPropertyTypeEmail],
		@"password": [NSNumber numberWithInteger:FoundryPropertyTypeLoremIpsumShort]
	};
}
```

Although the NSNumber wrappers are annoying this is still really simple.  You just create the specs you want and then Foundry can now build your object like so.

```objective-c
	// Let's build a single person first.

	Person *fullPerson = [Person foundryBuild];

	// Not enough, let's make 10 people!

	NSArray *bunchOfPeople = [Person foundryBuildNumber:10];
```

Nice huh?  What if you just want a hash of valid properties but not the full object?

```objective-c
	// Let's get a dictionary of attributes for a single person.

	NSDictionary *personDictionary = [Person foundryAttributes];

	// Now how about 10 people?

	NSArray *lotsOfPeople = [Person foundryAttributesNumber:10];
```

### With Core Data

Well that's easy.  But what if you use Core Data?  Foundry has you covered.

```objective-c
	// Let's first build a person without saving them.

	Person *newPerson = [Person foundryBuildWithContext:context];

	// How about building AND saving a person?

	Person *anotherPerson = [Person foundryCreateWithContext:context];

	// How about creating 10 saved people?

	NSArray *tenPeople = [Person foundryCreateNumber:10 withContext:context];
```

### Custom attributes

What if you want to manually assign the value yourself during the build process at runtime?  Easy enough, you just set the type to `FoundryPropertyTypeCustom` in the build spec and then you implement the protocol method.

```objective-c
	(id)foundryAttributeForProperty:(NSString *)property
	{
		if ([property isEqualToString:@"name"]) {
			// Add your custom assignment code here...
		}
	}
```

### Relationships

Right now you can set these using the custom property types but very soon Foundry will add the ability to nest factories so that you can assign a factory to a relationship attribute as part of your build spec.  Stay tuned!

## Requirements

Foundry is built for use on both OSX 10.7 and above and iOS 6.0 and above.  Your best bet to to install using CocoaPods.  

If you want to run the test suite, clone the repo, run "pod install" in the main directory and then do "rake spec".

## Documentation

All classes are fully documented using appledoc, you can generate the docs from the repo using "rake docs:generate" or just get them from [Cocoadocs](http://cocoadocs.org).

## Installation

Foundry is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "Foundry"

## Author

John Tumminaro, john@tinylittlegears.com

## License

Foundry is available under the MIT license. See the LICENSE file for more info.

