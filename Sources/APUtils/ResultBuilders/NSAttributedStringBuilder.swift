//
//  NSAttributedStringBuilder.swift
//
//
//  Created by Antonio Pantaleo on 10/07/24.
//

import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public protocol ExpressibleByNSAttribute {
    var value: String { get }
    var attributes: [NSAttributedString.Key : Any]? { get }
}

public struct Bold: ExpressibleByNSAttribute {
    public var attributes: [NSAttributedString.Key : Any]? {
        #if canImport(UIKit)
        [.font: UIFont.boldSystemFont(ofSize: 17)]
        #elseif canImport(AppKit)
        [.font: NSFont.boldSystemFont(ofSize: 17)]
        #else
        nil
        #endif
    }
    
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public init(_ value: () -> String) {
        self.value = value()
    }
}

// MARK: - Result Builder
@resultBuilder
public enum NSAttributedStringBuilder {
    
    public static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        let string = NSMutableAttributedString()
        components.forEach {
            let fullRange = NSRange(location: 0, length: $0.length)
            var currentRange = NSRange(location: 0, length: 0)
            let attributes = $0.attributes(at: 0, longestEffectiveRange: &currentRange, in: fullRange)
            string.append(
                NSAttributedString(
                    string: $0.string + " ",
                    attributes: attributes
                )
            )
        }
        string.deleteCharacters(
            in: NSRange(
                location: string.length - 1,
                length: 1
            )
        )
        return string
    }
}

// MARK: - Expressions
extension NSAttributedStringBuilder {
    public static func buildExpression(_ expression: NSAttributedString) -> NSAttributedString {
        expression
    }

    public static func buildExpression(_ expression: String) -> NSAttributedString {
        NSAttributedString(string: expression)
    }
    
    public static func buildExpression<T: ExpressibleByNSAttribute>(_ expression: T) -> NSAttributedString {
        return NSAttributedString(
            string: expression.value,
            attributes: expression.attributes
        )
    }
}

// MARK: - NSAttributedString convenience init
public extension NSAttributedString {
    convenience init(@NSAttributedStringBuilder _ builder: () -> NSAttributedString) {
        self.init(attributedString: builder())
    }
}
