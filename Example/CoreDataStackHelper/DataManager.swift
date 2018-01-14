//
//  DataManager.swift
//  CoreDataHelper
//
//  Created by DanielMandea on 3/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import CoreData
import CoreDataStackHelper

class DataManager: NSObject {
  
  var savingContext: NSManagedObjectContext
  var viewContext: NSManagedObjectContext
  
  let users = [
    ["name":"ghita 1", "uniqueID":"4", "age":21],
    ["name":"ghita 2", "uniqueID":"5", "age":22],
    ["name":"ghita 3", "uniqueID":"6", "age":23],
    ["name":"ghita 4", "uniqueID":"7", "age":24],
    ["name":"ghita 5", "uniqueID":"8", "age":25],
    ["name":"ghita 6", "uniqueID":"10", "age":26]
    
  ]
  
  var allUsers: Array<User>
  
  override init() {
    savingContext = Persistence.store.savingContext
    viewContext = Persistence.store.persistentContainer.viewContext
    allUsers = [User]()
    super.init()
  }
  
  /**
   Use this method in oreder to fetch users
   */
  func fetch(with completion: @escaping CompletionBlock) {
    // Save some users
    let context =  Persistence.store.persistentContainer.viewContext
    User.saveOrUpdateMultiple(with: self.users, context: context, completion: { (success, error) in
        DispatchQueue.main.async {
            do {
                if let data = try User.fetch(with: nil, in: self.viewContext) {
                    self.allUsers = data
                }
            } catch {
                
            }
            completion(success, error)
        }
    })
  }
  
  /**
   Use this method in oreder to configure a cell
   */
  func configureCell(cell: UserTableViewCell, for indexPath: IndexPath) {
    let user = allUsers[indexPath.row]
    cell.userAge = user.age
    cell.userName = user.name
  }
}
