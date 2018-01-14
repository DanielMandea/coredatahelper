//
//  NSManagedObject+Update.swift
//  CoreDataStackHelper
//
//  Created by DanielMandea on 1/14/18.
//

import Foundation
import CoreData

// MARK: - UpdateManangedObject

/// Use ethis protocol in order to automaticly update some managed object
public protocol UpdateManangedObject: class {
  /// Use this method in order to update a NSManagedObject
  func update(with data:Any)
}

/// Use this protocol when a create / update is needed -> should be implemented by yourself
public protocol CreateOrUpdateManagedObject: class {
  
  /**
   This method is called by all managedObjects in order to create / update -> should be implemented by yourself
   - parameter data:      The data received for update
   - parameter context:   The context that should handle the fetch
   */
  @discardableResult static func createOrUpdate(with data: Any, context:NSManagedObjectContext) -> Self?
  
  /**
   This method is called by all managedObjects in order to create / update -> should be implemented by yourself
   - parameter data:      The data received for update
   - parameter context:   The context that should handle the fetch
   */
  @discardableResult static func createOrUpdateMultiple(with data:Array<Any>, context:NSManagedObjectContext)-> Array<Self>?
}
