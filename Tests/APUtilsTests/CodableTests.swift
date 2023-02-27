//
//  CodableTests.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import XCTest

final class CodableTests: XCTestCase {
    
    var sut: Employee!
    
    override func setUpWithError() throws {
        sut = Employee(name: "Michael")
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
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
