//
//  ManagedObjectEncodingError.swift
//  Badger
//
//  Created by Paris Pinkney on 1/30/19.
//  Copyright © 2019 PXPGraphics, Inc. All rights reserved.
//

import Foundation

// MARK: - ManagedObjectEncodingError

public enum ManagedObjectEncodingError: Error {
    
    /// The context in which the error occurred.
    public struct Context {
        
        /// The path of coding keys taken to get to the point of the failing decode
        /// call.
        public let codingPath: [CodingKey]
        
        /// A description of what went wrong, for debugging purposes.
        public let debugDescription: String
        
        /// The underlying error which caused this error, if any.
        public let underlyingError: Error?
        
        /// Creates a new context with the given path of coding keys and a
        /// description of what went wrong.
        ///
        /// - parameter codingPath: The path of coding keys taken to get to the
        ///   point of the failing decode call.
        /// - parameter debugDescription: A description of what went wrong, for
        ///   debugging purposes.
        /// - parameter underlyingError: The underlying error which caused this
        ///   error, if any.
        public init(codingPath: [CodingKey], debugDescription: String, underlyingError: Error? = nil) {
            
            self.codingPath          = codingPath
            self.debugDescription    = debugDescription
            self.underlyingError     = underlyingError
        }
    }
    
    /// An indication that a value of the given type could not be encoded because
    /// it did not match the type of what was found in the data model.
    case typeMismatch
    
    /// An indication that a nonoptional value of the given type was expected,
    /// but a null value was found.
    case valueNotFound
    
    /// An indication that a keyed encoding container was asked for an entry for
    /// the given key, but did not contain one.
    case keyNotFound
    
    /// An indication that a keyed encoding container was asked for an entry for
    /// the given managed object attribute, but did not contain one.
    case attributeNotFound
}
