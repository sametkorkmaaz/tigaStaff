//
//  DetailViewController.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 18.09.2024.
//

import UIKit

protocol DetailViewInterface: AnyObject {
    func configureDetailPage()
    func addViewsLayouts()
}

class DetailViewController: UIViewController {
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 2
        btn.tintColor = UIColor(named: "tigaPickColor")
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        let largeImage = UIImage(systemName: "arrow.backward", withConfiguration: largeConfig)
        btn.setImage(largeImage, for: .normal)
        btn.backgroundColor = UIColor(named: "tigaDarkBlueColor")
        return btn
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .tigaLightWhite
        imageView.layer.shadowColor = UIColor.lightGray.cgColor
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 3
        imageView.layer.masksToBounds = false
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .tigaDarkBlue
        label.numberOfLines = 2
        return label
    }()
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.textColor = .tigaDarkBlue
        textView.backgroundColor = .tigaLightWhite
        textView.isEditable = false // Kullanıcının düzenleme yapmasını engeller
        textView.isSelectable = false // Kullanıcının metin seçimini engeller
        textView.isScrollEnabled = true // Kaydırma özelliği aktif
        textView.showsVerticalScrollIndicator = true // Dikey kaydırma göstergesi aktif
        textView.showsHorizontalScrollIndicator = false // Yatay kaydırma göstergesi kapalı
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // İçerik kenar boşlukları
        return textView
    }()
    
    lazy var viewModel = DetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    @objc func backButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: DetailViewInterface {
    
    func configureDetailPage() {
        view.backgroundColor = .tigaLightWhite
        
        if let imageURL = viewModel.imageURL {
            imageView.kf.setImage(with: URL(string: imageURL))
        }
        titleLabel.text = viewModel.titleText
        descriptionTextView.text = viewModel.descriptionText
        
        [imageView, titleLabel, descriptionTextView, backButton].forEach{
            view.addSubview($0)
        }
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func addViewsLayouts() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(view.frame.width * 0.13)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

#Preview(){
    HomeViewController()
}
