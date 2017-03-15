//
//  NSManagedObject.swift
//  Pods
//
//  Created by DanielMandea on 3/14/17.
//
//

import Foundation
import CoreData
import CloudKit

public typealias CompletionBlock = (_ success:Bool, _ error: Error?) -> Void

// MARK: - UpdateManangedObject

/// Us ethis protocol when using Dictionary / JSON
protocol UpdateManangedObject: class {
  /// Use this method in order to update a NSManagedObject
  func update(data:Dictionary<String, Any>)
}

// MARK: - UpdateManangedObject Implementation

extension UpdateManangedObject where Self: NSManagedObject {
  
  /**
   This method is called by all managedObjects in order to save multiple using MR_rootSavingContext
   - parameter data:          The data received for saving
   - parameter completion:    The block that is called after the process completed
   */
  @available(iOS 10.0, *)
  func saveMultiple(data:Array<Dictionary<String, Any>>,completion:@escaping CompletionBlock) {
    self.saveMultiple(data: data, context: CoreDataManger.sharedInstance.savingContext, completion: completion)
  }
  
  /**
   This method is called by all managedObjects in order to save multiple
   - parameter data:          The data received for saving
   - parameter context:       The context that should handle the fetch
   - parameter completion:    The block that is called after the process completed
   */
  @available(iOS 10.0, *)
  func saveMultiple(data:Array<Dictionary<String, Any>>, context:NSManagedObjectContext, completion:@escaping CompletionBlock) {
    context.perform {
      _ = self.addMultiple(data: data, context: context)
      // Save the context
      context.save(completion: completion)
    }
  }
  
  /**
   This method is called by all managedObjects in order to save singe using MR_rootSavingContext
   - parameter data:          The data received for saving
   - parameter completion:    The block that is called after the process completed
   */
  @available(iOS 10.0, *)
  func saveSinge(data:Dictionary<String, Any>, completion:@escaping CompletionBlock) {
    self.saveSinge(data: data, context: CoreDataManger.sharedInstance.savingContext, completion: completion)
  }
  
  /**
   This method is called by all managedObjects in order to save singe
   - parameter data:          The data received for saving
   - parameter context:       The context that should handle the fetch
   - parameter completion:    The block that is called after the process completed
   */
  @available(iOS 10.0, *)
  func saveSinge(data:Dictionary<String, Any>, context:NSManagedObjectContext, completion:@escaping CompletionBlock) {
    context.perform {
      _ = self.add(data: data, context: context)
      context.save(completion: completion)
    }
  }
  
  /**
   This method is called by all managedObjects in order to add / update multiple
   - parameter data:      The data received for update
   - parameter context:   The context that should handle the fetch
   */
  @available(iOS 10.0, *)
  func addMultiple(data:Array<Dictionary<String, Any>>, context:NSManagedObjectContext)-> Array<NSManagedObject> {
    var managedObjects = [NSManagedObject]()
    for entry in data {
      if let managedObject = self.add(data: entry, context: context) {
        managedObjects.append(managedObject)
      }
    }
    return managedObjects
  }
  
  /**
   This method is called by all managedObjects in order to add / update
   - parameter data:      The data received for update
   - parameter context:   The context that should handle the fetch
   */
  @available(iOS 10.0, *)
  func add(data:Dictionary<String, Any>, context:NSManagedObjectContext) -> Self? {
    let managedObject = Self.init(context: context)
    managedObject.update(data: data)
    return managedObject
  }
}


// MARK: - CKUpdateProtocol

/// Use this protocol when working with Cloud Kit
protocol CKUpdateProtocol: class {
  /// Use this method in order to update a NSManagedObject
  func ckUpdate(data: CKRecord)
}

// MARK: - CKUpdateProtocol Implementation

extension CKUpdateProtocol where Self:NSManagedObject {
  
  @available(iOS 10.0, *)
  func ckAdd(data:CKRecord, context:NSManagedObjectContext) -> Self? {
    let managedObject = Self.init(context: context)
    managedObject.ckUpdate(data: data)
    return managedObject
  }
  
  @available(iOS 10.0, *)
  func ckAddMultiple(data:Array<CKRecord>, context:NSManagedObjectContext)-> Array<NSManagedObject> {
    var managedObjects = [NSManagedObject]()
    for entry in data {
      if let managedObject = self.ckAdd(data: entry, context: context) {
        managedObjects.append(managedObject)
      }
    }
    return managedObjects
  }
  
  // Add a new instance of managed object
  @available(iOS 10.0, *)
  func ckSaveSinge(data:CKRecord, context:NSManagedObjectContext, completion:@escaping CompletionBlock) {
    context.perform {
      _ = self.ckAdd(data: data, context: context)
      context.save(completion: completion)
    }
  }
  
  @available(iOS 10.0, *)
  func ckSaveMultiple(data:Array<CKRecord>, context:NSManagedObjectContext, completion:@escaping CompletionBlock) {
    context.perform {
      _ = self.ckAddMultiple(data: data, context: context)
      // Save the context
      context.save(completion: completion)
    }
  }
  
}

// MARK: - Fetch

protocol Fetch {
  /**
   Use this method i order to fetch some context based on some predicate 
   - parameter predicate: The predicte that is used for fetch 
   - parameter context:   The context that will handle the fetch 
   - return: An instance of NSArray containing Self or nil 
   */
  func fetch(with predicate: NSPredicate?, in context: NSManagedObjectContext) throws -> Array<Self>
}

// MARK: - Fetch Implementation

extension Fetch where Self:NSManagedObject {
  @available(iOS 10.0, *)
  func fetch(with predicate: NSPredicate?, in context: NSManagedObjectContext) throws -> Array<Self>? {
    guard let request = Self.fetchRequest() as? NSFetchRequest<Self> else {
      return nil
    }
    request.predicate = predicate
    return try context.fetch(request)
  }
}
