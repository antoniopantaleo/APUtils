//
//  LRUCacheTests.swift
//  
//
//  Created by Antonio on 14/03/23.
//

import XCTest
import APUtils

final class LRUCacheTests: XCTestCase {

    private var cache: LRUCache<String,Int>!
    
    override func setUp() {
        super.setUp()
        cache = .init(maxCapacity: 4)
    }
    
    override func tearDown() {
        cache = nil
        super.tearDown()
    }
    
    func testLRUCache_addValue() {
        // When
        cache["zero"] = 0
        // Then
        XCTAssertEqual(cache["zero"], 0)
    }
    
    func testLRUCache_addValue_twoTimes() {
        // When
        cache["zero"] = 0
        cache["zero"] = 1
        // Then
        XCTAssertEqual(cache["zero"], 1)
    }
    
    func testLRUCache_addValues_overCapacity() {
        // When
        cache["zero"] = 0
        cache["one"] = 1
        cache["two"] = 2
        cache["three"] = 3
        cache["four"] = 4
        // Then
        XCTAssertEqual(cache["zero"], nil)
        XCTAssertEqual(cache["one"], 1)
        XCTAssertEqual(cache["two"], 2)
        XCTAssertEqual(cache["three"], 3)
        XCTAssertEqual(cache["four"], 4)
    }
    
    func testLRUCache_addValues_overCapacity_changeQueue() {
        // When
        cache["zero"] = 0
        cache["one"] = 1
        cache["two"] = 2
        cache["three"] = 3
        _ = cache["zero"] // Use the value so its priority in the queue changes
        cache["four"] = 4
        // Then
        XCTAssertEqual(cache["one"], nil)
        XCTAssertEqual(cache["zero"], 0)
        XCTAssertEqual(cache["two"], 2)
        XCTAssertEqual(cache["three"], 3)
        XCTAssertEqual(cache["four"], 4)
    }

    
    
}
