//
//  SplashViewController.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 15.09.2024.
//

import UIKit
import SnapKit
import FirebaseFirestore

protocol SplashViewInterface: AnyObject {
    
    func configureSplahView()
    func animationText()
    func addSubViews()
    func configureViewsLayout()
    func presentLoginScreen()
    func presentTabbarScreen()
    func showNoInternetAlert(title: String, message: String, actionTitle: String)
}

class SplashViewController: UIViewController {

    private let splashLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "tigaLogo")
        return imageView
    }()
    private let splashText: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "tigaDarkBlueColor")
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var viewModel = SplashViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}
 
extension SplashViewController: SplashViewInterface {

    func configureSplahView() {
        view.backgroundColor = UIColor(named: "tigaLightWhiteColor")
        splashText.text = ""
    }
    
    func addSubViews() {
        [splashLogo, splashText].forEach{
            view.addSubview($0)
        }
        [splashLogo, splashText].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func presentLoginScreen() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    func presentTabbarScreen() {
        let tabbarVC = TabbarController()
        tabbarVC.modalPresentationStyle = .fullScreen
        present(tabbarVC, animated: true, completion: nil)
    }
    
    func showNoInternetAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            self.viewModel.checkNetworkAndProceed()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureViewsLayout() {
        // --MARK: NSLayoutConstraint
      /*  NSLayoutConstraint.activate([
            splashLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashLogo.heightAnchor.constraint(equalToConstant: 200),
            splashLogo.widthAnchor.constraint(equalToConstant: 200),
            splashLogo.bottomAnchor.constraint(equalTo: splashText.topAnchor, constant: 20),
            
            splashText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            splashText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            splashText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ]) */
        // --MARK: Snapkit
        splashLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(view.frame.width * 0.6)
            make.height.equalTo(splashLogo.snp.width)
        }
        splashText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(splashLogo.snp.bottom).offset(-30)
            make.leading.equalTo(view.snp.leading).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
        }
        
    }
    
    func animationText() {
        var charIndex = 0.0
        let titleText = viewModel.splashText
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.07 * charIndex, repeats: false) { (timer) in
                self.splashText.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
}
