//
//  ProfileViewModel.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import Foundation
protocol ProfileViewModelInterface {
    var view: ProfileViewInterface? { get set }
    
    func viewDidLoad()
    func fetchTigaUsers()
}

final class ProfileViewModel {
    weak var view: ProfileViewInterface?
    var tigaUsers: [UserModel] = [] {
        didSet {
            view?.tableViewReloadData()
        }
    }
}

extension ProfileViewModel: ProfileViewModelInterface{
    
    func viewDidLoad() {
        view?.configureHomePage()
        fetchTigaUsers()
    }
    
    func fetchTigaUsers() {
        FirebaseFireStore.shared.fetchTigaUsers { users, error in
            if let error = error {
                print("Error fetching users from users: \(error)")
                return
            }
            if let users = users {
                self.tigaUsers.append(contentsOf: users)
            }
        }
    }
}
