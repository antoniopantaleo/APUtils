//
//  AutoLayoutBuilderTests.swift
//  
//
//  Created by Antonio on 26/02/23.
//

#if canImport(UIKit)
import XCTest
import UIKit

final class AutoLayoutBuilderTests: XCTestCase {
    
    func testAutoLayoutBuilder_oneView_activateOneConstraint() {
        // Given
        let view = UIView.autolayout
        // When
        NSLayoutConstraint.activate {
            view.heightAnchor.constraint(equalToConstant: 100)
        }
        // Then
        XCTAssertEqual(view.constraints.count, 1)
    }
    
    func testAutoLayoutBuilder_oneView_activateMoreThanOneConstraints() {
        // Given
        let view = UIView.autolayout
        // When
        NSLayoutConstraint.activate {
            view.heightAnchor.constraint(equalToConstant: 100)
            view.widthAnchor.constraint(equalToConstant: 100)
        }
        // Then
        XCTAssertEqual(view.constraints.count, 2)
    }
    
    func testAutoLayoutBuilder_oneView_activateConditionalsConstraints() {
        // Given
        let view = UIView.autolayout
        let condition = false
        // When
        NSLayoutConstraint.activate {
            view.heightAnchor.constraint(equalToConstant: 100)
            if condition {
                view.widthAnchor.constraint(equalToConstant: 100)
            }
        }
        // Then
        XCTAssertEqual(view.constraints.count, 1)
    }
    
}
#endif
