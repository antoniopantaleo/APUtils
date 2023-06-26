//
//  String+Extensions.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import Foundation


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
    /// Formats the string with the provided arguments.
    ///
    /// - Parameter arguments: The arguments to be formatted into the string.
    /// - Returns: The formatted string.
    func format(_ arguments: CVarArg...) -> String {
        String(format: self, arguments: arguments)
    }
    
}

public extension Data {
    /// Returns a UTF-8 encoded string representation of the data.
    ///
    /// - Note: If the data is not valid UTF-8 encoded, `nil` is returned.
    var utf8: String? {
        String(data: self, encoding: .utf8)
    }
}
