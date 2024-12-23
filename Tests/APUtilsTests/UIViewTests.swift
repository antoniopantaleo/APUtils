//
//  UIViewTests.swift
//  
//
//  Created by Antonio on 26/02/23.
//

#if canImport(UIKit)
import XCTest
import UIKit

final class UIViewTests: XCTestCase {

    //MARK: Autolayout
    func testUIView_view_autolayout() {
        // Given
        let view = UIView.autolayout
        // Then
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testUIView_button_autolayout() {
        // Given
        let view = UIButton.autolayout
        // Then
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testUIView_colletionView_autolayout() {
        // Given
        let view = UICollectionView.autolayout(collectionViewLayout: UICollectionViewLayout())
        // Then
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testUIView_tableView_autolayout() {
        // Given
        let view = UITableView.autolayout
        // Then
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testUIView_textField_autolayout() {
        // Given
        let view = UITextField.autolayout
        // Then
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testUIView_constraintActivation() {
        // Given
        let sut = UIView.autolayout
        let button = UIButton.autolayout
        // When
        sut.addSubview(button)
        NSLayoutConstraint.activate {
            button.centerXAnchor.constraint(equalTo: sut.centerXAnchor)
            button.centerYAnchor.constraint(equalTo: sut.centerYAnchor)
            button.widthAnchor.constraint(equalToConstant: 20)
            button.heightAnchor.constraint(equalToConstant: 20)
        }
        // Then
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.constraints.count, 2)
        XCTAssertEqual(button.constraints.count, 2)
    }
    
    //MARK: Add Subviews
    func testUIView_init_noSubviews() {
        // Given
        let containerView = UIView.autolayout
        // Then
        XCTAssertEqual(containerView.subviews.count, 0)
    }
    
    func testUIView_addSubviews() {
        // Given
        let containerView = UIView.autolayout
        let view1 = UIView.autolayout
        let view2 = UIView.autolayout
        let view3 = UIView.autolayout
        // When
        containerView.addSubviews(view1, view2, view3)
        // Then
        XCTAssertEqual(containerView.subviews.count, 3)
    }
    
    func testUIView_addSubview_activateConstraints_withEmptyClosure() {
        // Given
        let sut = UIView.autolayout
        let button = UIButton.autolayout
        // When
        sut.addSubview(button) { _, _ in }
        // Then
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.constraints.count, 0)
        XCTAssertEqual(button.constraints.count, 0)
    }
    
    func testUIView_addSubview_activateConstraints() {
        // Given
        let sut = UIView.autolayout
        let button = UIButton.autolayout
        // When
        sut.addSubview(button) { view, button in
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            button.widthAnchor.constraint(equalToConstant: 20)
            button.heightAnchor.constraint(equalToConstant: 20)
        }
        // Then
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.constraints.count, 2)
        XCTAssertEqual(button.constraints.count, 2)
    }
    
    func testUIView_addSubview_viewBuilder_activateConstraints() {
        // Given
        let sut = UIView.autolayout
        var button: UIButton?
        // When
        sut.addSubview {
            let view = UIButton.autolayout
            button = view
            return view
        } constraints: { view, button in
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            button.widthAnchor.constraint(equalToConstant: 20)
            button.heightAnchor.constraint(equalToConstant: 20)
        }
        // Then
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.constraints.count, 2)
        XCTAssertEqual(button?.constraints.count, 2)
    }
    
    //MARK: IsVisible
    func testUIView_isVisible() {
        // Given
        let view = UIView.autolayout
        // When
        view.isHidden = true
        // Then
        XCTAssertFalse(view.isVisible)
    }
    
    func testUIView_isNotVisible() {
        // Given
        let view = UIView.autolayout
        // When
        view.isHidden = false
        // Then
        XCTAssertTrue(view.isVisible)
    }
    
    func testUIView_setIsVisible() {
        // Given
        let view = UIView.autolayout
        // When
        view.isVisible = true
        // Then
        XCTAssertFalse(view.isHidden)
    }
    
    func testUIView_setIsNotVisible() {
        // Given
        let view = UIView.autolayout
        // When
        view.isVisible = false
        // Then
        XCTAssertTrue(view.isHidden)
    }
}
#endif
