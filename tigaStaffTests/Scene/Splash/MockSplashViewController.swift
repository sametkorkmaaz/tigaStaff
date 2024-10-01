//
//  MockSplashViewController.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 30.09.2024.
//

@testable import tigaStaff

final class MockSplashViewController: SplashViewInterface {

    var invokedConfigureSplahView = false
    var invokedConfigureSplahViewCount = 0
    func configureSplahView() {
        invokedConfigureSplahView = true
        invokedConfigureSplahViewCount += 1
    }

    var invokedAnimationText = false
    var invokedAnimationTextCount = 0
    func animationText() {
        invokedAnimationText = true
        invokedAnimationTextCount += 1
    }

    var invokedAddSubViews = false
    var invokedAddSubViewsCount = 0
    func addSubViews() {
        invokedAddSubViews = true
        invokedAddSubViewsCount += 1
    }

    var invokedConfigureViewsLayout = false
    var invokedConfigureViewsLayoutCount = 0
    func configureViewsLayout() {
        invokedConfigureViewsLayout = true
        invokedConfigureViewsLayoutCount += 1
    }

    var invokedPresentLoginScreen = false
    var invokedPresentLoginScreenCount = 0
    func presentLoginScreen() {
        invokedPresentLoginScreen = true
        invokedPresentLoginScreenCount += 1
    }

    var invokedPresentTabbarScreen = false
    var invokedPresentTabbarScreenCount = 0
    func presentTabbarScreen() {
        invokedPresentTabbarScreen = true
        invokedPresentTabbarScreenCount += 1
    }

    var invokedShowNoInternetAlert = false
    var invokedShowNoInternetAlertCount = 0
    var invokedShowNoInternetAlertParameters: (title: String, message: String, actionTitle: String)?
    var invokedShowNoInternetAlertParametersList = [(title: String, message: String, actionTitle: String)]()
    func showNoInternetAlert(title: String, message: String, actionTitle: String) {
        invokedShowNoInternetAlert = true
        invokedShowNoInternetAlertCount += 1
        invokedShowNoInternetAlertParameters = (title, message, actionTitle)
        invokedShowNoInternetAlertParametersList.append((title, message, actionTitle))
    }
}
