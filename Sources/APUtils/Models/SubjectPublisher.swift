//
//  SubjectPublisher.swift
//  APUtils
//
//  Created by Antonio on 27/09/24.
//

#if canImport(Combine)
import Foundation
import Combine

@propertyWrapper
public struct SubjectPublisher<T, Failure: Error> {
    
    public let wrappedValue: AnyPublisher<T, Failure>
    public let projectedValue: any Subject<T, Failure>
    
    public init() {
        projectedValue = PassthroughSubject()
        wrappedValue = projectedValue.eraseToAnyPublisher()
    }
    
    public init(initialState value: T) {
        projectedValue = CurrentValueSubject(value)
        wrappedValue = projectedValue.eraseToAnyPublisher()
    }
    
}
#endif
