//
//  ManagedObjectEncoderTestCase.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import Badger
import XCTest

// MARK: - ManagedObjectEncoderTestCase

final class ManagedObjectEncoderTestCase: BaseTestCase {
    
    func testEncoderTransformsManagedObjectCodableTypeIntoManagedObject() {
    
        XCTAssertNoThrow(try setUpManagedObjectContext { context in
            
            // Given:
            
            let identifier = FakeAttributes.Identifier(rawValue: UUID().uuidString)
            let value = FakeAttributes(identifier: identifier,
                                       boolean: true,
                                       data: Data(bytes: [0x01, 0x02, 0x03]),
                                       date: Date(),
                                       decimal: 100.555555,
                                       double: 1.66666,
                                       float: 1.5555,
                                       int16: 16,
                                       int32: 32,
                                       int64: 64,
                                       string: "pxpgraphics",
                                       uri: URL(string: "https://www.pxpgraphics.com/blog")!,
                                       uuid: UUID(),
                                       enum: .red,
                                       optional: nil)

            // When:
            
            let encoder = ManagedObjectEncoder(context: context)
            let managedObject = try encoder.encode(value) as! FakeAttributesManagedObject
            
            // Then:
            
            XCTAssert(managedObject.identifier == value.identifier.rawValue)
            XCTAssert(managedObject.boolean == value.boolean)
            XCTAssert(managedObject.data == value.data)
            XCTAssert(managedObject.date == value.date)
            XCTAssert(managedObject.decimal == value.decimal)
            XCTAssert(managedObject.double == value.double)
            XCTAssert(managedObject.float == value.float)
            XCTAssert(managedObject.int16 == value.int16)
            XCTAssert(managedObject.int32 == value.int32)
            XCTAssert(managedObject.int64 == value.int64)
            XCTAssert(managedObject.string == value.string)
            XCTAssert(managedObject.uri == value.uri)
            XCTAssert(managedObject.uuid == value.uuid)
            XCTAssert(managedObject.enumValue == value.enum.rawValue)
            XCTAssertNil(managedObject.optional)
            
            try context.save()
        })
    }
}
