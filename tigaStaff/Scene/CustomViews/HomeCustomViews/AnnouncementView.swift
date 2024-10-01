//
//  AnnouncementView.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import UIKit
import SnapKit
import Kingfisher

class AnnouncementView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.kf.setImage(with: URL(string: "https://tigavakfi.org/wp-content/uploads/2023/10/AdemBey31.jpg"))
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .tigaDarkBlue
        label.textAlignment = .center
        label.numberOfLines = 7
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        fetchAdemRemoteConfigValue()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func fetchAdemRemoteConfigValue() {
        // Firebase Remote Config'den veri çekme
        FirebaseRemoteConfig.shared.fetchRemoteConfigValue(remoteConfigKey: "ademBeyMessage") { value in
            if let fetchedValue = value {
                DispatchQueue.main.async {
                    self.label.text = fetchedValue
                }
            } else {
                print("Failed to fetch value.")
            }
        }
    }
    private func setupView() {
        // Subview'ları ekleyin
        addSubview(imageView)
        addSubview(label)

        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0.5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(imageView.snp.height)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
