//
//  MockLoginViewModel.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 1.10.2024.
//

@testable import tigaStaff

final class MockLoginViewModel: LoginViewModelInterface {
    
    weak var view: LoginViewInterface?
    
    var isSignInCalled = false

    func viewDidload() {
        // viewDidload'un çağrılmasını takip etmiyoruz, boş bırakabiliriz.
    }

    func signIn() {
        isSignInCalled = true // Bu değişken tetiklenip tetiklenmediğini gösterecek
    }
}
