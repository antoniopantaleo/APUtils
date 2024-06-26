//
//  MockMacroTests.swift
//
//
//  Created by Antonio Pantaleo on 26/06/24.
//
#if canImport(MockMacro)

@_spi(ExperimentalLanguageFeature)
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
@_spi(ExperimentalLanguageFeature)
import MockMacro

final class MockMacroTests: XCTestCase {
    
    private let testMacros: [String: Macro.Type] = [
        "Mock": MockMacro.self
    ]
    
    func testMockMacro() throws {
        assertMacroExpansion(
            #"""
            @Mock(api: "/hello/world")
            func test_helloWorld() {
            }
            """#,
            expandedSource:
            #"""
            func test_helloWorld() {
                final class MockURLProtocol: URLProtocol {
                }
            }
            """#,
            macros: testMacros
        )
    }
}

#endif
