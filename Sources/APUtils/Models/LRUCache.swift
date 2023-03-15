//
//  LRUCache.swift
//  
//
//  Created by Antonio on 14/03/23.
//

import Foundation

public class LRUCache<Key: Hashable, Value> {
    private var cache: [Key:Value] = [:]
    private var recentlyUsedKeys: [Key] = []
    private let maxCapacity: Int
    
    public init(maxCapacity: Int = 20) {
        self.maxCapacity = maxCapacity
    }
    
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
