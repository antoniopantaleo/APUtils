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
        let sut = UIView.autolayout
        // When
        NSLayoutConstraint.activate {
            sut.heightAnchor.constraint(equalToConstant: 100)
        }
        // Then
        XCTAssertEqual(sut.constraints.count, 1)
    }
    
    func testAutoLayoutBuilder_oneView_activateMoreThanOneConstraints() {
        // Given
        let sut = UIView.autolayout
        // When
        NSLayoutConstraint.activate {
            sut.heightAnchor.constraint(equalToConstant: 100)
            sut.widthAnchor.constraint(equalToConstant: 100)
        }
        // Then
        XCTAssertEqual(sut.constraints.count, 2)
    }
    
    func testAutoLayoutBuilder_oneView_activateConditionalsConstraints() {
        // Given
        let sut = UIView.autolayout
        let condition = false
        // When
        NSLayoutConstraint.activate {
            sut.heightAnchor.constraint(equalToConstant: 100)
            if condition {
                sut.widthAnchor.constraint(equalToConstant: 100)
            }
        }
        // Then
        XCTAssertEqual(sut.constraints.count, 1)
    }
    
}
#endif
