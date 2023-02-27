//
//  Optional+Extensions.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import Foundation

public extension Optional where Wrapped == String {
    
    /// `True` if value is nil or empty
    var isNilOrEmpty: Bool {
        switch self {
            case .some(let wrapped):
                return wrapped.isEmpty
            case .none:
                return true
        }
    }
    
}

public extension Optional where Wrapped: Collection {

    /// `True` if value is nil or empty
    var isNilOrEmpty: Bool {
        switch self {
            case .none:
                return true
            case .some(let wrapped):
                return wrapped.isEmpty
        }
    }
    
}

