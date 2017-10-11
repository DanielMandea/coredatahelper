# CoreDataStackHelper

[![CI Status](http://img.shields.io/travis/DanielMandea/CoreDataStackHelper.svg?style=flat)](https://travis-ci.org/DanielMandea/CoreDataStackHelper)
[![Version](https://img.shields.io/cocoapods/v/CoreDataStackHelper.svg?style=flat)](http://cocoapods.org/pods/CoreDataStackHelper)
[![License](https://img.shields.io/cocoapods/l/CoreDataStackHelper.svg?style=flat)](http://cocoapods.org/pods/CoreDataStackHelper)
[![Platform](https://img.shields.io/cocoapods/p/CoreDataStackHelper.svg?style=flat)](http://cocoapods.org/pods/CoreDataStackHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Setup Core Data Entries

``` swift

import Foundation
import CoreData
import CoreDataStackHelper


final class User: NSManagedObject, AddManagedObject, SaveManagedObject, Fetch {

}

// MARK: - UpdateManangedObject

extension User: UpdateManangedObject {

    public func update(with data: Any) {
        // Checkout data
        guard let data = data as? Dictionary<String, Any> else {
            return
        }
        // Update managed object
        name = data["name"] as? String
        uniqueID = data["uniqueID"] as? String
        age = data["age"] as? NSNumber
    }
}

```

##  Setup Core Data Stack

To setup core data stack only call this method:

``` swift

/**
Use this method in order to load the persistent store
- parameter name:          The name of the container
- parameter descriptions:  The descriptions related to NSPersistentStoreDescription
- parameter block:         The block that is called after completing the process
*/
@available(iOS 10.0, *)
public func setup(with name: String = kDefatultContainerName, descriptions:Array<NSPersistentStoreDescription>?, comletion block:@escaping LoadPersistentStoreCompletion)

```

Example:

``` swift

// Call setup in your app delegate
Persistence.store.setup(descriptions: nil) { (persistentStoreDescription, error) in
    if let currentError = error {
        print(currentError)
    }
}
```

##  Create new NSManagedObject based on some Dictionary

Helper Methods:

``` swift

/**
This method is called by all managedObjects in order to save single
- parameter data:          The data received for saving
- parameter context:       The context that should handle the fetch
- parameter completion:    The block that is called after the process completed
*/
static func saveSingle(data:Any, context:NSManagedObjectContext, completion:@escaping CompletionBlock)

/**
This method is called by all managedObjects in order to save multiple
- parameter data:          The data received for saving
- parameter context:       The context that should handle the fetch
- parameter completion:    The block that is called after the process completed
*/
static func saveMultiple(data:Array<Any>, context:NSManagedObjectContext, completion:@escaping CompletionBlock)

```

Example:

``` swift
// Save some users
User.saveMultiple(data: users, context: savingContext) { (success, error) in
    // Do smth in the completion
}
```

##  Fetch NSManagedObjects 

Helper methods:

``` swift
/**
Use this method i order to fetch some context based on some predicate
- parameter predicate: The predicte that is used for fetch
- parameter context:   The context that will handle the fetch
- return: An instance of NSArray containing Self or nil
*/
static func fetch(with predicate: NSPredicate?, in context: NSManagedObjectContext) throws -> Array<Self>?
/**
Use this method i order to count an entity in context based on some predicate
- parameter predicate: The predicte that is used for fetch
- parameter context:   The context that will handle the fetch
- return: An instance of Int or nil
*/
static func count(with predicate: NSPredicate?, in context: NSManagedObjectContext) throws -> Int?
```
Example:

``` swift
do {
    if let data = try User.fetch(with: nil, in: self.viewContext) {
        self.allUsers = data
    }
} catch {
    print(error)
}
```

## Requirements

iOS 10

## Installation

CoreDataStackHelper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CoreDataStackHelper"
```

## Author

DanielMandea, daniel.mandea@ro.ibm.com

## License

CoreDataStackHelper is available under the MIT license. See the LICENSE file for more info.
