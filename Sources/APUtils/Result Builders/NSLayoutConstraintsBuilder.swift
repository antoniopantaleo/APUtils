//
//  NSLayoutConstraintsBuilder.swift
//  
//
//  Created by Antonio on 26/02/23.
//
#if canImport(UIKit)
import UIKit

/// Create autolayout constraints with a SwiftUI like DSL
@resultBuilder
public enum NSLayoutConstraintsBuilder {
    
    public static func buildBlock(_ components: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }
}

extension NSLayoutConstraintsBuilder {
    
    public static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        expression
    }
    
    public static func buildExpression(_ expression: Void) -> [NSLayoutConstraint] {
        []
    }
    
    public static func buildOptional(_ component: [NSLayoutConstraint]?) -> [NSLayoutConstraint] {
        component ?? []
    }
    
    public static func buildEither(first component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        component
    }
    
    public static func buildEither(second component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        component
    }
    
    public static func buildArray(_ components: [[NSLayoutConstraint]]) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }
    
    public static func buildLimitedAvailability(_ component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        component
    }
    
}

public extension NSLayoutConstraint {
    
    /// Activate a closure of `NSLayoutConstraint`s
    /// - Parameter constraints: A closure in which you can define all of your constraints separated by a new line
    ///
    /// Example:
    ///
    /// ```swift
    /// NSLayoutConstraint.activate {
    ///     // Express simple constraints
    ///     view.centerXAnchor.constraint(equalTo: someView.centerXAnchor)
    ///     view.centerYAnchor.constraint(equalTo: someView.centerYAnchor)
    ///
    ///     // Unwrapping an optional variable
    ///     if let fixedLogoSize = fixedLogoSize {
    ///         someView.widthAnchor.constraint(equalToConstant: fixedLogoSize.width)
    ///         someView.heightAnchor.constraint(equalToConstant: fixedLogoSize.height)
    ///     }
    ///
    ///     // Use if-then-else conditionals
    ///     if alignLogoTop {
    ///         // Use this constraint if True
    ///         someView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    ///     } else {
    ///         // Use this constraint if False
    ///         someView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ///     }
    ///
    ///     // You can use Void too
    ///     print("Constraint activation finished")
    /// }
    /// ```
    static func activate(@NSLayoutConstraintsBuilder constraints: () -> [NSLayoutConstraint]) {
        activate(constraints())
    }
    
}
#endif
