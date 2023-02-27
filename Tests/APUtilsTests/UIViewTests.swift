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
}
#endif
