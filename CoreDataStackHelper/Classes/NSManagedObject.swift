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
public protocol UpdateManangedObject: class {
    /// Use this method in order to update a NSManagedObject
    func update(with data:Any)
}

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

// MARK: - Fetch

public protocol Fetch {
    /**
     Use this method i order to fetch some context based on some predicate
     - parameter predicate: The predicte that is used for fetch
     - parameter context:   The context that will handle the fetch
     - return: An instance of NSArray containing Self or nil
     */
    static func fetch(with predicate: NSPredicate?, in context: NSManagedObjectContext) throws -> Array<Self>?
}

// MARK: - Fetch Implementation

public extension Fetch where Self:NSManagedObject {
    
    @available(iOS 10.0, *)
    public static func fetch(with predicate: NSPredicate?, in context: NSManagedObjectContext) throws -> Array<Self>? {
        guard let request = Self.fetchRequest() as? NSFetchRequest<Self> else {
            return nil
        }
        request.predicate = predicate
        return try context.fetch(request)
    }
}
