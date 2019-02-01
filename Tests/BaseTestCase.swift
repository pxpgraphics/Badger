//
//  BaseTestCase.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import Badger
import CoreData
import XCTest

// MARK: - BaseTestCase

class BaseTestCase: XCTestCase {
 
}

// MARK: Core Data

extension BaseTestCase {
    
    var managedObjectModel: NSManagedObjectModel {
        return .mergedModel(from: Bundle.allBundles)!
    }
    
    func persistentStoreFileURL(_ function: String = #function, _ fileManager: FileManager = .default) -> URL {
        let cacheURL = try! fileManager.url(for: .cachesDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: false)
        
        let folderURL = cacheURL.appendingPathComponent("BaseTestCase", isDirectory: true)
        
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: folderURL.path, isDirectory: &isDirectory) == false || isDirectory.boolValue == false {
            try! fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
        
        let fileURL = folderURL.appendingPathComponent(function + "." + UUID().uuidString + ".sqlite", isDirectory: false)
        print("Created SQLite file at \(fileURL)")
        return fileURL
    }
    
    func setUpManagedObjectContext<T>(_ function: String = #function, _ block: (NSManagedObjectContext) throws -> T) rethrows -> T {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.undoManager = nil
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                           configurationName: nil,
                                                           at: persistentStoreFileURL(function),
                                                           options: nil)
        
        return try block(managedObjectContext)
    }
}
