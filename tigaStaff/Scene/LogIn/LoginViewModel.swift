//
//  LoginViewModel.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 15.09.2024.
//

import Foundation

protocol LoginViewModelInterface {
    var view: LoginViewInterface? { get set }
    
    func viewDidload()
    func signIn()
}

final class LoginViewModel {
    weak var view: LoginViewInterface?
    var isPasswordVisible = false
    var isCheckButtonTap = false
    
    var email = ""
    var password = ""

    private let authManager: FirebaseAuthManagerInterface
    init(authManager: FirebaseAuthManagerInterface = FirebaseAuthManager.shared) {
        self.authManager = authManager
    }
}

extension LoginViewModel: LoginViewModelInterface {
    func viewDidload() {
        view?.configureView()
        view?.addSubViews()
        view?.addLayoutViews()
        view?.configurePasswordTextField()
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else { return }
        Task {
            do {
                let returnedUserData = try await authManager.signInUser(email: email, password: password)
                view?.successLoginPresentHome()
            } catch {
                print("Giriş hatası: \(error)")
            }
        }
    }
}
