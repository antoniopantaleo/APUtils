//
//  Combine+Extensions.swift
//
//
//  Created by Antonio on 03/04/24.
//

#if canImport(Combine)
import Combine

public extension Publisher {
    /// Subscribes to a publisher and handles its completion and emitted values with a weak reference to the specified object.
    ///
    /// - Parameters:
    ///   - object: The object to hold a weak reference.
    ///   - receiveCompletion: A closure to execute when the publisher completes.
    ///   - receiveValue: A closure to execute when the publisher emits a value.
    /// - Returns: An `AnyCancellable` representing the subscription.
    func sink<O: AnyObject>(
        weak object: O,
        receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
        receiveValue: @escaping (O?, Output) -> Void
    ) -> AnyCancellable {
        sink(receiveCompletion: receiveCompletion) { [weak object] value in
            receiveValue(object, value)
        }
    }
}

public extension Publisher where Failure == Never {
    /// Subscribes to a publisher and receives values with a weak reference to the specified object.
    ///
    /// - Parameters:
    ///   - object: The object to hold a weak reference.
    ///   - receiveValue: A closure to execute when the publisher emits a value.
    /// - Returns: An `AnyCancellable` representing the subscription.
    func sink<O: AnyObject>(weak object: O, receiveValue: @escaping (O?, Output) -> Void) -> AnyCancellable {
        sink { [weak object] value in
            receiveValue(object, value)
        }
    }
    
    /// Assigns the publisher's output to a specified key path on an object with a weak reference.
    ///
    /// - Parameters:
    ///   - keyPath: The key path on the object where the output will be assigned.
    ///   - object: The object to assign the output to.
    /// - Returns: An `AnyCancellable` representing the subscription.
    func weakAssign<O: AnyObject>(to keyPath: ReferenceWritableKeyPath<O, Output>, on object: O) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}

public extension Collection where Element: Publisher {
    /// Merges a collection of publishers into a single publisher
    ///
    /// All the publisher must share the same `Output` and `Failure` type
    ///
    ///
    /// ```swift
    /// let publisher1 = Just(1)
    /// let publisher2 = Just(2)
    /// let publisher3 = Just(3)
    ///
    /// [publisher1, publisher2, publisher3]
    ///   .mergeToAnyPublisher()
    ///   .receive(on: RunLoop.main)
    ///   .sink { number in
    ///       // logic here
    ///   }
    ///   .store(in: &cancellables)
    /// ```
    /// - Returns: A new publisher that emits the same `Element.Output` and `Element.Failure` whenever any of the elements emits a value
    func mergeToAnyPublisher() -> AnyPublisher<Element.Output, Element.Failure> {
        Publishers.MergeMany(self).eraseToAnyPublisher()
    }
}
#endif
