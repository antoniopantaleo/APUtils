//
//  CodableTests.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import XCTest

final class CodableTests: XCTestCase {
    
    private var sut: Employee!
    
    override func setUp() {
        super.setUp()
        sut = Employee(name: "Michael")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCodable_encodeStruct_generatesData() throws {
        // When
        let encoded = try sut.encoded
        // Then
        XCTAssertTrue(encoded.count > 0)
    }
    
    func testCodable_decodeData_noThrows() throws {
        // Given
        let encoded = try sut.encoded
        // When
        let decoded: Employee = try encoded.decoded()
        // Then
        XCTAssertNoThrow(decoded)
    }

    func testCodable_encodeDecodeStruct() throws {
        // Given
        let encoded = try sut.encoded
        // When
        let decoded: Employee = try encoded.decoded()
        // Then
        XCTAssertEqual(decoded, sut)
    }

}
