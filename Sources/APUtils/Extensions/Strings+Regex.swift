//
//  Strings+Regex.swift
//  
//
//  Created by Antonio on 28/03/23.
//

import Foundation

infix operator =~

public extension String {
    
    
    static func =~ (lhs: String, regex: String) -> Bool {
        guard let regularExpression = Self.regexCache[regex] ?? (try? NSRegularExpression(pattern: regex)) else { return false }
        Self.regexCache[regex] = regularExpression
        let range = Self.makeRange(string: lhs)
        return regularExpression.numberOfMatches(in: lhs, options: [], range: range) > 0
    }
    
    /// Returns an array of all matches in the string for the specified regular expression pattern.
    ///
    /// - Parameter regex: The regular expression pattern to match against.
    /// - Returns: An array of strings representing the matched substrings in the string.
    func matches(for regex: String) -> [String] {
        guard let regularExpression = Self.regexCache[regex] ?? (try? NSRegularExpression(pattern: regex)) else { return [] }
        Self.regexCache[regex] = regularExpression
        let range = Self.makeRange(string: self)
        return regularExpression.matches(in: self, range: range).compactMap {
            guard let range = Range($0.range, in: self) else { return nil }
            return String(self[range])
        }
    }
    
    /// Replaces occurrences of a regular expression pattern in the string with the specified replacement text.
    ///
    /// - Parameters:
    ///   - regex: The regular expression pattern to match against.
    ///   - text: The replacement text to substitute for matching occurrences.
    /// - Returns: A new string with the matched substrings replaced by the replacement text.
    func replace(regex: String, with text: String) -> String {
        guard let regularExpression = Self.regexCache[regex] ?? (try? NSRegularExpression(pattern: regex)) else { return self }
        Self.regexCache[regex] = regularExpression
        let range = Self.makeRange(string: self)
        return regularExpression.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: text)
    }
}

fileprivate extension String {
    
    static var regexCache = LRUCache<String, NSRegularExpression>()
    
    static func makeRange(string: String) -> NSRange {
        NSRange(string.startIndex..., in: string)
    }
}
