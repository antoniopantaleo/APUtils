import Foundation

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

public extension Array {
    
    subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else { return defaultValue() }
        return self[index]
    }
    
}
