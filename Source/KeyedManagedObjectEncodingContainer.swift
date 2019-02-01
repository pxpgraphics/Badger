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
        try set(nil, forKey: key)
    }
    
    mutating func encode(_ value: Bool, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: Int, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: Int8, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: Int16, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: Int32, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: Int64, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: UInt, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: String, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: Float, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode(_ value: Double, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        // TODO: Manually encode value and/or relationship, of each supported type, for key.
        switch value {
        case let data as Data:
            try _encodeData(data, forKey: key)
        case let date as Date:
            try _encodeDate(date, forKey: key)
        case let decimal as Decimal:
            try _encodeDecimal(decimal, forKey: key)
        case let uuid as UUID:
            try _encodeUUID(uuid, forKey: key)
        case let url as URL:
            try _encodeURL(url, forKey: key)
        default:
            try _encodeValue(value, forKey: key)
        }
    }
    
    private mutating func _encodeData(_ value: Data, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    private mutating func _encodeDate(_ value: Date, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    private mutating func _encodeDecimal(_ value: Decimal, forKey key: Key) throws {
        try set(box(value), forKey: key)
    }
    
    private mutating func _encodeURL(_ value: URL, forKey key: Key) throws {
        guard let attribute = container.entity.attributesByName[key.stringValue] else {
            fatalError() // TODO: Throw error.
        }
        
        switch attribute.attributeType {
        case .URIAttributeType, .stringAttributeType:
            try set(box(value), forKey: key)
        default:
            fatalError() // TODO: Throw invalid type error.
        }
    }
    
    private mutating func _encodeUUID(_ value: UUID, forKey key: Key) throws {
        guard let attribute = container.entity.attributesByName[key.stringValue] else {
            fatalError() // TODO: Throw error.
        }
        
        switch attribute.attributeType {
        case .UUIDAttributeType, .stringAttributeType:
            try set(box(value), forKey: key)
        default:
            fatalError() // TODO: Throw invalid type error.
        }
    }
    
    private mutating func _encodeValue<T: Encodable>(_ value: T, forKey key: Key) throws {
        _willChangeValue(forKey: key)
        try value.encode(to: encoder)
        _didChangeValue(forKey: key)
    }
}

// MARK: Setters

private extension KeyedManagedObjectEncodingContainer {
    
    mutating func set(_ value: NSObject?, forKey key: Key) throws {
        _willChangeValue(forKey: key)
        try encoder.set(value, forKey: key)
        _didChangeValue(forKey: key)
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
    
    private mutating func _willChangeValue(forKey key: Key) {
        codingPath.append(key) // add key to the container's key path.
    }
    
    private mutating func _didChangeValue(forKey key: Key) {
        codingPath.removeLast() // remove key from the container's key path
    }
}
