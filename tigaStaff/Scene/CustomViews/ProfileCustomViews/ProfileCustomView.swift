//
//  ProfileCustomView.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 23.09.2024.
//

import UIKit
import SnapKit

protocol ProfileCustomViewLogOutButtonTappedDelegate: AnyObject {
    func profileCustomViewLogOutButtonTapped()
}

class ProfileCustomView: UIView {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tigaLogoFull")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Samet Korkmaz"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .tigaDarkBlue
        return label
    }()
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "samet.korkmaz@tiga.com"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: .init(16), weight: .regular)
        label.textColor = .tigaDarkBlue
        return label
    }()
    private lazy var dateOfBirth: UILabel = {
        let label = UILabel()
        label.text = "12/12/12"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: .init(16), weight: .regular)
        label.textColor = .tigaDarkBlue
        return label
    }()
    private lazy var employeeRole: UILabel = {
        let label = UILabel()
        label.text = "Software Engineer"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: .init(16), weight: .regular)
        label.textColor = .tigaDarkBlue
        return label
    }()
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let largeImage = UIImage(systemName: "power", withConfiguration: largeConfig)
        button.setImage(largeImage, for: .normal)
        button.tintColor = .tigaPick
        button.backgroundColor = .tigaLightWhite
        return button
    }()
    
    var userEmail: String = "" {
        didSet {
            fetchProfileDatasWithUserEmail(email: userEmail)
            emailLabel.text = userEmail
        }
    }
    weak var delegate: ProfileCustomViewLogOutButtonTappedDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurePage()
        fetchProfileDatas()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func logOutButtonTapped() throws{
        try FirebaseAuthManager.shared.signOut()
        delegate?.profileCustomViewLogOutButtonTapped()
    }
    
    func configurePage() {
        [profileImageView, nameLabel, emailLabel, dateOfBirth, employeeRole, logOutButton].forEach{
            addSubview($0)
        }
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
            make.trailing.equalTo(logOutButton.snp.leading)
            make.top.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        employeeRole.snp.makeConstraints { make in
            make.centerX.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(nameLabel.snp.height)
            make.leading.trailing.equalTo(nameLabel)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(employeeRole.snp.bottom).offset(5)
            make.centerX.equalTo(nameLabel)
            make.height.equalTo(nameLabel.snp.height)
            make.leading.trailing.equalTo(nameLabel)
        }
        dateOfBirth.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.centerX.equalTo(nameLabel)
            make.height.equalTo(nameLabel.snp.height)
            make.leading.trailing.equalTo(nameLabel)
        }
        logOutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
        }
    }
    
    func fetchProfileDatas() {
        let authUser = try? FirebaseAuthManager.shared.getAuthenticatedUser()
        if authUser != nil {
            userEmail = (authUser?.email!)!
        } else {
            print("profile custom view EROOR")
        }
    }
    
    func fetchProfileDatasWithUserEmail(email: String) {
        FirebaseFireStore.shared.fetchTigaUserWithUserEmail(email: email) { user, error in
            if let error = error {
                print("Error fetching users from users: \(error)")
                return
            }
            if let user = user {
                self.nameLabel.text = user.name! + " " + user.lastName!
                self.employeeRole.text = user.role!
                self.dateOfBirth.text = user.dateOfBirth!
            }
        }
    }
}
