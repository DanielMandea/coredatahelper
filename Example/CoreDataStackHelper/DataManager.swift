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
    ["name":"ion 1", "uniqueID":"4", "age":21],
    ["name":"jan 2", "uniqueID":"5", "age":21],
    ["name":"ghita 3", "uniqueID":"6", "age":21]
  ]
  
  var allUsers: Array<User>
  
  override init() {
    savingContext = CoreDataManger.sharedInstance.savingContext
    viewContext = CoreDataManger.sharedInstance.persistentContainer.viewContext
    allUsers = [User]()
    super.init()
  }
  
  /**
   Use this method in oreder to fetch users
   */
  func fetch(with completion: @escaping CompletionBlock) {
    // Save some users
    User.saveMultiple(data: users, context: savingContext) { (success, error) in
      // Load entries after completion
      DispatchQueue.main.async {
        do {
          if let data = try User.fetch(with: nil, in: self.viewContext) {
             self.allUsers = data
          }
        } catch {
          
        }
        completion(success, error)
      }
    }
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
