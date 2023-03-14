//
//  LRUCache.swift
//  
//
//  Created by Antonio on 14/03/23.
//

import Foundation

public class LRUCache<Key: Hashable, Value> {
    private var cache: [Key:Value] = [:]
    private var keyQueue: [Key] = []
    private let capacity: Int
    
    public init(capacity: Int = 20) {
        self.capacity = capacity
    }
    
    public subscript(key: Key) -> Value? {
        get {
            get(key)
        }
        set {
            put(key, newValue)
        }
    }
    
    private func get(_ key: Key) -> Value? {
        guard let value = cache[key] else { return nil }
        updateQueue(for: key)
        return value
    }
    
    private func put(_ key: Key, _ value: Value?) {
        if cache.count >= capacity, let keyToRemove = keyQueue.last {
            cache.removeValue(forKey: keyToRemove)
            keyQueue.removeLast()
        }
        cache[key] = value
        updateQueue(for: key)
    }
    
    private func updateQueue(for key: Key) {
        keyQueue.removeAll(where: { $0 == key })
        keyQueue.insert(key, at: 0)
    }
    
}
