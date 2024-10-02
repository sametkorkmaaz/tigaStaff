//
//  SignInViewModelTests.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 2.10.2024.
//

import XCTest
@testable import tigaStaff

final class SignInViewModelTests: XCTestCase {

    private var view: MockSignInViewController!
    private var viewModel: SignInViewModel!
    private var authManager: MockFirebaseAuthManager!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init()
        viewModel.view = view
    }

    override func tearDown() {
        view = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_viewDidload_InvokesMethods() {
        XCTAssertEqual(view.invokedAddSubViewsCount, 0)
        XCTAssertEqual(view.invokedAddVewLayoutsCount, 0)
        XCTAssertEqual(view.invokedSetupDatePickerCount, 0)
        XCTAssertEqual(view.invokedConfigurePasswordTextFieldCount, 0)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedAddSubViewsCount, 1)
        XCTAssertEqual(view.invokedAddVewLayoutsCount, 1)
        XCTAssertEqual(view.invokedSetupDatePickerCount, 1)
        XCTAssertEqual(view.invokedConfigurePasswordTextFieldCount, 1)
    }



}
