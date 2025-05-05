//
//  UIView+Extensions.swift
//  
//
//  Created by Antonio on 26/02/23.
//

#if canImport(UIKit)
import Foundation
import UIKit

public extension UIView {
    
    /// The opposite of `isHidden`
    var isVisible: Bool {
        get { !self.isHidden }
        set { self.isHidden = !newValue }
    }
    
    /// Activate autolayout for the view
    static var autolayout: Self {
        let `self` = Self()
        `self`.translatesAutoresizingMaskIntoConstraints = false
        return `self`
    }
    
    
    /// Adds a list of views on top of the current view
    /// - Parameter views: The views to add
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
}

public extension UIView {
    
    /// Adds a subview to the current view and activates immediatly the provided layout constraints
    /// - Parameters:
    ///   - view: The view to add as a subview
    ///   - constraints: A closure that defines the constraints between the views
    ///
    ///
    /// ```swift
    /// let view = UIView.autolayout
    /// let button = UIButton.autolayout
    ///
    /// view.addSubview(button) { view, button in
    ///     button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ///     button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    /// }
    /// ```
    func addSubview<T: UIView>(
        _ view: T,
        @NSLayoutConstraintsBuilder constraints: (_ view: UIView, _ subview: T) -> [NSLayoutConstraint]
    ) {
        addSubviewAndActivateConstraints(
            subview: view,
            constraints: constraints(self, view)
        )
    }

    /// Adds a subview to the current view and activates immediatly the provided layout constraints
    /// - Parameters:
    ///   - viewBuilder: The view closure to add as a subview
    ///   - constraints: A closure that defines the constraints between the views
    ///
    ///
    /// ```swift
    /// let view = UIView.autolayout
    ///
    /// view.addSubview {
    ///     let button = UIButton.autolayout
    ///     button.tint = .blue
    ///     button.text = "Hello world"
    ///     return button
    /// } constraints: { view, button in
    ///     button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ///     button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    /// }
    /// ```
    func addSubview<T: UIView>(
        _ viewBuilder: () -> T,
        @NSLayoutConstraintsBuilder constraints: (_ view: UIView, _ subview: T) -> [NSLayoutConstraint]
    ) {
        let view = viewBuilder()
        addSubviewAndActivateConstraints(
            subview: view,
            constraints: constraints(self, view)
        )
    }
    
    private func addSubviewAndActivateConstraints(subview: UIView, constraints: [NSLayoutConstraint]) {
        addSubview(subview)
        NSLayoutConstraint.activate(constraints)
    }
    
}

public extension UICollectionView {
    
    /// Activate autolayout for the collection view
    /// - Parameter collectionViewLayout: The layout to use
    static func autolayout(collectionViewLayout: UICollectionViewLayout) -> Self {
        let `self` = Self(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        `self`.translatesAutoresizingMaskIntoConstraints = false
        return `self`
    }
    
}
#endif
