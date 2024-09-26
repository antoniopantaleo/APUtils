//
//  AttributedStringBuilderTests.swift
//  
//
//  Created by Antonio Pantaleo on 10/07/24.
//

import XCTest
import APUtils

@available(iOS 15, macOS 12, *)
final class AttributedStringBuilderTests: XCTestCase {
    
    func test_onlyStringsCreatesSimpleStringWithNoAttributes() {
        let sut = AttributedString {
            "Hello"
            "World"
        }
        XCTAssertEqual(sut.string, "Hello World")
        XCTAssertTrue(sut.attributes(at: 0..<sut.count).isEmpty)
    }
    
    
    
    func test_onlyStsringsCreatesSimpleStringWithNoAttributes() {
        let sut = AttributedString {
            "Hello"
            Attributed(\.foregroundColor, .red) {
                "World"
            }
        }
        XCTAssertEqual(sut.string, "Hello World")
        XCTAssertTrue(sut.attributes(at: 0..<5).isEmpty)
        XCTAssertEqual(sut.attributes(at: 6..<sut.string.count)[.foregroundColor] as? NSColor, .red)
    }
    
    func test_noSpace() {
        let sut = AttributedString {
            "Hi"
            NoSpace {
                "Hello"
                "World"
            }
            "Again"
        }
        XCTAssertEqual(sut.string, "Hi HelloWorld Again")
    }
}



fileprivate extension AttributedString {
    var string: String {
        NSAttributedString(self).string
    }
    
    var count: Int {
        self.string.count
    }
    
    func attributes(at: Int) -> [NSAttributedString.Key: Any] {
        var range = NSRange(location: at, length: 1)
        return NSAttributedString(self).attributes(at: at, effectiveRange: &range)
    }
    
    func attributes(at: Range<Int>) -> [NSAttributedString.Key: Any] {
        var range = NSRange(location: at.lowerBound, length: at.count)
        return NSAttributedString(self).attributes(at: at.lowerBound, effectiveRange: &range)
    }
}
