//
//  FirebaseAuthManager.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 24.09.2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let id: String
    let email: String?
    let photoURL: String?
    
    init(user: User) {
        self.id = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}

protocol FirebaseAuthManagerInterface {
    
    func getAuthenticatedUser() throws -> AuthDataResultModel
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel
    func signOut() throws
}

final class FirebaseAuthManager: FirebaseAuthManagerInterface {
    static let shared = FirebaseAuthManager()
    private init() {}
    
    // Önceden giriş yapmış mı
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        print("EMAİLLL: \(user.email ?? "YOK")")
        print("EMAİLLL: \(user.uid)")
        return AuthDataResultModel(user: user)
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
