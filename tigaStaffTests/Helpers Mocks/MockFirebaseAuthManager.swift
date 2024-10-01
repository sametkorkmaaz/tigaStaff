//
//  MocklFirebaseAuthManager.swift
//  tigaStaffTests
//
//  Created by Samet Korkmaz on 1.10.2024.
//

@testable import tigaStaff
import Foundation


final class MockFirebaseAuthManager: FirebaseAuthManagerInterface {
    
    var invokedGetAuthenticatedUser = false
    var invokedGetAuthenticatedUserCount = 0
    var stubbedGetAuthenticatedUserError: Error?
    var stubbedGetAuthenticatedUserResult: AuthDataResultModel!

    func getAuthenticatedUser() throws -> AuthDataResultModel {
        invokedGetAuthenticatedUser = true
        invokedGetAuthenticatedUserCount += 1
        if let error = stubbedGetAuthenticatedUserError {
            throw error
        }
        return stubbedGetAuthenticatedUserResult
    }

    var invokedCreateUser = false
    var invokedCreateUserCount = 0
    var invokedCreateUserParameters: (email: String, password: String)?
    var invokedCreateUserParametersList = [(email: String, password: String)]()
    var stubbedCreateUserResult: AuthDataResultModel?
    var stubbedCreateUserError: Error?

    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        invokedCreateUser = true
        invokedCreateUserCount += 1
        invokedCreateUserParameters = (email, password)
        invokedCreateUserParametersList.append((email, password))
        
        if let error = stubbedCreateUserError {
            throw error
        }
        
        guard let result = stubbedCreateUserResult else {
            throw URLError(.badServerResponse)
        }
        
        return result
    }

    var invokedSignInUser = false
    var invokedSignInUserCount = 0
    var invokedSignInUserParameters: (email: String, password: String)?
    var invokedSignInUserParametersList = [(email: String, password: String)]()
    var stubbedSignInUserResult: AuthDataResultModel?
    var stubbedSignInUserError: Error?

    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        invokedSignInUser = true
        invokedSignInUserCount += 1
        invokedSignInUserParameters = (email, password)
        invokedSignInUserParametersList.append((email, password))
        
        if let error = stubbedSignInUserError {
            throw error
        }
        
        guard let result = stubbedSignInUserResult else {
            throw URLError(.badServerResponse)
        }
        
        return result
    }

    var invokedSignOut = false
    var invokedSignOutCount = 0
    var stubbedSignOutError: Error?

    func signOut() throws {
        invokedSignOut = true
        invokedSignOutCount += 1
        if let error = stubbedSignOutError {
            throw error
        }
    }
}
