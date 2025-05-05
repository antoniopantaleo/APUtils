//
//  XCCombineTestCase.swift
//  APUtils
//
//  Created by Antonio on 27/09/24.
//

import XCTest
import Combine

class XCCombineTestCase: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
}
