//
//  CombineTests.swift
//  
//
//  Created by Antonio on 03/04/24.
//

import XCTest
import Combine
import APUtils

final class CombineTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    
    
    //MARK: Proving that Combine strongly retains its subscribers
    
    func test_sink_stronglyRetainsSubscriber() {
        // Given
        let expectation = expectation(description: "Waiting for deinit")
        expectation.isInverted = true
        class Sut {
            private let onDeinit: () -> Void
            private var cancellable: AnyCancellable?
            private(set) var stringValue: String? = nil
            
            init(onDeinit: @escaping () -> Void) {
                self.onDeinit = onDeinit
            }
            
            func subscribe(publisher: AnyPublisher<String, Never>) {
                cancellable = publisher.sink { value in
                    self.stringValue = value
                }
            }
            
            deinit { onDeinit() }
        }
        let publisher = PassthroughSubject<String, Never>()
        var sut: Sut? = Sut { expectation.fulfill() }
        var stringValue: String?
        // When
        sut?.subscribe(publisher: publisher.eraseToAnyPublisher())
        publisher.send("Hello world")
        stringValue = sut?.stringValue
        sut = nil
        // Then
        XCTAssertEqual(stringValue, "Hello world")
        wait(for: [expectation], timeout: 1)
    }
    
    func test_assign_stronglyRetainsSubscriber() {
        // Given
        let expectation = expectation(description: "Waiting for deinit")
        expectation.isInverted = true
        class Sut {
            private let onDeinit: () -> Void
            private var cancellable: AnyCancellable?
            private(set) var stringValue: String = ""
            
            init(onDeinit: @escaping () -> Void) {
                self.onDeinit = onDeinit
            }
            
            func subscribe(publisher: AnyPublisher<String, Never>) {
                cancellable = publisher.assign(to: \.stringValue, on: self)
            }
            
            deinit { onDeinit() }
        }
        let publisher = PassthroughSubject<String, Never>()
        var sut: Sut? = Sut { expectation.fulfill() }
        // When
        sut?.subscribe(publisher: publisher.eraseToAnyPublisher())
        publisher.send("Hello world")
        // Then
        XCTAssertEqual(sut?.stringValue, "Hello world")
        sut = nil
        wait(for: [expectation], timeout: 1)
    }
    
    //MARK: Proving that Combine extensions can weakly retain its subscribers
    
    func test_weakSink_doesNotRetainSubscriber() {
        // Given
        let expectation = expectation(description: "Waiting for deinit")
        class Sut {
            private let onDeinit: () -> Void
            private var cancellable: AnyCancellable?
            private(set) var stringValue: String? = nil
            
            init(onDeinit: @escaping () -> Void) {
                self.onDeinit = onDeinit
            }
            
            func subscribe(publisher: AnyPublisher<String, Never>) {
                cancellable = publisher.sink(weak: self) { weakSelf, value in
                    weakSelf?.stringValue = value
                }
            }
            
            deinit { onDeinit() }
        }
        let publisher = PassthroughSubject<String, Never>()
        var sut: Sut? = Sut { expectation.fulfill() }
        // When
        sut?.subscribe(publisher: publisher.eraseToAnyPublisher())
        publisher.send("Hello world")
        XCTAssertEqual(sut?.stringValue, "Hello world")
        sut = nil
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func test_weakAssign_doesNotRetainSubscriber() {
        // Given
        let expectation = expectation(description: "Waiting for deinit")
        class Sut {
            private let onDeinit: () -> Void
            private var cancellable: AnyCancellable?
            private(set) var stringValue: String = ""
            
            init(onDeinit: @escaping () -> Void) {
                self.onDeinit = onDeinit
            }
            
            func subscribe(publisher: AnyPublisher<String, Never>) {
                cancellable = publisher.weakAssign(to: \.stringValue, on: self)
            }
            
            deinit {  onDeinit() }
        }
        let publisher = PassthroughSubject<String, Never>()
        var sut: Sut? = Sut { expectation.fulfill() }
        // When
        sut?.subscribe(publisher: publisher.eraseToAnyPublisher())
        publisher.send("Hello world")
        XCTAssertEqual(sut?.stringValue, "Hello world")
        sut = nil
        // Then
        wait(for: [expectation], timeout: 1)
    }
}
