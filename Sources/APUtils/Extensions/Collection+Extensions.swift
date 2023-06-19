import Foundation
import Combine

public extension Collection where Element: Hashable {
    
    /// Find occurences of a specified element in a collection
    /// - Parameter element: The element to count
    /// - Returns: The number of occurences
    func occurences(of element: Element) -> Int {
        self.lazy.reduce(into: 0) { partialResult, currentElement in
            guard currentElement == element else { return }
            partialResult += 1
        }
    }
    
}

public extension Collection {
    
    /// Access safely to an item at a specified index
    /// - Parameter index: The index to access to
    /// - Returns: The corresponding element if the index exists
    ///
    /// ```swift
    /// let collection = [1,2,3]
    ///
    /// collection[safe: 0] // returns 1
    /// collection[safe: 3] // returns nil
    /// ```
    subscript(safe index: Index) -> Element? {
        return self.indices.lazy.contains(index) ? self[index] : nil
    }
    
    /// Access safely to an item at a specified index, fallback to a default value if the index does no exist
    /// - Parameters:
    ///    - index: The index to access to
    ///    - defaultValue: The default value to fallback to
    ///
    /// ```swift
    /// let collection = ["Foo", "Bar"]
    ///
    /// collection[0, default: "Baz"] // returns "Foo"
    /// collection[2, default: "Baz"] // returns "Baz"
    /// ```
    subscript(index: Index, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= startIndex, index < endIndex else { return defaultValue() }
        return self[index]
    }
    
}

public extension Collection where Element: Publisher {
    /// Merge a collection of publishers into a single publisher
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

public extension RangeReplaceableCollection {
    /// Generate the intersection bewteen two sets, keeping all the common elements
    /// - Parameter sequence: The set to intersect with
    /// - Returns: A set containing all the common elements
    func intersection<S: Sequence>(_ sequence: S) -> Self where S.Element == Element, Element: Hashable {
        var set = Set(sequence)
        return filter { !set.insert($0).inserted }
    }
    
    /// Concatenates the elements of a sequence with the elements of a given one
    /// - Parameter sequence: The sequence to concatenate with
    /// - Returns: A new sequence containing the old values plus the new ones
    func concatenate<S: Sequence>(with sequence: S) -> Self where S.Element == Element {
        var `self` = self
        `self`.append(contentsOf: sequence)
        return `self`
    }
    
}
