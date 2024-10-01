//
//  SignInViewModel.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 15.09.2024.
//

import Foundation

protocol SignInViewModelInterface {
    var view: SignInViewInterface? { get set }
    
    func viewDidLoad()
    func signIn()
}

final class SignInViewModel {
    weak var view: SignInViewInterface?
    
    let roles = ["Backed Developer", "Android Developer", "iOS Developer", "Software Lead", "Human Resources"]
    let genders = ["Woman", "Male"]
    var isPasswordVisible = false
    var email = ""
    var password = ""
    var userName = ""
    var userLastName = ""
    var userRole = ""
    var userGender = ""
    var userDateOfBirth = ""
    
}

extension SignInViewModel: SignInViewModelInterface{
    func viewDidLoad() {
        view?.configurePage()
        view?.addSubViews()
        view?.addVewLayouts()
        view?.setupDatePicker()
        view?.configurePasswordTextField()
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty, !userName.isEmpty, !userLastName.isEmpty, !userRole.isEmpty, !userGender.isEmpty, !userDateOfBirth.isEmpty else {
            print("Eksik alan var")
            return
        }
        
        Task {
            do{
                let returnedUserData = try await FirebaseAuthManager.shared.createUser(email: email, password: password)
                await FirebaseFireStore.shared.saveUserFirestore(collectionName: "users", userName: userName, userLastName: userLastName, dateOfBirth: userDateOfBirth, userGender: userGender, userRole: userRole, userEmail: email) { error in
                    print("Kullanıcı fireströde kaydedilemedi")
                }
                print(returnedUserData)
                view?.successRegister()
            } catch {
                print(error)
            }
        }
    }
}
