//
//  NSManagedObject+Fetch.swift
//  CoreDataStackHelper
//
//  Created by DanielMandea on 1/14/18.
//

import Foundation
import CoreData

// MARK: - Fetch

public protocol Fetch {
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
  
  @available(iOS 10.0, *)
  public static func count(with predicate: NSPredicate?, in context: NSManagedObjectContext) throws -> Int? {
    guard let request = Self.fetchRequest() as? NSFetchRequest<Self> else {
      return nil
    }
    request.predicate = predicate
    return try context.count(for: request)
  }
}
