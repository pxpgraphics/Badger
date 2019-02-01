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
        try set(nil)
    }
    
    mutating func encode(_ value: Bool) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: Int) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: Int8) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: Int16) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: Int32) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: Int64) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: UInt) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: UInt8) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: UInt16) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: UInt32) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: UInt64) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: String) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: Float) throws {
        try set(box(value))
    }
    
    mutating func encode(_ value: Double) throws {
        try set(box(value))
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        try value.encode(to: encoder)
    }
}

// MARK: Setters

private extension SingleValueManagedObjectEncodingContainer {
    
    mutating func set(_ value: NSObject?) throws {
        guard let key = codingPath.last else {
            fatalError() // TODO: Throw key not found error.
        }
        try encoder.set(value, forKey: key)
    }
    
    func box<T>(_ value: T) throws -> NSObject {
        switch value {
        case let boolean as Bool:
            return NSNumber(value: boolean)
        case let integer16 as Int16:
            return integer16 as NSNumber
        case let integer32 as Int32:
            return integer32 as NSNumber
        case let integer64 as Int64:
            return integer64 as NSNumber
        case let unsignedInteger16 as UInt16:
            return unsignedInteger16 as NSNumber
        case let unsignedInteger32 as UInt32:
            return unsignedInteger32 as NSNumber
        case let unsignedInteger64 as UInt64:
            return unsignedInteger64 as NSNumber
        case let double as Double:
            return double as NSNumber
        case let float as Float:
            return float as NSNumber
        case let decimal as Decimal:
            return decimal as NSDecimalNumber
        case let string as String:
            return string as NSString
        case let date as Date:
            return date as NSDate
        case let data as Data:
            return data as NSData
        case let uuid as UUID:
            return uuid as NSUUID
        case let url as URL:
            return url as NSURL
        default:
            fatalError() // FIXME: Throw error.
        }
    }
}
