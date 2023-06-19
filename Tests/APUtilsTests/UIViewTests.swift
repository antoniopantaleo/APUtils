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
