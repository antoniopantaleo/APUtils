//
//  SubjectPublisherTests.swift
//  APUtils
//
//  Created by Antonio on 27/09/24.
//

import XCTest
import Combine
import APUtils

final class SubjectPublisherTests: XCCombineTestCase {
    
    func test_passhtroughSubject_publishesValues() {
        // Given
        @SubjectPublisher
        var sut: AnyPublisher<Int, Never>
        var receivedValues = [Int]()
        let expectation = expectation(description: "Waiting for values...")
        expectation.expectedFulfillmentCount = 3
        
        // When
        sut.sink { value in
            receivedValues.append(value)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        $sut.send(10)
        $sut.send(20)
        $sut.send(30)
        $sut.send(completion: .finished)
        
        wait(for: [expectation])
        
        // Then
        XCTAssertEqual(receivedValues, [10, 20, 30])
    }
    
    func test_currentValueSubject_publishesValues() {
        // Given
        @SubjectPublisher(initialState: 0)
        var sut: AnyPublisher<Int, Never>
        var receivedValues = [Int]()
        let expectation = expectation(description: "Waiting for values...")
        expectation.expectedFulfillmentCount = 4
        
        // When
        sut.sink { value in
            receivedValues.append(value)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        $sut.send(10)
        $sut.send(20)
        $sut.send(30)
        $sut.send(completion: .finished)
        
        wait(for: [expectation])
        
        // Then
        XCTAssertEqual(receivedValues, [0, 10, 20, 30])
    }
    
    func test_passhtroughSubject_publishesError() {
        // Given
        @SubjectPublisher
        var sut: AnyPublisher<Int, NSError>
        let expectedError = NSError(domain: "combine-error", code: 0)
        var receivedError: NSError?
        let expectation = expectation(description: "Waiting for failure...")
        
        // When
        sut.sink(
            receiveCompletion: { completion in
                guard case .failure(let error) = completion else {
                    return XCTFail("Expected .failure, got \(completion)")
                }
                receivedError = error
                expectation.fulfill()
            },
            receiveValue: { _ in }
        )
        .store(in: &cancellables)

        $sut.send(completion: .failure(expectedError))
        
        wait(for: [expectation])
        
        // Then
        XCTAssertEqual(receivedError, expectedError)

    }
    
    func test_currentValueSubject_publishesError() {
        // Given
        @SubjectPublisher(initialState: 0)
        var sut: AnyPublisher<Int, NSError>
        let expectedError = NSError(domain: "combine-error", code: 0)
        var receivedError: NSError?
        let expectation = expectation(description: "Waiting for failure...")
        
        // When
        sut.sink(
            receiveCompletion: { completion in
                guard case .failure(let error) = completion else {
                    return XCTFail("Expected .failure, got \(completion)")
                }
                receivedError = error
                expectation.fulfill()
            },
            receiveValue: { _ in }
        )
        .store(in: &cancellables)

        $sut.send(completion: .failure(expectedError))
        
        wait(for: [expectation])
        
        // Then
        XCTAssertEqual(receivedError, expectedError)
    }
}
