//
//  Optional+Extensions.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import Foundation

public extension Optional where Wrapped == String {
    
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

    var isNilOrEmpty: Bool {
        switch self {
            case .none:
                return true
            case .some(let wrapped):
                return wrapped.isEmpty
        }
    }
    
}

