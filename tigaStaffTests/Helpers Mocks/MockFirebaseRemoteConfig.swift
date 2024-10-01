//
//  MocFirebaseRemoteConfig.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 1.10.2024.
//

@testable import tigaStaff

final class MocFirebaseRemoteConfig: FirebaseRemoteConfigInterface {

    var invokedFetchRemoteConfigValue = false
    var invokedFetchRemoteConfigValueCount = 0
    var invokedFetchRemoteConfigValueParameters: (remoteConfigKey: String, Void)?
    var invokedFetchRemoteConfigValueParametersList = [(remoteConfigKey: String, Void)]()
    var stubbedFetchRemoteConfigValueCompletionResult: (String?, Void)?
    func fetchRemoteConfigValue(remoteConfigKey: String, completion: @escaping (String?) -> Void) {
        invokedFetchRemoteConfigValue = true
        invokedFetchRemoteConfigValueCount += 1
        invokedFetchRemoteConfigValueParameters = (remoteConfigKey, ())
        invokedFetchRemoteConfigValueParametersList.append((remoteConfigKey, ()))
        if let result = stubbedFetchRemoteConfigValueCompletionResult {
            completion(result.0)
        }
    }

    var invokedSetupRemoteConfigDefaults = false
    var invokedSetupRemoteConfigDefaultsCount = 0
    func setupRemoteConfigDefaults() {
        invokedSetupRemoteConfigDefaults = true
        invokedSetupRemoteConfigDefaultsCount += 1
    }

    var invokedFetchRemoteConfig = false
    var invokedFetchRemoteConfigCount = 0
    var stubbedFetchRemoteConfigCompletionResult: (Bool, Void)?
    func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
        invokedFetchRemoteConfig = true
        invokedFetchRemoteConfigCount += 1
        if let result = stubbedFetchRemoteConfigCompletionResult {
            completion(result.0)
        }
    }
}
