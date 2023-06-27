//
//  ThreadTests.swift
//  
//
//  Created by Antonio on 21/06/23.
//

import XCTest
@testable import APUtils

final class ThreadTests: XCTestCase {
    
    func testThread_isMainThread() {
        // Given
        let expectation = XCTestExpectation(description: "Code runs on main thread")
        let backgroundThread = DispatchQueue(label: "background", qos: .background)
        // When
        backgroundThread.async {
            XCTAssertFalse(Thread.isMainThread)
            mainThread {
                // Then
                XCTAssertTrue(Thread.isMainThread)
                expectation.fulfill()
            }
        }
        wait(for: [expectation])
    }
    
}
