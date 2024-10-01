//
//  ProfileViewController.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import UIKit
import SnapKit

protocol ProfileViewInterface: AnyObject {
    func configureHomePage()
    func tableViewReloadData()
}

final class ProfileViewController: UIViewController {
    
    private lazy var profileCustomView: ProfileCustomView = {
        let view = ProfileCustomView()
        view.backgroundColor = .newWhite
        return view
    }()
    private lazy var employeesTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .newWhite
        return view
    }()
    
    private lazy var viewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
extension ProfileViewController: ProfileViewInterface{
    
    func configureHomePage() {
        view.backgroundColor = .white
        employeesTableView.dataSource = self
        employeesTableView.delegate = self
        profileCustomView.delegate = self
        employeesTableView.register(ProfileEmployeesTableViewCell.self, forCellReuseIdentifier: ProfileEmployeesTableViewCell.Identifier.custom.rawValue)
        [profileCustomView, employeesTableView].forEach{
            view.addSubview($0)
        }
        
        profileCustomView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        employeesTableView.snp.makeConstraints { make in
            make.top.equalTo(profileCustomView.snp.bottom)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.employeesTableView.reloadData()
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tigaUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEmployeesTableViewCell.Identifier.custom.rawValue, for: indexPath) as? ProfileEmployeesTableViewCell else { return UITableViewCell() }
        cell.cellDataModel(model: viewModel.tigaUsers[indexPath.row])
        if viewModel.tigaUsers[indexPath.row].gender == "Male" {
            cell.backgroundColor = .tigaLightBlue
        } else {
            cell.backgroundColor = .tigaWoman
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.15
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)

    }
    
}
extension ProfileViewController: ProfileCustomViewLogOutButtonTappedDelegate {
    func profileCustomViewLogOutButtonTapped() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
}
#Preview() {
    ProfileViewController()
}
