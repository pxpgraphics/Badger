//
//  KeyedManagedObjectEncodingContainer.swift
//  Badger-iOS
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import CoreData
import Foundation

// MARK: - KeyedManagedObjectEncodingContainer

/// A type that provides a view into an encoder's storage and is used to hold
/// the encoded properties of an encodable type in a keyed manner.
struct KeyedManagedObjectEncodingContainer<K: CodingKey>: KeyedEncodingContainerProtocol {
    
    typealias Key = K
    
    /// The encoder transforming data from this container.
    private let encoder: ManagedObjectEncoder.Encoder
    
    /// The container which holds the data being encoded.
    private var container: NSManagedObject {
        return encoder.managedObject
    }
    
    /// The path of coding keys taken to get to this point in encoding.
    private(set) var codingPath: [CodingKey] {
        get { return encoder.codingPath }
        mutating set { encoder.codingPath = newValue }
    }
    
    /// Creates an instance of a keyed managed object encoding container with the specified encoder.
    init(encoder: ManagedObjectEncoder.Encoder) {
        self.encoder = encoder
    }
    
    // MARK: Nested Containers
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: K) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        fatalError()
    }
    
    mutating func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer {
        fatalError()
    }
    
    // MARK: Super Encoding
    
    mutating func superEncoder() -> Encoder {
        fatalError()
    }
    
    mutating func superEncoder(forKey key: Key) -> Encoder {
        fatalError()
    }
    
    // MARK: Encoding
    
    mutating func encodeNil(forKey key: Key) throws {
        // TODO: Encode nil for key.
    }
    
    mutating func encode(_ value: Bool, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int8, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int16, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int32, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Int64, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: String, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Float, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Double, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Data, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Date, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: Decimal, forKey key: Key) throws {
        // TODO: Encode boxed value for key.
    }
    
    mutating func encode(_ value: URL, forKey key: Key) throws {
        // TODO: Encode boxed value for key, based on attribute type (URI or String), otherwise throw invalid type error.
    }
    
    mutating func encode(_ value: UUID, forKey key: Key) throws {
        // TODO: Encode boxed value for key, based on attribute type (UUID or String), otherwise throw invalid type error.
    }
    
    mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        // TODO: Manually encode value, of each supported type, for key.
    }
}
