//
//  NSManagedObject+Delete.swift
//  CoreDataStackHelper
//
//  Created by DanielMandea on 1/14/18.
//

import Foundation
import CoreData

// MARK: - AddManagedObject

public protocol Unique: class {
    // The cell data that should be set on the cell
    var uniqueID: String? {get set}
}

// MARK: - DeleteManagedObject

public protocol DeleteManagedObject: class {
    
    /**
     Use this method in order to delete some record with a certain uniqueID
     - parameter uniqueID:  The unique identifier of the object that should be saved
     - parameter context:   The context that should handle the fetch
     */
    static func delete(with uniqueID:String, context:NSManagedObjectContext) throws
    
    /**
     Use this method in order to delete some record with a certain uniqueID and save context
     - parameter uniqueID:    The unique identifier of the object that should be deleted
     - parameter context:     The context that should handle the fetch
     - parameter completion:  The block that will handle the fetch
     */
    static func deleteAndSave(with uniqueID:String, context:NSManagedObjectContext, completion:@escaping CompletionBlock) throws
    
    /**
     This method in order to delete multiple objects with certain unique IDs and save context
     - parameter uniqueIDs:   The unique identifiers of the objects that should be deleted
     - parameter context:     The context that should handle the fetch
     - parameter completion:  The block that will be called after the process was completed
     */
    static func deleteMultipleAndSave(with uniqueIDs:Array<String>, context:NSManagedObjectContext, completion:@escaping CompletionBlock) throws
}

// MARK: - AddManagedObject Implementation

public extension DeleteManagedObject where Self:Fetch, Self:Unique, Self: NSManagedObject {
    
    @available(iOS 10.0, *)
    static func delete(with uniqueID:String, context:NSManagedObjectContext) throws {
        let predicate = NSPredicate(format: "uniqueID = %@", uniqueID)
        if let object = try Self.fetch(with: predicate, in: context)?.first {
            context.delete(object)
        }
    }
    
    @available(iOS 10.0, *)
    static public func deleteAndSave(with uniqueID:String, context:NSManagedObjectContext, completion:@escaping CompletionBlock) throws  {
        try delete(with: uniqueID, context: context)
        context.save(completion: completion)
    }
    
    @available(iOS 10.0, *)
    static public func deleteMultipleAndSave(with uniqueIDs:Array<String>, context:NSManagedObjectContext, completion:@escaping CompletionBlock) throws {
        for uniqueID in uniqueIDs {
            try delete(with: uniqueID, context: context)
        }
        context.save(completion: completion)
    }
}
