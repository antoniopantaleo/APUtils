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
    
    func test_bold() {
        let sut = NSAttributedString {
            "Hello"
            Bold("World")
        }
        XCTAssertEqual(sut.string, "Hello World")
        (0..<5).forEach {
            XCTAssertTrue(sut.attributes(at: $0, effectiveRange: nil).isEmpty)
        }
        (6..<sut.length).forEach {
            let attributes = sut.attributes(at: $0, effectiveRange: nil)
            XCTAssertEqual(attributes.count, 1)
            #if canImport(UIKit)
            XCTAssertEqual(attributes[.font] as? NSFont, UIFont.boldSystemFont(ofSize: 17))
            #elseif canImport(AppKit)
            XCTAssertEqual(attributes[.font] as? NSFont, NSFont.boldSystemFont(ofSize: 17))
            #else
            XCTFail("No platform")
            #endif
        }
    }
    
    func test_bold_closure() {
        let sut = NSAttributedString {
            "Hello"
            Bold {
                "World"
            }
        }
        XCTAssertEqual(sut.string, "Hello World")
        (0..<5).forEach {
            XCTAssertTrue(sut.attributes(at: $0, effectiveRange: nil).isEmpty)
        }
        (6..<sut.length).forEach {
            let attributes = sut.attributes(at: $0, effectiveRange: nil)
            XCTAssertEqual(attributes.count, 1)
            #if canImport(UIKit)
            XCTAssertEqual(attributes[.font] as? NSFont, UIFont.boldSystemFont(ofSize: 17))
            #elseif canImport(AppKit)
            XCTAssertEqual(attributes[.font] as? NSFont, NSFont.boldSystemFont(ofSize: 17))
            #else
            XCTFail("No platform")
            #endif
        }
    }
}
