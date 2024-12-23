//
//  URLBuilderTests.swift
//  APUtils
//
//  Created by Antonio Pantaleo on 23/12/24.
//

import XCTest
import APUtils

final class URLBuilderTests: XCTestCase {
    
    func test_emptyURL() {
        let sut = URL { }
        XCTAssertNil(sut)
    }
    
    func test_scheme() {
        let sut = URL {
            Scheme("https")
        }
        XCTAssertEqual(sut?.absoluteString, "https:")
    }
    
    func test_schemeAndHost() {
        let sut = URL {
            Scheme("https")
            Host("www.example.com")
        }
        XCTAssertEqual(sut?.absoluteString, "https://www.example.com")
    }
    
    func test_schemeHostAndPath() {
        let sut = URL {
            Scheme("https")
            Host("www.example.com")
            Path("/path")
        }
        XCTAssertEqual(sut?.absoluteString, "https://www.example.com/path")
    }
    
    func test_schemeHostPathAndQuery() {
        let sut = URL {
            Scheme("https")
            Host("www.example.com")
            Path("/path")
            URLQueryItem(name: "key", value: "value")
        }
        XCTAssertEqual(sut?.absoluteString, "https://www.example.com/path?key=value")
    }
    
    func test_schemeHostPathAndMultipleQueries() {
        let sut = URL {
            Scheme("https")
            Host("www.example.com")
            Path("/path")
            URLQueryItem(name: "key", value: "value")
            URLQueryItem(name: "key2", value: "value2")
        }
        XCTAssertEqual(sut?.absoluteString, "https://www.example.com/path?key=value&key2=value2")
    }
    
    func test_schemeHostPathMultipleQueriesAndFragment() {
        let sut = URL {
            Scheme("https")
            Host("www.example.com")
            Path("/path")
            URLQueryItem(name: "key", value: "value")
            URLQueryItem(name: "key2", value: "value2")
            Fragment("fragment")
        }
        XCTAssertEqual(sut?.absoluteString, "https://www.example.com/path?key=value&key2=value2#fragment")
    }
    
    func test_schemeHostPathMultipleQueriesFragmentAndQueryAgain() {
        let sut = URL {
            Scheme("https")
            Host("www.example.com")
            Path("/path")
            URLQueryItem(name: "key", value: "value")
            URLQueryItem(name: "key2", value: "value2")
            Fragment("fragment")
            URLQueryItem(name: "key3", value: "value3")
        }
        XCTAssertEqual(sut?.absoluteString, "https://www.example.com/path?key=value&key2=value2&key3=value3#fragment")
    }
    
    func test_multipleValuesOverridePrevious() {
        let sut = URL {
            Path("/hello-world")
            Scheme("https")
            Host("www.example.com")
            Host("www.example.org")
            Scheme("http")
            Path("/path")
        }
        XCTAssertEqual(sut?.absoluteString, "http://www.example.org/path")
    }
    
    func test_queryItemsWithSameKeyOverridePrevious() {
        let sut = URL {
            Scheme("https")
            Host("www.example.com")
            Path("/path")
            URLQueryItem(name: "key", value: "value")
            URLQueryItem(name: "key", value: "value-two")
            URLQueryItem(name: "key-two", value: "value")
        }
        XCTAssertEqual(sut?.absoluteString, "https://www.example.com/path?key=value-two&key-two=value")
    }
}
