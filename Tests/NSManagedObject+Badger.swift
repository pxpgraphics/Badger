//
//  NSManagedObject+Badger.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import CoreData

// MARK: - NSManagedObjectContext

extension NSManagedObjectContext {
    
    func findOrCreate<T: NSManagedObject>(identifier: NSObject, property: String, entityName: String) throws -> T {
        
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "%K == %@", property, identifier)
        fetchRequest.fetchLimit = 1
        fetchRequest.includesSubentities = true
        fetchRequest.returnsObjectsAsFaults = false
        
        if let existingManagedObject = try fetch(fetchRequest).first {
            return existingManagedObject
        } else {
            let newManagedObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: self) as! T
            newManagedObject.setValue(identifier, forKey: property)
            return newManagedObject
        }
    }
}
