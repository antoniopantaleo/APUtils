import Foundation

/// Evaluates whether any condition in a list is true.
///
/// This function takes an array of Booleans, representing conditions, and returns `true`
/// if any of the conditions are `true`, or `false` if all are `false`.
/// Evaluation is done lazily and stops as soon as a `true` condition is found.
///
/// ```swift
/// let conditions = [false, false, true, false]
/// let result = any(conditions)
/// print(result)  // true
/// ```
///
///
/// - Parameter conditions: An array of Boolean values representing conditions to be evaluated.
///
/// - Returns: A Boolean value indicating whether any condition in the array is `true`.
///
/// - Note: The function will return `false` if the `conditions` array is empty.
public func any(_ conditions: [Bool]) -> Bool {
    for condition in conditions.lazy {
        if condition { return true }
    }
    return false
}


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
