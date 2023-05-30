//
//  LRUCache.swift
//  
//
//  Created by Antonio on 14/03/23.
//

import Foundation

/// An implementation of a Least Recently Used (LRU) Cache data structure
///
/// The cache keeps in memory last used items.
/// The oldest get removed when the number of items exceeds the capacity of the cache
///
/// ```swift
/// cache["zero"] = 0
/// cache["one"] = 1
/// cache["two"] = 2
/// cache["three"] = 3
/// cache["four"] = 4
///
/// print(cache["one"])     // 1
/// print(cache["two"])     // 2
/// print(cache["three"])   // 3
/// print(cache["four"])    // 4
/// print(cache["zero"])    // nil
/// ```
public class LRUCache<Key: Hashable, Value> {
    private var cache: [Key:Value] = [:]
    private var recentlyUsedKeys: [Key] = []
    private let maxCapacity: Int
    
    /// Creates a new LRUCache object
    ///
    /// - Parameter maxCapacity: The max number of items to keep in memory.
    ///
    /// Is mandatory to specify the types for the cache Key and Value
    ///
    /// ```swift
    /// var stringIntLRUCache = LRUCache<String, Int>()
    /// ```
    ///
    /// > If the number of items exceeds the cache capacity, the less recently used ones will be deleted
    public init(maxCapacity: Int = 20) {
        self.maxCapacity = maxCapacity
    }
    
    /// An handy approach to deal with LRUCache
    ///
    /// - Parameter key: The key to save or retrieve
    ///
    /// This subscripts lets you interact with the cache with Dictionary-like syntax:
    ///
    /// ```swift
    /// var cache = LRUCache<String: Int>()
    /// var cache["one"] = 1 // assign values
    /// let second = cache["second"] // retrieve values
    /// ```
    public subscript(key: Key) -> Value? {
        get { get(key) }
        set { put(key, newValue) }
    }
    
    private func get(_ key: Key) -> Value? {
        guard let value = cache[key] else { return nil }
        updateRecentlyUsedKeys(for: key)
        return value
    }
    
    private func put(_ key: Key, _ value: Value?) {
        if cache.count >= maxCapacity, let keyToRemove = recentlyUsedKeys.last {
            cache.removeValue(forKey: keyToRemove)
            recentlyUsedKeys.removeLast()
        }
        cache[key] = value
        updateRecentlyUsedKeys(for: key)
    }
    
    private func updateRecentlyUsedKeys(for key: Key) {
        recentlyUsedKeys.removeAll(where: { $0 == key })
        recentlyUsedKeys.insert(key, at: 0)
    }
    
}
