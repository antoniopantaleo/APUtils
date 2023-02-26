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
    
    static var autolayout: Self {
        let `self` = Self()
        `self`.translatesAutoresizingMaskIntoConstraints = false
        return `self`
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
}

public extension UICollectionView {
    
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
