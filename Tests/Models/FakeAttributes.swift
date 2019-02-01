//
//  FakeAttributes.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import Badger
import CoreData

// MARK: - FakeEnum

enum FakeEnum: String, Codable {
    
    case red, orange, yellow, green, blue, purple
}

// MARK: - FakeAttributes

struct FakeAttributes: Codable {
    
    let identifier: Identifier
    
    let boolean: Bool
    
    let data: Data
    
    let date: Date
    
    let decimal: Decimal
    
    let double: Double
    
    let float: Float
    
    let int16: Int16
    
    let int32: Int32
    
    let int64: Int64
    
    let string: String
    
    let uri: URL
    
    let uuid: UUID
    
    let `enum`: FakeEnum
    
    let optional: String?
    
    // MARK: Querying
    
    static func findOrCreate(_ identifier: FakeAttributes.Identifier, in context: NSManagedObjectContext) throws -> FakeAttributesManagedObject {
        return try context.findOrCreate(identifier: identifier.rawValue as NSString, forPrimaryKey: "identifier", entityName: "FakeAttributes")
    }
}

// MARK: ManagedObjectCodable

extension FakeAttributes: ManagedObjectCodable {
    
    static var identifierCodingKey: CodingKey {
        return CodingKeys.identifier
    }
    
    var managedObjectIdentifier: ManagedObjectIdentifier {
        return identifier
    }
}

// MARK: - Identifier

extension FakeAttributes {
    
    struct Identifier: Codable, RawRepresentable {
        
        var rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

// MARK: Equatable

extension FakeAttributes.Identifier: Equatable {

    static func == (lhs: FakeAttributes.Identifier, rhs: FakeAttributes.Identifier) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

// MARK: ManagedObjectIdentifier

extension FakeAttributes.Identifier: ManagedObjectIdentifier {

    init?(managedObject: NSManagedObject) {
        guard let managedObject = managedObject as? FakeAttributesManagedObject else {
            return nil
        }

        self.rawValue = managedObject.identifier
    }

    func findOrCreate(in context: NSManagedObjectContext) throws -> NSManagedObject {
        return try FakeAttributes.findOrCreate(self, in: context)
    }
}

// MARK: - FakeAttributesManagedObject

final class FakeAttributesManagedObject: NSManagedObject {
    
    @NSManaged var identifier: String
    
    @NSManaged var boolean: Bool
    
    @NSManaged var data: Data
    
    @NSManaged var date: Date
    
    @NSManaged var decimal: NSDecimalNumber // Note: Decimal maps to a scalar type and cannot be dynamically set within Core Data.
    
    @NSManaged var double: Double
    
    @NSManaged var float: Float
    
    @NSManaged var int16: Int16
    
    @NSManaged var int32: Int32
    
    @NSManaged var int64: Int64
    
    @NSManaged var string: String
    
    @NSManaged var uri: URL // Note: URI maps to a string type and cannot be dynamically set within Core Data.
    
    @NSManaged var uuid: UUID // Note: UUID maps to a string type and cannot be dynamically set within Core Data.
    
    @NSManaged var `enum`: String // Note: Swift enumerations map to a variety of type representations and cannot be dynamically set within Core Data.
    
    @NSManaged var optional: String?
}
