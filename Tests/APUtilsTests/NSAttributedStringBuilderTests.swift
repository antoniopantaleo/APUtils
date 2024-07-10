//
//  NSAttributedStringBuilderTests.swift
//  
//
//  Created by Antonio Pantaleo on 10/07/24.
//

import XCTest
import APUtils

final class NSAttributedStringBuilderTests: XCTestCase {

    func test_onlyStringsCreatesSimpleStringWithNoAttributes() {
        let sut = NSAttributedString {
            "Hello"
            "World"
        }
        XCTAssertEqual(sut.string, "Hello World")
        (0..<sut.length).forEach {
            XCTAssertTrue(sut.attributes(at: $0, effectiveRange: nil).isEmpty)
        }
    }
}
