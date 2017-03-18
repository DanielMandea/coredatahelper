//
//  User+CoreDataProperties.swift
//  CoreDataHelper
//
//  Created by DanielMandea on 3/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var name: String?
    @NSManaged public var uniqueID: String?
    @NSManaged public var age: NSNumber?

}
