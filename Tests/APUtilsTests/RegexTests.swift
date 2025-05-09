//
//  RegexTests.swift
//  
//
//  Created by Antonio on 04/04/23.
//

import XCTest
@testable import APUtils

final class RegexTests: XCTestCase {
    
    func testRegex_matches_goodRegex() {
        // Given
        let sut = "This is a string with numbers: 123"
        let regex = "[0-9]+"
        // Then
        XCTAssertTrue(sut =~ regex)
    }
    
    func testRegex_matches_badRegex() {
        // Given
        let sut = "This is a string with numbers: 123"
        let regex = "[+"
        // Then
        XCTAssertFalse(sut =~ regex)
    }
    
    func testRegex_getMatches_goodRegex() throws {
        // Given
        let sut = "This is a string with numbers: 123, 456"
        let regex = "[0-9]+"
        // When
        let result = sut.matches(for: regex)
        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result[0], "123")
        XCTAssertEqual(result[1], "456")
    }
    
    func testRegex_getMatches_badRegex() throws {
        // Given
        let sut = "This is a string with numbers: 123, 456"
        let regex = "[+"
        // When
        let result = sut.matches(for: regex)
        // Then
        XCTAssertTrue(result.isEmpty)
    }
    
    func testRegex_replace_goodRegex() {
        // Given
        let sut = "This is a regex with numbers: 123"
        let regex = "[0-9]+"
        // When
        let result = sut.replace(regex: regex, with: "NUMBERS HERE")
        // Then
        XCTAssertEqual(result, "This is a regex with numbers: NUMBERS HERE")
    }
    
    func testRegex_replace_badRegex() {
        // Given
        let sut = "This is a regex with numbers: 123"
        let regex = "[+"
        // When
        let result = sut.replace(regex: regex, with: "NUMBERS HERE")
        // Then
        XCTAssertEqual(result, sut)
    }
    
}
