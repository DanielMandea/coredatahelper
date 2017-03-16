//
//  User+CoreDataClass.swift
//
//
//  Created by DanielMandea on 3/16/17.
//
//

import Foundation
import CoreData
import CoreDataHelper


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
