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
  var persistentStoreDescriptions: Array<NSPersistentStoreDescription>! {get set}
  
  /// Holds a refference to the a saving context (bg context)
  var savingContext: NSManagedObjectContext { get }
  
  // Holds a refference to the main context (bg context)
  var mainContext: NSManagedObjectContext { get }
  
  /// Holds the persistent coordinator
  @available(iOS 10.0, *)
  var persistentContainer: NSPersistentContainer { get set }
  
  @available(iOS 10.0, *)
  func setup(with name: String,
             descriptions:Array<NSPersistentStoreDescription>?,
             comletion block:@escaping LoadPersistentStoreCompletion)
}

public let kDefatultContainerName = "Model"

/**
 This is a singletone that enhances work with core data stack
 */

@available(iOS 10.0, *)
private let sharedManager = Persistence()

@available(iOS 10.0, *)
public class Persistence: PersistentStore {
  
  // MARK: - Singletone
  
  public class var store: Persistence {
    return sharedManager
  }
  
  // MARK: - Initialization
  
  init() {
    persistentContainerName = kDefatultContainerName
    let description = NSPersistentStoreDescription()
    description.type = NSSQLiteStoreType
    persistentStoreDescriptions = [description]
  }
  
  // MARK: - PersistentStore
  
  public var persistentContainerName: String!
  public var persistentStoreDescriptions: Array<NSPersistentStoreDescription>!
  
  public var savingContext: NSManagedObjectContext {
    get {
      let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
      context.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
      context.automaticallyMergesChangesFromParent = true
      context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      return context
    }
  }
  
  public var mainContext: NSManagedObjectContext {
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
    container.persistentStoreDescriptions = persistentStoreDescriptions
    return container
  }()
  
  /**
   Use this method in order to load the persistent store
   - parameter name:          The name of the container
   - parameter descriptions:  The descriptions related to NSPersistentStoreDescription
   - parameter block:         The block that is called after completing the process
   */
  @available(iOS 10.0, *)
  public func setup(with name: String = kDefatultContainerName,
                    descriptions:Array<NSPersistentStoreDescription>?,
                    comletion block:@escaping LoadPersistentStoreCompletion) {
    persistentContainerName = name
    if descriptions != nil {
      persistentStoreDescriptions = descriptions
    }
    persistentContainer.loadPersistentStores(completionHandler: block)
  }
}

