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
    
    private var sut: UIView!
    
    override func setUp() {
        super.setUp()
        sut = UIView.autolayout
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAutoLayoutBuilder_oneView_activateOneConstraint() {
        // When
        NSLayoutConstraint.activate {
            sut.heightAnchor.constraint(equalToConstant: 100)
        }
        // Then
        assert(sut.constraints, toBeEqualTo: [(.height, 100)])
    }
    
    func testAutoLayoutBuilder_oneView_activateMoreThanOneConstraints() {
        // When
        NSLayoutConstraint.activate {
            sut.heightAnchor.constraint(equalToConstant: 100)
            sut.widthAnchor.constraint(equalToConstant: 150)
        }
        // Then
        assert(sut.constraints, toBeEqualTo: [(.height, 100), (.width, 150)])
    }
    
    func testAutoLayoutBuilder_oneView_activateConditionalsConstraints() {
        // Given
        let condition = false
        // When
        NSLayoutConstraint.activate {
            sut.heightAnchor.constraint(equalToConstant: 100)
            if condition {
                sut.widthAnchor.constraint(equalToConstant: 100)
            }
        }
        // Then
        assert(sut.constraints, toBeEqualTo: [(.height, 100)])
    }
    
    func testAutoLayoutBuilder_oneView_activateConditionalsConstraints_whenConditionIsTrue() {
        // Given
        let condition = true
        // When
        NSLayoutConstraint.activate {
            sut.heightAnchor.constraint(equalToConstant: 100)
            if condition {
                sut.widthAnchor.constraint(equalToConstant: 100)
            }
        }
        // Then
        assert(sut.constraints, toBeEqualTo: [(.height, 100), (.width, 100)])
    }
    
    
    //MARK: Helpers
    
    private func assert(
        _ constraints: [NSLayoutConstraint],
        toBeEqualTo expectedConstraints: [(attribute: NSLayoutConstraint.Attribute, constant: CGFloat)]
    ) {
        zip(constraints, expectedConstraints).forEach { (constraint, expectedConstraint) in
            XCTAssertEqual(constraint.firstAttribute, expectedConstraint.attribute)
            XCTAssertEqual(constraint.constant, expectedConstraint.constant)
        }
    }
    
}
#endif
