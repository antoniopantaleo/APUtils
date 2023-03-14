//
//  String+Extensions.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import Foundation

infix operator =~

/// Get substring using array notation
///
/// # Example
/// ```swift
/// let string = "Hello World"
/// print(string[0..<4] // "Hell"
/// print(string[6..8] // "Wo"
/// print(string[5..8] // " World"
/// ```
public extension String {
    
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound, range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
    
    
}

public extension String {
    
    /// Return the lorem ipsum string with a specified length
    /// - Parameter length: The string max length
    /// - Returns: The trimmed string
    static func loremIpsum(ofLength length: Int = 445) -> String {
        guard length > 0 else { return "" }
        let loremIpsum: String = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        return loremIpsum.prefix(length).description
    }
    
    /// Return the complete lorem ipsum string
    static var loremIpsum: String { loremIpsum() }
}

public extension String {
    
    func format(_ arguments: CVarArg...) -> String {
        String(format: self, arguments: arguments)
    }
    
}

public extension Data {
    var utf8: String? {
        String(data: self, encoding: .utf8)
    }
}


public extension String {
    
    static func =~ (lhs: String, regex: String) -> Bool {
        guard let regularExpression = try? NSRegularExpression(pattern: regex) else { return false }
        let range = Self.makeRange(string: lhs)
        return regularExpression.numberOfMatches(in: lhs, options: [], range: range) > 0
    }
    
    func matches(for regex: String) -> [String] {
        guard let regularExpression = try? NSRegularExpression(pattern: regex) else { return [] }
        let range = Self.makeRange(string: self)
        return regularExpression.matches(in: self, range: range).compactMap {
            guard let range = Range($0.range, in: self) else { return nil }
            return String(self[range])
        }
    }
    
    func replace(regex: String, with text: String) -> String {
        guard let regularExpression = try? NSRegularExpression(pattern: regex) else { return self }
        let range = Self.makeRange(string: self)
        return regularExpression.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: text)
    }
}

fileprivate extension String {
    
    static func makeRange(string: String) -> NSRange {
        NSRange(string.startIndex..., in: string)
    }
}
