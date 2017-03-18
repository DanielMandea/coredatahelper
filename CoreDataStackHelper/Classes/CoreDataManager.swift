//
//  CoreDataManager.swift
//  Pods
//
//  Created by DanielMandea on 3/14/17.
//
//

import Foundation
import CoreData

/**
 Use this protocol in order to manage light weight core data stack
 */
public protocol SetupCoreData: class {
  /// Holds persistent coordinator continer name !!!!!
  var persistentContainerName: String! {get set}
  
  /// Holds a refference to the a saving context (bg context)
  var savingContext: NSManagedObjectContext { get set }
  
  /// Holds the persistent coordinator
  @available(iOS 10.0, *)
  var persistentContainer: NSPersistentContainer { get set }
}


@available(iOS 10.0, *)
private let sharedManager = CoreDataManger()

/**
 This is a singletone that enhances work with core data stack 
 */
@available(iOS 10.0, *)
public class CoreDataManger: NSObject, SetupCoreData {

  
  // MARK: - Singletone
  
  public class var sharedInstance: CoreDataManger {
    return sharedManager
  }
  
  // MARK: - Initialization
  
  override init() {
    super.init()
    persistentContainerName = "Model"
  }
  
  // MARK: - Internal variables 
  
   public var persistentContainerName: String!
  
  // MARK: - SetupCoreData
  
  lazy public var savingContext: NSManagedObjectContext = {
    let context = self.persistentContainer.newBackgroundContext()
    context.automaticallyMergesChangesFromParent = true
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return context
  }()
  
  @available(iOS 10.0, *)
  lazy public var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: self.persistentContainerName)
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error)")
      }
    })
    return container
  }()
}


