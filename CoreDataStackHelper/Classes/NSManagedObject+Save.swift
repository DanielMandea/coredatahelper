//
//  NSManagedObject.swift
//  Pods
//
//  Created by DanielMandea on 3/14/17.
//
//

import Foundation
import CoreData

public typealias CompletionBlock = (_ success:Bool, _ error: Error?) -> Void

// MARK: - SaveManagedObject

public protocol SaveManagedObject: class {
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
}

// MARK: - SaveManagedObject Implementation

public extension SaveManagedObject where Self: AddManagedObject {
  
  static public func saveSingle(data:Any, context:NSManagedObjectContext, completion:@escaping CompletionBlock) {
    context.perform {
      _ = self.add(data: data, context: context)
      context.save(completion: completion)
    }
  }
  
  static public func saveMultiple(data:Array<Any>, context:NSManagedObjectContext, completion:@escaping CompletionBlock) {
    context.perform {
      _ = self.addMultiple(data: data, context: context)
      // Save the context
      context.save(completion: completion)
    }
  }
}
