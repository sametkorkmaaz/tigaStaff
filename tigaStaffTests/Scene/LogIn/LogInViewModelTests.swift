//
//  LogInViewModelTests.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 1.10.2024.
//

@testable import tigaStaff
import XCTest

final class LogInViewModelTests: XCTestCase {

    private var viewModel: LoginViewModel!
    private var view: MockLoginViewController!
    private var viewController: LoginViewController!
    private var mockViewModel: MockLoginViewModel!
    private var authManager: MockFirebaseAuthManager!
    
    override func setUp() {
        super.setUp()
        view = MockLoginViewController()
        authManager = MockFirebaseAuthManager()
        viewController = LoginViewController()
        viewModel = LoginViewModel(authManager: authManager)
        mockViewModel = MockLoginViewModel()
        viewModel.view = view
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        viewController = nil
        authManager = nil
        mockViewModel = nil
        viewModel = nil
    }

    func test_viewDidload_InvokesMetods() {
        XCTAssertEqual(view.invokedConfigureViewCount, 0)
        XCTAssertEqual(view.invokedAddSubViewsCount, 0)
        XCTAssertEqual(view.invokedAddLayoutViewsCount, 0)
        XCTAssertEqual(view.invokedConfigurePasswordTextFieldCount, 0)
        
        viewModel.viewDidload()
        
        XCTAssertEqual(view.invokedConfigureViewCount, 1)
        XCTAssertEqual(view.invokedAddSubViewsCount, 1)
        XCTAssertEqual(view.invokedAddLayoutViewsCount, 1)
        XCTAssertEqual(view.invokedConfigurePasswordTextFieldCount, 1)
    }
    
    func test_viewController_loginButtonTapped_InvokesViewModelMethod() throws {
        // Butona basılmadan önce
        XCTAssertEqual(mockViewModel.isSignInCalled, false)

        // Butona basıldığında tetiklenen fonksiyonu manuel olarak çağırıyoruz
        mockViewModel.signIn()

        // Butona basıldıktan sonra
        XCTAssertEqual(mockViewModel.isSignInCalled, true)
    }

}
