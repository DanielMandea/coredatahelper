//
//  NSManagedObject+Save.swift
//  CoreDataStackHelper
//
//  Created by DanielMandea on 1/14/18.
//

import Foundation
import CoreData


// MARK: - SaveManagedObject

public protocol SaveOrUpdateManagedObject: class {
  /**
   This method is called by all managedObjects in order to save single
   - parameter data:          The data received for saving
   - parameter context:       The context that should handle the fetch
   - parameter completion:    The block that is called after the process completed
   */
  static func saveOrUpdateSingle(with data:Any, context: NSManagedObjectContext, completion:@escaping CompletionBlock)
  
  /**
   This method is called by all managedObjects in order to save multiple
   - parameter data:          The data received for saving
   - parameter context:       The context that should handle the fetch
   - parameter completion:    The block that is called after the process completed
   */
  static func saveOrUpdateMultiple(with data:Array<Any>, context:NSManagedObjectContext, completion:@escaping CompletionBlock)
}

// MARK: - SaveManagedObject Implementation

public extension SaveManagedObject where Self: CreateOrUpdateManagedObject {
  
  static public func saveOrUpdateSingle(with data:Any, context:NSManagedObjectContext, completion:@escaping CompletionBlock) {
    createOrUpdate(with: data, context: context)
    context.save(completion: completion)
  }
  
  static public func saveOrUpdateMultiple(with data:Array<Any>, context:NSManagedObjectContext, completion:@escaping CompletionBlock) {
    createOrUpdateMultiple(with: data, context: context)
    context.save(completion: completion)
  }
}
