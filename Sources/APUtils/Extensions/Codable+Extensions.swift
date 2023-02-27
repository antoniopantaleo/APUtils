//
//  Codable+Extensions.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import Foundation

public extension Data {
    
    /// Tries to decode a `Data` as the specified type
    /// - Returns: The decoded object
    func decoded<T: Decodable>() throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
    
}

public extension Encodable {
    
    /// Tries to encode the instance into a `Data` object
    /// - Returns: The encoded data
    var encoded: Data {
        get throws {
            try JSONEncoder().encode(self)
        }
    }
}
