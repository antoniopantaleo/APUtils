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
        @AutoLayoutBuilder constraints: (_ view: UIView, _ subview: T) -> [NSLayoutConstraint]
    ) {
        addSubview(view)
        NSLayoutConstraint.activate(constraints(self, view))
    }
    
}

public extension UICollectionView {
    
    /// Activate autolayout for the collection view
    /// - Parameter collectoinViewLayout: The layout to use
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
