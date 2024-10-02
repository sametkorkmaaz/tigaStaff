//
//  MockSignInViewController.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 2.10.2024.
//

@testable import tigaStaff

final class MockSignInViewController: SignInViewInterface {

    var invokedConfigurePage = false
    var invokedConfigurePageCount = 0

    func configurePage() {
        invokedConfigurePage = true
        invokedConfigurePageCount += 1
    }

    var invokedAddSubViews = false
    var invokedAddSubViewsCount = 0

    func addSubViews() {
        invokedAddSubViews = true
        invokedAddSubViewsCount += 1
    }

    var invokedAddVewLayouts = false
    var invokedAddVewLayoutsCount = 0

    func addVewLayouts() {
        invokedAddVewLayouts = true
        invokedAddVewLayoutsCount += 1
    }

    var invokedSetupDatePicker = false
    var invokedSetupDatePickerCount = 0

    func setupDatePicker() {
        invokedSetupDatePicker = true
        invokedSetupDatePickerCount += 1
    }

    var invokedConfigurePasswordTextField = false
    var invokedConfigurePasswordTextFieldCount = 0

    func configurePasswordTextField() {
        invokedConfigurePasswordTextField = true
        invokedConfigurePasswordTextFieldCount += 1
    }

    var invokedSuccessRegister = false
    var invokedSuccessRegisterCount = 0

    func successRegister() {
        invokedSuccessRegister = true
        invokedSuccessRegisterCount += 1
    }
}
