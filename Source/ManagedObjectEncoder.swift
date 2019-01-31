//
//  ManagedObjectEncoder.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import CoreData
import Foundation

// MARK: - ManagedObjectEncoder

/// An encoder type which transforms data into managed objects.
public struct ManagedObjectEncoder {
    
    /// The managed object context with which the encoded managed object(s) is registered.
    public let managedObjectContext: NSManagedObjectContext
    
    /// Any contextual information set by the user for encoding.
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    
    /// Initializes a managed object encoder with a specified managed object context to perform data operations.
    public init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }

    // MARK: Encoding
    
    /// Encodes the given managed object codable type into a managed object.
    /// - Note: The managed object will be registered to the managed object context owned by the encoder.
    func encode<Encodable: ManagedObjectCodable>(_ encodable: Encodable) throws -> NSManagedObject {
        return try _encode(encodable, codingPath: [])
    }
    
    /// Encodes the given managed object codable type into a managed object, based on the specified coding path.
    /// - Note: If successfully encoded, the managed object will be registered to the managed object context owned by the encoder.
    private func _encode<Encodable: ManagedObjectCodable>(_ encodable: Encodable, codingPath: [CodingKey]) throws -> NSManagedObject {
        let managedObject = try encodable.managedObjectIdentifier.findOrCreate(in: managedObjectContext)
        let encoder = Encoder(context: managedObjectContext,
                              managedObject: managedObject,
                              encodable: encodable,
                              codingPath: codingPath,
                              userInfo: userInfo)
        try encodable.encode(to: encoder)
        return managedObject
    }
}

// MARK: - Encoder

extension ManagedObjectEncoder {
    
    final class Encoder: Swift.Encoder {
        
        /// The managed object context used to encode managed objects.
        let managedObjectContext: NSManagedObjectContext
        
        /// The managed object being encoded.
        let managedObject: NSManagedObject
        
        /// The path of coding keys taken to get to this point in encoding.
        var codingPath: [CodingKey]
        
        /// Any contextual information set by the user for encoding.
        let userInfo: [CodingUserInfoKey : Any]
        
        /// The managed object codable type being encoded.
        let encodable: ManagedObjectCodable
        
        /// Creates an instance of an encoder used to encode managed objects.
        init(context: NSManagedObjectContext,
             managedObject: NSManagedObject,
             encodable: ManagedObjectCodable,
             codingPath: [CodingKey],
             userInfo: [CodingUserInfoKey: Any]) {
            
            self.managedObjectContext   = context
            self.managedObject          = managedObject
            self.encodable              = encodable
            self.codingPath             = codingPath
            self.userInfo               = userInfo
        }
        
        func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
            let container = KeyedManagedObjectEncodingContainer<Key>(encoder: self)
            return KeyedEncodingContainer<Key>(container)
        }
        
        func unkeyedContainer() -> UnkeyedEncodingContainer {
            return UnkeyedManagedObjectEncodingContainer(encoder: self)
        }
        
        func singleValueContainer() -> SingleValueEncodingContainer {
            return SingleValueManagedObjectEncodingContainer(encoder: self)
        }
    }
}
