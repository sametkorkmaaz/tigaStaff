//
//  SplashViewModelTests.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 30.09.2024.
//

import XCTest
@testable import tigaStaff

final class SplashViewModelTests: XCTestCase {

    private var viewModel: SplashViewModel!
    private var view: MockSplashViewController!
    private var remoteConfig: MocFirebaseRemoteConfig!
    private var networkMonitor: MockNetworkMonitor!
    private var authManager: MockFirebaseAuthManager!
    
    override func setUp() {
        super.setUp()
        view = MockSplashViewController() // View Controller Mock nesnesi oluşturuluyor
        remoteConfig = MocFirebaseRemoteConfig() // RemoteConfig Mock nesnesi oluşturuluyor
        networkMonitor = MockNetworkMonitor() // NetworkMonitor Mock nesnesi oluşturuluyor
        authManager = MockFirebaseAuthManager() // AuthManager Mock nesnesi oluşturuluyor

        // Tüm bağımlılıklar enjekte edilerek viewModel oluşturuluyor
        viewModel = SplashViewModel(
            remoteConfigManager: remoteConfig,
            networkMonitor: networkMonitor,
            authManager: authManager
        )
        viewModel.view = view
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        remoteConfig = nil
        networkMonitor = nil
        authManager = nil
        viewModel = nil
    }

    func test_viewDidload_InvokesMetods() {
        // given
        XCTAssertEqual(view.invokedConfigureSplahViewCount, 0)
        XCTAssertEqual(view.invokedAddSubViewsCount, 0)
        XCTAssertEqual(view.invokedConfigureViewsLayoutCount, 0)
        XCTAssertEqual(remoteConfig.invokedFetchRemoteConfigValueCount, 0)
        XCTAssertEqual(networkMonitor.invokedIsConnectedGetterCount, 0)
        XCTAssertEqual(authManager.invokedGetAuthenticatedUserCount, 0)
        // when
        viewModel.viewDidLoad()
        // then
        XCTAssertEqual(view.invokedConfigureSplahViewCount, 1)
        XCTAssertEqual(view.invokedAddSubViewsCount, 1)
        XCTAssertEqual(view.invokedConfigureViewsLayoutCount, 1)
        XCTAssertEqual(remoteConfig.invokedFetchRemoteConfigValueCount, 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertEqual(self.networkMonitor.invokedIsConnectedGetterCount, 1)
            XCTAssertEqual(self.authManager.invokedGetAuthenticatedUserCount, 1)
        }

    }

}
