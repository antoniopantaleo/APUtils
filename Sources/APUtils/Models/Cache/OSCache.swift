//
//  OSCache.swift
//
//
//  Created by Antonio on 28/08/24.
//

import Foundation

/// A full Swift wrapper around [NSCache](https://developer.apple.com/documentation/foundation/nscache)
///
/// ``OSCache`` is a generic, type-safe wrapper around NSCache that allows you to cache key-value pairs. As any ``Cache``, this class provides a simple and efficient way to store and retrieve cached data using subscripts.
///
/// - Note: Unlike [NSCache](https://developer.apple.com/documentation/foundation/nscache), ``OSCache`` can store value types too
///
///
/// ## Example
///
/// You can use ``OSCache`` to easily cache and retrieve objects like so:
///
/// ```swift
/// let cache = OSCache<String, UIImage>()
///
/// // Add an image to the cache
/// cache["profileImage"] = UIImage(named: "profile")
///
/// // Retrieve an image from the cache
/// if let profileImage = cache["profileImage"] {
///     // Use the cached image
/// }
///
/// // Remove the image from the cache
/// cache["profileImage"] = nil
/// ```
public class OSCache<Key: Hashable, Value>: Cache {
    
    private let cache = NSCache<WrappedKey, WrappedValue>()
    
    public init() {}
    
    public subscript(key: Key) -> Value? {
        get { get(key) }
        set {
            guard let newValue else { return remove(key) }
            put(key, newValue)
        }
    }
    
    private func get(_ key: Key) -> Value? {
        let wrappedKey = WrappedKey(key)
        return cache.object(forKey: wrappedKey)?.value
    }
    
    private func put(_ key: Key, _ value: Value) {
        let wrappedKey = WrappedKey(key)
        let wrappedValue = WrappedValue(value)
        cache.setObject(wrappedValue, forKey: wrappedKey)
    }
    
    private func remove(_ key: Key) {
        let wrappedKey = WrappedKey(key)
        cache.removeObject(forKey: wrappedKey)
    }
}

fileprivate extension OSCache {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int { key.hashValue }
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else { return false }
            return value.key == key
        }
    }
    
    final class WrappedValue {
        let value: Value
        
        init(_ value: Value) {
            self.value = value
        }
    }
}
