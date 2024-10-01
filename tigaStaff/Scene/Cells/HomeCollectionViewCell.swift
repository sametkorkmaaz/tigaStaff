//
//  HomeCollectionViewCell.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 17.09.2024.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "homeCell"
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "aaaasdasdasd aaaasdasdasd aaaasdasdasd aaaasdasdasd"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 3
        label.textColor = .tigaDarkBlue
        return label
    }()
     let imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tigaLightWhite
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageViewCell)
        
        imageViewCell.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageViewCell.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
