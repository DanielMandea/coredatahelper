//
//  CoreDataManager.swift
//  Pods
//
//  Created by DanielMandea on 3/14/17.
//
//

import Foundation
import CoreData

@available(iOS 10.0, *)
public typealias LoadPersistentStoreCompletion = (NSPersistentStoreDescription, Error?) -> Swift.Void

/**
 Use this protocol in order to manage light weight core data stack
 */
public protocol PersistentStore: class {
  /// Holds persistent coordinator continer name !!!!!
  var persistentContainerName: String! {get set}
  
  /// Holds the configuration for the persistent store
  @available(iOS 10.0, *)
  var persistentStoreDescriptions: Array<NSPersistentStoreDescription>? {get set}
  
  /// Holds a refference to the a saving context (bg context)
  var savingContext: NSManagedObjectContext { get }
  
  // Holds a refference to the main context (bg context)
  var mainContext: NSManagedObjectContext { get }
  
  /// Holds the persistent coordinator
  @available(iOS 10.0, *)
  var persistentContainer: NSPersistentContainer { get set }
}

public let kDefatultContainerName = "Model"

/**
 This is a singletone that enhances work with core data stack
 */

@available(iOS 10.0, *)
private let sharedManager = Persistence()

@available(iOS 10.0, *)
open class Persistence: PersistentStore {
  
  // MARK: - Singletone
  
  open class var store: Persistence {
    return sharedManager
  }
  
  // MARK: - Initialization
  
  init() {
    persistentContainerName = kDefatultContainerName
  }
  
  // MARK: - PersistentStore
  
  open var persistentContainerName: String!
  open var persistentStoreDescriptions: Array<NSPersistentStoreDescription>?
  
  open var savingContext: NSManagedObjectContext {
    get {
      let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
      context.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
      context.automaticallyMergesChangesFromParent = true
      context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      return context
    }
  }
  
  open var mainContext: NSManagedObjectContext {
    get {
      let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
      context.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
      context.automaticallyMergesChangesFromParent = true
      context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      return context
    }
  }
  
  /**
   The persistent container for the application. This implementation
   creates and returns a container, having loaded the store for the
   application to it. This property is optional since there are legitimate
   error conditions that could cause the creation of the store to fail.
   */
  @available(iOS 10.0, *)
  lazy public var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: persistentContainerName)
    if let descriptions = persistentStoreDescriptions {
      container.persistentStoreDescriptions = descriptions
    }
    container.loadPersistentStores(completionHandler: { (description, error) in
      if let error = error {
        print(error)
      }
    })
    return container
  }()
}
