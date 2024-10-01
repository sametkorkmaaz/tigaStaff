//
//  HomeViewModelTests.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 30.09.2024.
//

import XCTest
@testable import tigaStaff

final class HomeViewModelTests: XCTestCase {

    private var viewModel: HomeViewModel!
    private var view: MockHomeViewController!
    
    override func setUp() { // her test fonk çalıştığında çalışır
        super.setUp()
        view = .init()
        viewModel = .init()
        viewModel.view = view
    }

    override func tearDown() { // het test fonk. bitince çalışır
        viewModel = nil
        view = nil
        super.tearDown()
    }

    func test_viewDidload_InvokesMethods() {
        // given
        XCTAssertEqual(view.invokedConfigureHomePageCount, 0)
        XCTAssertEqual(view.invokedAddSubViewsCount, 0)
        XCTAssertEqual(view.invokedPrepareScrolViewCount, 0)
        XCTAssertEqual(view.invokedAddViewsLayuoutsCount, 0)
        // when
        viewModel.viewDidLoad()
        // then
        XCTAssertEqual(view.invokedConfigureHomePageCount, 1)
        XCTAssertEqual(view.invokedAddSubViewsCount, 1)
        XCTAssertEqual(view.invokedPrepareScrolViewCount, 1)
        XCTAssertEqual(view.invokedAddViewsLayuoutsCount, 1)
    }

    
    
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
