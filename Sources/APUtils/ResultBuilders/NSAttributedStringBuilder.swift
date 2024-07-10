//
//  NSAttributedStringBuilder.swift
//
//
//  Created by Antonio Pantaleo on 10/07/24.
//

import Foundation
import AppKit

public protocol ExpressibleByNSAttribute {
    var value: String { get }
    var attributes: [NSAttributedString.Key : Any]? { get }
}

public struct Bold: ExpressibleByNSAttribute {
    public var attributes: [NSAttributedString.Key : Any]? {
        [.font: NSFont.boldSystemFont(ofSize: 10)]
    }
    
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}


@resultBuilder
public enum NSAttributedStringBuilder {
    
    public static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        let string = NSMutableAttributedString()
        components.forEach {
            string.append(
                NSAttributedString(
                    string: $0.string + " "
                )
            )
        }
        string.deleteCharacters(in: NSRange(location: string.length - 1, length: 1))
        return string
    }
}

extension NSAttributedStringBuilder {
    public static func buildExpression(_ expression: NSAttributedString) -> NSAttributedString {
        expression
    }

    public static func buildExpression(_ expression: String) -> NSAttributedString {
        NSAttributedString(string: expression)
    }
    
    public static func buildExpression<T: ExpressibleByNSAttribute>(_ expression: T) -> NSAttributedString {
        NSAttributedString(
            string: expression.value,
            attributes: expression.attributes
        )
    }
}

public extension NSAttributedString {
    convenience init(@NSAttributedStringBuilder _ builder: () -> NSAttributedString) {
        self.init(attributedString: builder())
    }
}
