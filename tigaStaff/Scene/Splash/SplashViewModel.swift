//
//  SplashViewModel.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 15.09.2024.
//

import Foundation
import FirebaseRemoteConfig

protocol SplashViewModelInterface {
    var view: SplashViewInterface? { get set }
    
    func viewDidLoad()
    func checkNetworkAndProceed()
    func fetchSplashRemoteConfigValue()
}

final class SplashViewModel {
    weak var view: SplashViewInterface?
    
    var splashText: String = ""{
        didSet {
            view?.animationText()
        }
    }
    private let remoteConfigManager: FirebaseRemoteConfigInterface
    private let networkMonitor: NetworkMonitorInterface
    private let authManager: FirebaseAuthManagerInterface
    
    init(remoteConfigManager: FirebaseRemoteConfigInterface = FirebaseRemoteConfig.shared, networkMonitor: NetworkMonitorInterface = NetworkMonitor.shared, authManager: FirebaseAuthManagerInterface = FirebaseAuthManager.shared) {
        self.remoteConfigManager = remoteConfigManager
        self.networkMonitor = networkMonitor
        self.authManager = authManager
    }
}

extension SplashViewModel: SplashViewModelInterface {
        
    func viewDidLoad() {
        _ = NetworkMonitor.shared
        view?.configureSplahView()
        view?.addSubViews()
        view?.configureViewsLayout()

        fetchSplashRemoteConfigValue()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.checkNetworkAndProceed()
        }
    }
    
    func checkNetworkAndProceed() {
        if networkMonitor.isConnected {
            let authUser = try? authManager.getAuthenticatedUser()
            if authUser != nil {
                view?.presentTabbarScreen()
            } else {
                view?.presentLoginScreen()
            }
        } else {
            view?.showNoInternetAlert(title: "İnternet Bağlantısı Yok", message: "Lütfen internet bağlantınızı kontrol edin.", actionTitle: "Tamam")
        }
    }
    
    func fetchSplashRemoteConfigValue() {
        // Firebase Remote Config'den veri çekme
        remoteConfigManager.fetchRemoteConfigValue(remoteConfigKey: "splashText") { value in
            if let fetchedValue = value {
                DispatchQueue.main.async {
                    self.splashText = fetchedValue
                }
            } else {
                print("Failed to fetch value.")
            }
        }
    }
}
    

    

