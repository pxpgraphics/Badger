//
//  SingleValueManagedObjectEncodingContainer.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import CoreData
import Foundation

// MARK: - SingleValueManagedObjectEncodingContainer

/// A container that can support the storage and direct encoding of a single
/// non-keyed value.
struct SingleValueManagedObjectEncodingContainer: SingleValueEncodingContainer {
    
    /// The encoder transforming data from the container.
    private let encoder: ManagedObjectEncoder.Encoder
    
    /// The container which contains the data being encoded.
    private var container: NSManagedObject {
        return encoder.managedObject
    }
    
    /// The path of coding keys taken to get to this point in encoding.
    var codingPath: [CodingKey] {
        get { return encoder.codingPath }
    }
    
    /// Creates an instance of an single value managed object encoding container with the specified encoder.
    init(encoder: ManagedObjectEncoder.Encoder) {
        self.encoder = encoder
    }
    
    // MARK: Nested Containers
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        fatalError()
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError()
    }
    
    // MARK: Super Encoders
    
    mutating func superEncoder() -> Encoder {
        return encoder
    }
    
    // MARK: Encoding
    
    mutating func encodeNil() throws {
        // TODO: Encode nil for key.
    }
    
    mutating func encode(_ value: Bool) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int8) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int16) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int32) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int64) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt8) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt16) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt32) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt64) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: String) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Float) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Double) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        // TODO: Encode value for key.
    }
}
