//
//  OptionalTests.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import XCTest

final class OptionalTests: XCTestCase {

    func testOptional_stringNil() {
        // Given
        let sut: String? = nil
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertTrue(result)
    }
    
    func testOptional_stringEmpty() {
        // Given
        let sut: String? = ""
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertTrue(result)
    }
    
    func testOptional_stringNotEmpty() {
        // Given
        let sut: String? = "Hello world!"
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertFalse(result)
    }
    
    func testOptional_arrayNil() {
        // Given
        let sut: [String]? = nil
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertTrue(result)
    }
    
    func testOptional_arrayEmpty() {
        // Given
        let sut: [String]? = []
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertTrue(result)
    }
    
    func testOptional_arrayNotEmpty() {
        // Given
        let sut: [String]? = ["Hello", "world!"]
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertFalse(result)
    }
    
    func testOptional_setNil() {
        // Given
        let sut: Set<String>? = nil
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertTrue(result)
    }
    
    func testOptional_setEmpty() {
        // Given
        let sut: Set<String>? = []
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertTrue(result)
    }
    
    func testOptional_setNotEmpty() {
        // Given
        let sut: Set<String>? = ["Hello", "world!"]
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertFalse(result)
    }
    
    func testOptidictionaryl_setNil() {
        // Given
        let sut: [String:Any]? = nil
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertTrue(result)
    }
    
    func testOptiondictionarysetEmpty() {
        // Given
        let sut: [String:Any]? = [:]
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertTrue(result)
    }
    
    func testOptional_dictionaryNotEmpty() {
        // Given
        let sut: [String:Any]? = ["Hello": "world!"]
        // When
        let result = sut.isNilOrEmpty
        // Then
        XCTAssertFalse(result)
    }
}
