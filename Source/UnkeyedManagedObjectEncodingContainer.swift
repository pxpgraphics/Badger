//
//  UnkeyedManagedObjectEncodingContainer.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import CoreData
import Foundation

// MARK: - UnkeyedManagedObjectEncodingContainer

/// A type that provides a view into an encoder's storage and is used to hold
/// the encoded properties of an encodable type sequentially, without keys.
struct UnkeyedManagedObjectEncodingContainer: UnkeyedEncodingContainer {
    
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
    
    /// The number of elements encoded into the container.
    var count: Int {
        return 0 // FIXME: Return the number of managed objects, if applicable, at the last coding key
    }
    
    /// Creates an instance of an unkeyed managed object encoding container with the specified encoder.
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
        // TODO: Do nothing (default) or throw error (strict mode)
    }
    
    mutating func encode(_ value: Bool) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: Int) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: Int8) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: Int16) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: Int32) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: Int64) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: UInt) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: UInt8) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: UInt16) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: UInt32) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: UInt64) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: String) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: Float) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode(_ value: Double) throws {
        // TODO: Throw invalid type error.
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        // TODO: Encode value if managed object identifiable, else throw invalid type error.
    }
}
