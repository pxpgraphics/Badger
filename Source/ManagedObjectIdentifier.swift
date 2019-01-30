//
//  ManagedObjectIdentifier.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import CoreData
import Foundation

// MARK: - ManagedObjectIdentifier

/// A codable type which can identify, or be identified by, a managed object.
public protocol ManagedObjectIdentifier: Codable {
    
    /// Returns an instance of the identifier from the given managed object, if registered; otherwise returns nil.
    init?(managedObject: NSManagedObject)
    
    /// Returns an instance of the uniquely identified managed object registered within the given managed object context.
    func findOrCreate(in context: NSManagedObjectContext) throws -> NSManagedObject
}

// MARK: - Sequence

public extension Sequence where Iterator.Element: ManagedObjectIdentifier {
    
    /// Returns a sequence of the uniquely identified managed objects registered within the given managed object context.
    @inline(__always)
    func findOrCreate(in context: NSManagedObjectContext) throws -> [NSManagedObject] {
        return try map { try $0.findOrCreate(in: context) }
    }
}
