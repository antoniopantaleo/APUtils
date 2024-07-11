//
//  NSAttributedStringBuilder.swift
//
//
//  Created by Antonio Pantaleo on 10/07/24.
//

import Foundation
import AppKit

@available(iOS 15, macOS 12, *)
public protocol AttributedStringConvertible {
    var attributedString: AttributedString { get }
}

@available(iOS 15, macOS 12, *)
public struct Attributed: AttributedStringConvertible {
    
    public private(set) var attributedString: AttributedString
    
    public init<Value>(
        _ attribute: WritableKeyPath<AttributeContainer, Value>,
        _ value: Value,
        @AttributedStringBuilder _ builder: () -> AttributedString
    ) {
        var container = AttributeContainer()
        container[keyPath: attribute] = value
        attributedString = builder()
        attributedString.setAttributes(container)
    }
}

@available(iOS 15, macOS 12, *)
public struct NoSpace: AttributedStringConvertible  {
    
    public private(set) var attributedString: AttributedString
    
    public init(@AttributedStringBuilder _ builder: () -> AttributedString) {
        attributedString = builder()
    }
    
}

// MARK: - Result Builder
@resultBuilder
@available(iOS 15, macOS 12, *)
public enum AttributedStringBuilder {
    
    public static func buildBlock(_ components: AttributedString...) -> AttributedString {
        guard let last = components.last else { return AttributedString() }
        let separator = AttributedString(" ")
        return components.dropLast().reduce(AttributedString()) { partialResult, component in
            partialResult + component + separator
        } + last
    }
}

// MARK: - Expressions
@available(iOS 15, macOS 12, *)
extension AttributedStringBuilder {
    public static func buildExpression(_ expression: AttributedString) -> AttributedString {
        return expression
    }

    public static func buildExpression(_ expression: String) -> AttributedString {
        return AttributedString(expression)
    }
    
    public static func buildExpression(_ expression: Attributed) -> AttributedString {
        expression.attributedString
    }
    
    public static func buildExpression(_ expression: NoSpace) -> AttributedString {
        expression.attributedString
    }
}

// MARK: - AttributedString convenience init
@available(iOS 15, macOS 12, *)
public extension AttributedString {
    init(@AttributedStringBuilder _ builder: () -> AttributedString) {
        self = builder()
    }
}
