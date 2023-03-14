//
//  StringTests.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import XCTest
import APUtils

final class StringTests: XCTestCase {

    func testString_lowerRight_subscript() {
        // Given
        let string = "Hello World!"
        // Then
        XCTAssertEqual(string[0..<4], "Hell")
    }
    
    func testString_inclusive_subscript() {
        // Given
        let string = "Hello World!"
        // Then
        XCTAssertEqual(string[6..<8], "Wo")
    }
    
    func testString_loremIpsum_default() {
        // Given
        let sut = String.loremIpsum
        // Then
        XCTAssertEqual(sut.count, 445)
        XCTAssertTrue(sut.starts(with: "Lorem ipsum"))
    }
    
    func testString_loremIpsum_overMaxLength() {
        // Given
        let sut = String.loremIpsum(ofLength: 1000)
        // Then
        XCTAssertEqual(sut.count, 445)
        XCTAssertTrue(sut.starts(with: "Lorem ipsum"))
    }
    
    func testString_loremIpsum_underMaxLength() {
        // Given
        let sut = String.loremIpsum(ofLength: 50)
        // Then
        XCTAssertEqual(sut.count, 50)
        XCTAssertTrue(sut.starts(with: "Lorem ipsum"))
    }
    
    func testString_loremIpsum_underZeroLength() {
        // Given
        let sut = String.loremIpsum(ofLength: -50)
        // Then
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testString_loremIpsum_zeroLength() {
        // Given
        let sut = String.loremIpsum(ofLength: 0)
        // Then
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testString_data_utf8Encoded() throws {
        // Given
        let helloWorld = "Hello world"
        let sut = try XCTUnwrap(helloWorld.data(using: .utf8))
        // When
        let res = try XCTUnwrap(sut.utf8)
        // Then
        XCTAssertEqual(res, helloWorld)
    }
    
    func testString_format_oneString() {
        // Given
        let sut = "This is a %@"
        let token = "string"
        let expected = "This is a string"
        // When
        let res = sut.format(token)
        // Then
        XCTAssertEqual(res, expected)
    }
    
    
    func testRegex_matches_goodRegex() {
        // Given
        let sut = "This is a string with numbers: 123"
        let regex = "[0-9]+"
        // Then
        XCTAssertTrue(sut =~ regex)
    }
    
    func testRegex_getMatches_goodRegex() throws {
        // Given
        let sut = "This is a string with numbers: 123, 456"
        let regex = "[0-9]+"
        // When
        let result = sut.matches(for: regex)
        // Then
        XCTAssertTrue(result.count > 0)
        XCTAssertEqual(result[0], "123")
        XCTAssertEqual(result[1], "456")
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
}
