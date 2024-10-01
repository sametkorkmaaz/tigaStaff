//
//  LoginViewController.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 15.09.2024.
//

import UIKit

protocol LoginViewInterface: AnyObject {
    func configureView()
    func addSubViews()
    func addLayoutViews()
    func configurePasswordTextField()
    func successLoginPresentHome()
}
class LoginViewController: UIViewController {

    private let backgroundPage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "tigaBG")
        return imageView
    }()
    private let loginTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sign in to your tiga Account"
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        return lbl
    }()
    private let loginCenterUI: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private let withGoogleButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "googleLogo"), for: .normal)
        btn.setTitle("Contiune with Google", for: .normal)
        btn.titleLabel?.textAlignment = .left
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .heavy)
        btn.setTitleColor(UIColor(named: "tigaDarkBlueColor"), for: .normal)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 0.2
        
        btn.contentHorizontalAlignment = .fill
        // Görsel ve yazının boşluk ayarları
        
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 180) // Logonun sol boşluğu
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50) // Yazı ile logo arasındaki boşluk
            
        btn.layer.cornerRadius = 10

        return btn
    }()
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()
    private let lineView2: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()
    private let orLoginWith: UILabel = {
        let lbl = UILabel()
        lbl.text = "Or login with"
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 15, weight: .bold)
        return lbl
    }()
    private let emailTF : UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 0.2
        tf.layer.cornerRadius = 10
        tf.placeholder = "E-mail"
        tf.font = .systemFont(ofSize: 15, weight: .regular)
        // Sol tarafta boşluk eklemek için leftView kullanıyoruz
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always // Her zaman sol boşluk olsun
        return tf
    }()
    private let passwordTF: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 0.2
        tf.layer.cornerRadius = 10
        tf.placeholder = "Password"
        tf.font = .systemFont(ofSize: 15, weight: .regular)
        // Sol tarafta boşluk eklemek için leftView kullanıyoruz
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        // Parola alanı olarak ayarla (yazılanlar yıldız şeklinde görünsün)
        tf.isSecureTextEntry = true
        
        return tf
    }()
    private let checkButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    private let rememberMeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Remember me"
        lbl.textColor = .gray
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 13, weight: .regular)
        return lbl
    }()
    private let forgotButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Forgot Password ?", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        return btn
    }()
    private let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(named: "tigaPickColor")
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()
    private let dontHave: UILabel = {
        let lbl = UILabel()
        lbl.text = "Don't have an account?"
        lbl.textColor = .gray
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.font = .systemFont(ofSize: 13, weight: .regular)
        return lbl
    }()
    private let signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        return btn
    }()
    
    private lazy var viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        viewModel.viewDidload()
    }
    @objc func signUpButtonTapped(){
        let singInVC = SignInViewController()
        singInVC.modalPresentationStyle = .fullScreen
        present(singInVC, animated: true, completion: nil)
    }
    @objc func loginButtonTapped(){
        viewModel.email = emailTF.text ?? ""
        viewModel.password = passwordTF.text ?? ""
        viewModel.signIn()
    }
    @objc func togglePasswordVisibility() {
        viewModel.isPasswordVisible.toggle() // Durumu tersine çevir (görünür/gizli)
        passwordTF.isSecureTextEntry = !viewModel.isPasswordVisible
        // Simgeyi değiştir
        let imageName = viewModel.isPasswordVisible ? "eye" : "eye.slash"
        if let button = passwordTF.rightView as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    @objc func checkButtonTapped(){
        if viewModel.isCheckButtonTap {
            checkButton.setImage(UIImage(systemName: "square"), for: .normal)
        } else {
            checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        viewModel.isCheckButtonTap.toggle()
    }
}

extension LoginViewController: LoginViewInterface {
    
    func configureView() {
        view.backgroundColor = .white
         signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    func addSubViews() {
        [backgroundPage, loginTitle, loginCenterUI, withGoogleButton, lineView, lineView2, orLoginWith, emailTF, passwordTF, checkButton, rememberMeLabel, forgotButton, loginButton, dontHave, signUpButton].forEach{
            view.addSubview($0)
        }
    }
    func configurePasswordTextField() {
        // Göz simgesi olan buton ekle
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        // Sağ tarafta biraz boşluk bırakmak için UIView ekle
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 30)) // 15 px boşluk
        rightPaddingView.addSubview(eyeButton)
        // Butona basıldığında göz simgesini ve parola görünürlüğünü değiştir
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        // Sağ tarafa göz simgesi olan butonu ekle
        passwordTF.rightView = rightPaddingView
        passwordTF.rightViewMode = .always
    }
    func addLayoutViews() {
        backgroundPage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        loginTitle.snp.makeConstraints { make in
            make.bottom.equalTo(loginCenterUI.snp.top).offset(-view.frame.height * 0.05)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        loginCenterUI.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(view.frame.height * 0.07)
            make.height.equalTo(view.frame.height * 0.55)
            make.width.equalTo(view.frame.width * 0.8)
        }
        withGoogleButton.snp.makeConstraints { make in
            make.top.equalTo(loginCenterUI.snp.top).offset(20)
            make.leading.equalTo(loginCenterUI.snp.leading).offset(20)
            make.trailing.equalTo(loginCenterUI.snp.trailing).offset(-20)
            make.height.equalTo(loginCenterUI.snp.height).multipliedBy(0.11)
        }
        lineView.snp.makeConstraints { make in
            make.leading.equalTo(withGoogleButton.snp.leading)
            make.top.equalTo(withGoogleButton.snp.bottom).offset(25)
            make.height.equalTo(1)
            make.width.equalTo(withGoogleButton.snp.width).multipliedBy(0.3)
        }
        lineView2.snp.makeConstraints { make in
            make.trailing.equalTo(withGoogleButton.snp.trailing)
            make.top.equalTo(lineView.snp.top)
            make.height.equalTo(lineView.snp.height)
            make.width.equalTo(lineView.snp.width)
        }
        orLoginWith.snp.makeConstraints { make in
            make.leading.equalTo(lineView.snp.trailing)
            make.trailing.equalTo(lineView2.snp.leading)
            make.centerY.equalTo(lineView.snp.centerY)
            make.height.greaterThanOrEqualTo(20)
        }
        emailTF.snp.makeConstraints { make in
            make.leading.equalTo(withGoogleButton.snp.leading)
            make.trailing.equalTo(withGoogleButton.snp.trailing)
            make.height.equalTo(withGoogleButton.snp.height)
            make.top.equalTo(lineView.snp.bottom).offset(25)
        }
        passwordTF.snp.makeConstraints { make in
            make.leading.equalTo(emailTF.snp.leading)
            make.trailing.equalTo(emailTF.snp.trailing)
            make.height.equalTo(emailTF.snp.height)
            make.top.equalTo(emailTF.snp.bottom).offset(20)
        }
        checkButton.snp.makeConstraints { make in
            make.leading.equalTo(passwordTF.snp.leading).offset(5)
            make.top.equalTo(passwordTF.snp.bottom).offset(25)
            make.height.equalTo(rememberMeLabel.snp.height)
        }
        rememberMeLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(5)
            make.top.equalTo(checkButton.snp.top)
            make.bottom.equalTo(checkButton.snp.bottom)
            make.height.greaterThanOrEqualTo(10)
        }
        forgotButton.snp.makeConstraints { make in
            make.trailing.equalTo(passwordTF.snp.trailing)
            make.centerY.equalTo(rememberMeLabel.snp.centerY)
        }
        loginButton.snp.makeConstraints { make in
            make.leading.equalTo(passwordTF.snp.leading)
            make.trailing.equalTo(passwordTF.snp.trailing)
            make.height.equalTo(passwordTF.snp.height)
            make.top.equalTo(forgotButton.snp.bottom).offset(25)
        }
        dontHave.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(15)
            make.trailing.equalTo(signUpButton.snp.leading).offset(-5)
            make.bottom.equalTo(loginCenterUI.snp.bottom).offset(-15)
            make.height.greaterThanOrEqualTo(10)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerY.equalTo(dontHave.snp.centerY)
            make.trailing.equalTo(loginButton.snp.trailing).multipliedBy(0.85)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    func successLoginPresentHome() {
        DispatchQueue.main.async {
            let tabbarVC = TabbarController()
            tabbarVC.modalPresentationStyle = .fullScreen
            self.present(tabbarVC, animated: true, completion: nil)
        }
    }
    
}
