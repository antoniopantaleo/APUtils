//
//  NSAttributedStringBuilderTests.swift
//  
//
//  Created by Antonio Pantaleo on 10/07/24.
//

import XCTest
import APUtils

@available(iOS 15, macOS 12, *)
final class NSAttributedStringBuilderTests: XCTestCase {

    func test_onlyStringsCreatesSimpleStringWithNoAttributes() {
        let sut = AttributedString {
            "Hello"
            "World"
        }
        XCTAssertEqual(sut.string, "Hello World")
    }

}


fileprivate extension AttributedString {
    var string: String {
        NSAttributedString(self).string
    }
}
