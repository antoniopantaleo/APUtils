//
//  TypealiasTests.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import XCTest
import APUtils

final class TypealiasTests: XCTestCase {

    func testPair_withString() {
        // Given
        let pair = Pair("Michael", "Dwight")
        // Then
        XCTAssertEqual(pair.first, "Michael")
        XCTAssertEqual(pair.second, "Dwight")
    }
    
    func testPair_withIntegers() {
        // Given
        let pair = Pair(1, 2)
        // Then
        XCTAssertEqual(pair.first, 1)
        XCTAssertEqual(pair.second, 2)
    }
    
    func testPair_withStructs() {
        // Given
        let michael = Employee(name: "Michael")
        let dwight = Employee(name: "Dwight")
        let pair = Pair(michael, dwight)
        // Then
        XCTAssertEqual(pair.first, michael)
        XCTAssertEqual(pair.second, dwight)
    }
}
