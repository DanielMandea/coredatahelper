//
//  LocalPersistance.swift
//  CoreDataStackHelper_Example
//
//  Created by DanielMandea on 2/23/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CoreData
import CoreDataStackHelper

class LocalPersistance: Persistence {
    
    static func setup() {
        // Setup Core Data Stack
        store.persistentContainerName = "Model"
    }
}
