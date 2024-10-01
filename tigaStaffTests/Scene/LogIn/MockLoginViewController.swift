//
//  MockLoginViewController.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 1.10.2024.
//

@testable import tigaStaff

final class MockLoginViewController: LoginViewInterface {

    var invokedConfigureView = false
    var invokedConfigureViewCount = 0
    
    func configureView() {
        invokedConfigureView = true
        invokedConfigureViewCount += 1
    }

    var invokedAddSubViews = false
    var invokedAddSubViewsCount = 0

    func addSubViews() {
        invokedAddSubViews = true
        invokedAddSubViewsCount += 1
    }

    var invokedAddLayoutViews = false
    var invokedAddLayoutViewsCount = 0

    func addLayoutViews() {
        invokedAddLayoutViews = true
        invokedAddLayoutViewsCount += 1
    }

    var invokedConfigurePasswordTextField = false
    var invokedConfigurePasswordTextFieldCount = 0

    func configurePasswordTextField() {
        invokedConfigurePasswordTextField = true
        invokedConfigurePasswordTextFieldCount += 1
    }

    var invokedSuccessLoginPresentHome = false
    var invokedSuccessLoginPresentHomeCount = 0

    func successLoginPresentHome() {
        invokedSuccessLoginPresentHome = true
        invokedSuccessLoginPresentHomeCount += 1
    }
}
