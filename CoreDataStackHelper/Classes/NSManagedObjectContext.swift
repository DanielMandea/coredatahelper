//
//  NSManagedObjectContext.swift
//  Pods
//
//  Created by DanielMandea on 3/14/17.
//
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    /**
     Use this function in order to save some context
     */
    func save(completion: @escaping CompletionBlock) {
        if self.hasChanges {
            do {
                try self.save()
                completion(true, nil)
            } catch let error {
                completion(false, error)
            }
        }
    }
    
}
