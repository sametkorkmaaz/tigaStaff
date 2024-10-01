//
//  MockHomeViewController.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 30.09.2024.
//

@testable import tigaStaff

final class MockHomeViewController: HomeViewInterface {

    var invokedConfigureHomePage = false
    var invokedConfigureHomePageCount = 0
    func configureHomePage() {
        invokedConfigureHomePage = true
        invokedConfigureHomePageCount += 1
    }

    var invokedAddSubViews = false
    var invokedAddSubViewsCount = 0
    func addSubViews() {
        invokedAddSubViews = true
        invokedAddSubViewsCount += 1
    }

    var invokedAddViewsLayuouts = false
    var invokedAddViewsLayuoutsCount = 0
    func addViewsLayuouts() {
        invokedAddViewsLayuouts = true
        invokedAddViewsLayuoutsCount += 1
    }

    var invokedPrepareScrolView = false
    var invokedPrepareScrolViewCount = 0
    func prepareScrolView() {
        invokedPrepareScrolView = true
        invokedPrepareScrolViewCount += 1
    }
}
