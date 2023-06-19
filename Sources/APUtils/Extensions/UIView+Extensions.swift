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
