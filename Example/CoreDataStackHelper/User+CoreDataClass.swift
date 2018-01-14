//
//  User+CoreDataClass.swift
//
//
//  Created by DanielMandea on 3/16/17.
//
//

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
    let updatedName = data["name"] as? String
    if name != updatedName {
      name = updatedName
    }
    let updatedUniqueID = data["uniqueID"] as? String
    if uniqueID != updatedUniqueID {
      uniqueID = updatedUniqueID
    }
    let updatedAge = data["age"] as? NSNumber
    if age != updatedAge {
      age = updatedAge
    }
  }
}

// MARK: - CreateOrUpdateManagedObject

extension User: CreateOrUpdateManagedObject {
  static func createOrUpdate(with data: Any, context: NSManagedObjectContext) -> User? {
    guard let dataDict = data as? Dictionary<String, Any>,
      let uniqueID = dataDict["uniqueID"] as? String else {
     return nil
    }
    var user:User?
    let predicate = NSPredicate(format: "uniqueID = %@", uniqueID)
    do {
      user = try User.fetch(with: predicate, in: context)?.first
    } catch {
      print(error)
    }
    
    if user == nil {
      user = User.add(data: data, context: context)
    } else {
      user?.update(with: data)
    }
    return user
  }
  
  static func createOrUpdateMultiple(with data: Array<Any>, context: NSManagedObjectContext) -> Array<User>? {
    var users = [User]()
    for dataEntry in data {
      if let user = createOrUpdate(with: dataEntry, context: context) {
        users.append(user)
      }
    }
    return users
  }
}
