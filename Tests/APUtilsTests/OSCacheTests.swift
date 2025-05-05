//
//  OSCacheTests.swift
//
//
//  Created by Antonio on 28/08/24.
//

import XCTest
import APUtils

final class OSCacheTests: XCTestCase {
    
    private var cache: OSCache<String, Int>!
    
    override func setUp() {
        super.setUp()
        cache = OSCache()
    }
    
    override func tearDown() {
        cache = nil
        super.tearDown()
    }
    
    func testOSCache_addValue() {
        // When
        cache["zero"] = 0
        // Then
        XCTAssertEqual(cache["zero"], 0)
    }
    
    func testOSCache_addValue_twoTimes() {
        // When
        cache["zero"] = 0
        cache["zero"] = 1
        // Then
        XCTAssertEqual(cache["zero"], 1)
    }
    
    func testOSCache_removeValue() {
        // When
        cache["zero"] = 0
        cache["zero"] = nil
        // Then
        XCTAssertNil(cache["zero"])
    }
    
}
