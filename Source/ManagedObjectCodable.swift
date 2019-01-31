//
//  ManagedObjectCodable.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import CoreData
import Foundation

// MARK: - ManagedObjectCodable

/// A codable type, backed by a managed object, which can be uniquely identified.
public protocol ManagedObjectCodable: Codable {
    
    /// The coding key representing the identifier of this type.
    static var identifierCodingKey: CodingKey { get }
    
    /// The managed object identifier of this type.
    var managedObjectIdentifier: ManagedObjectIdentifier { get }
}

// MARK: Encoding

extension ManagedObjectCodable {
    
    /// Encodes the codable type into a managed object within the given managed object context.
    func encode(in context: NSManagedObjectContext) throws -> NSManagedObject {
        let encoder = ManagedObjectEncoder(context: context)
        let managedObject = try encoder.encode(self)
        return managedObject
    }
}

// MARK: - Collection

public extension Collection where Iterator.Element: ManagedObjectCodable {
    
    /// Save a collection of codable types into a managed objects within the given managed object context.
    func save(in context: NSManagedObjectContext) throws -> [NSManagedObject] {
        var managedObjects = ContiguousArray<NSManagedObject>()
        managedObjects.reserveCapacity(count)
        
        try forEach { element in
            let managedObject = try element.encode(in: context)
            managedObjects.append(managedObject)
        }
        
        return Array(managedObjects)
    }
}
