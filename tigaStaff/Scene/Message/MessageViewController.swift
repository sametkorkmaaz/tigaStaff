//
//  MessageViewController.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import UIKit
import SnapKit

protocol MessageViewInterface: AnyObject {
    func configureHomePage()
    func addSubViews()
    func addViewsLayouts()
}

final class MessageViewController: UIViewController {
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

    private lazy var viewModel = MessageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    @objc func backButtontapped(){
        dismiss(animated: false, completion: nil)
    }
}
extension MessageViewController: MessageViewInterface{
    func configureHomePage() {
        view.backgroundColor = .tigaLightWhite
        backButton.addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
    }
    
    func addSubViews() {
        [backButton].forEach{
            view.addSubview($0)
        }
    }
    func addViewsLayouts(){
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(view.frame.width * 0.13)
        }
    }
    
}
#Preview(){
    MessageViewController()
}
