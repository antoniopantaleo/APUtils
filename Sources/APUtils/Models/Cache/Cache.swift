//
//  Cache.swift
//c
//
//  Created by Antonio on 28/08/24.
//

import Foundation

/// An abstraction of a Cache
///
/// A cache is a high-speed, transient data storage that improves performance by temporarily holding frequently accessed or computational expensive data.
///
/// - Important: Cache key must conform to the ``Hashable`` protocol
///
/// ## Example
///
/// You can interact with a cache using subscripts:
///
/// ```swift
/// var cache: Cache<SomeKey, SomeValue>
///
/// cache[someKey] = someValue // saving data
/// let value = cache[someKey] // retrieving data
/// cache[someKey] = nil // deleting data
/// ```
public protocol Cache {
    associatedtype Key: Hashable
    associatedtype Value
    
    subscript(key: Key) -> Value? { get set }
}
