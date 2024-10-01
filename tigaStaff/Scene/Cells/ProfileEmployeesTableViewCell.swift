//
//  ProfileEmployeesTableViewCell.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 23.09.2024.
//

import UIKit
import SnapKit

class ProfileEmployeesTableViewCell: UITableViewCell {

    enum Identifier: String{
        case custom = "profileEmployeesTableViewCell"
    }
    
     lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .tigaDarkBlue
        return label
    }()
     lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .tigaDarkBlue
        return label
    }()
     lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .tigaDarkBlue
        return label
    }()
     lazy var dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .tigaDarkBlue
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        [nameLabel, roleLabel, emailLabel, dateOfBirthLabel].forEach {
            addSubview($0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(contentView.bounds.height * 0.1)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        roleLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.height.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(contentView.frame.height * 0.1)
        }
        emailLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.height.equalTo(nameLabel.snp.height)
            make.top.equalTo(roleLabel.snp.bottom).offset(contentView.frame.height * 0.1)
        }
        dateOfBirthLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.height.equalTo(nameLabel.snp.height)
            make.top.equalTo(emailLabel.snp.bottom).offset(contentView.frame.height * 0.1)
            make.bottom.equalToSuperview().offset(-contentView.bounds.height * 0.1)
        }
    }
    
    func cellDataModel(model: UserModel){
        nameLabel.text = model.name! + " " + model.lastName!
        roleLabel.text = model.role!
        emailLabel.text = model.email!
        dateOfBirthLabel.text = model.dateOfBirth!
    }
}

