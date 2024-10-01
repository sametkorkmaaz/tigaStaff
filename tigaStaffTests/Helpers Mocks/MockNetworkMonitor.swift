//
//  MockNetworkMonitor.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 1.10.2024.
//

@testable import tigaStaff

final class MockNetworkMonitor: NetworkMonitorInterface {

    var invokedIsConnectedGetter = false
    var invokedIsConnectedGetterCount = 0
    var stubbedIsConnected: Bool! = false
    var isConnected: Bool {
        invokedIsConnectedGetter = true
        invokedIsConnectedGetterCount += 1
        return stubbedIsConnected
    }
}
