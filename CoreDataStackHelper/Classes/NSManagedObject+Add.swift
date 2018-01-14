//
//  NSManagedObject+Add.swift
//  CoreDataStackHelper
//
//  Created by DanielMandea on 1/14/18.
//

import Foundation
import CoreData


// MARK: - AddManagedObject

public protocol AddManagedObject: class {
  /**
   This method is called by all managedObjects in order to add / update
   - parameter data:      The data received for update
   - parameter context:   The context that should handle the fetch
   */
  static func add(data:Any, context:NSManagedObjectContext) -> Self?
  
  /**
   This method is called by all managedObjects in order to add / update multiple
   - parameter data:      The data received for update
   - parameter context:   The context that should handle the fetch
   */
  static func addMultiple(data:Array<Any>, context:NSManagedObjectContext)-> Array<Self>
}

// MARK: - AddManagedObject Implementation

public extension AddManagedObject where Self: UpdateManangedObject, Self: NSManagedObject {
  
  @available(iOS 10.0, *)
  static public func add(data:Any, context:NSManagedObjectContext) -> Self? {
    let obj = Self.init(context: context)
    obj.update(with: data)
    return obj
  }
  
  static public func addMultiple(data:Array<Any>, context:NSManagedObjectContext)-> Array<Self> {
    var objects = [Self]()
    for entry in data {
      if let object = self.add(data: entry, context: context) {
        objects.append(object)
      }
    }
    return objects
  }
}
