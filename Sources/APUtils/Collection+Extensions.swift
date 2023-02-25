import Foundation
import Combine

public extension Collection where Element: Hashable {
    
    func occurences(of element: Element) -> Int {
        self.lazy.reduce(into: 0) { partialResult, currentElement in
            guard currentElement == element else { return }
            partialResult += 1
        }
    }
    
}

public extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return self.indices.lazy.contains(index) ? self[index] : nil
    }

}

public extension Collection where Element: Publisher {
    /// Merge a collection of publishers into a single publisher
    ///
    /// All the publisher must share the same `Output` and `Failure` type
    ///
    ///
    /// ```swift
    ///   let publisher1 = Just(1)
    ///   let publisher2 = Just(2)
    ///   let publisher3 = Just(3)
    ///
    ///   [publisher1, publisher2, publisher3]
    ///     .mergeToAnyPublisher()
    ///     .receive(on: RunLoop.main)
    ///     .sink { number in
    ///         // logic here
    ///     }
    ///     .store(in: &cancellables)
    /// ```
    /// - Returns: A new publisher that emits the same `Element.Output` and `Element.Failure` whenever any of the elements emits a value
    func mergeToAnyPublisher() -> AnyPublisher<Element.Output, Element.Failure> {
        let accumulator = Publishers.MergeMany<AnyPublisher<Element.Output, Element.Failure>>()
        return self
            .map({ $0.eraseToAnyPublisher()})
            .reduce(into: accumulator) { partialResult, currentCancellable in
                partialResult = partialResult.merge(with: currentCancellable)
            }
            .eraseToAnyPublisher()
    }
}

public extension Array {
    
    subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else { return defaultValue() }
        return self[index]
    }
    
}
