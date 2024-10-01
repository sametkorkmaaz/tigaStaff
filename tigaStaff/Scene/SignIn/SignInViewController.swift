//
//  SignInViewController.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 15.09.2024.
//

import UIKit
import SnapKit

protocol SignInViewInterface: AnyObject {
    func configurePage()
    func addSubViews()
    func addVewLayouts()
    func setupDatePicker()
    func configurePasswordTextField()
    func successRegister()
}
final class SignInViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "tigaTersBG")
        return imageView
    }()
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
    private let singUpTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sign Up"
        lbl.font = .systemFont(ofSize: 35, weight: .bold)
        lbl.textColor = UIColor(named: "tigaDarkBlueColor")
        return lbl
    }()
    private let haveAccountLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Already have an account?"
        lbl.textColor = UIColor(named: "tigaDarkBlueColor")
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        return lbl
    }()
    private let logInButton: UIButton = {
        let btn = UIButton()
        // Altı çizili metin oluşturmak için NSAttributedString kullanıyoruz
        btn.tintColor = UIColor(named: "tigaPickColor")
        let title = NSAttributedString(string: "Log In", attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue, // Alt çizgi
            .foregroundColor: UIColor(named: "tigaPickColor") as Any, // Yazı rengi
            .font: UIFont.systemFont(ofSize: 15, weight: .regular) // Yazı tipi ve boyutu
        ])
        // Attributed title'ı butona ayarla
        btn.setAttributedTitle(title, for: .normal)
        return btn
    }()
    private let pageCenterUI: UIView = {
        let uView = UIView()
        uView.backgroundColor = .white
        uView.layer.cornerRadius = 10
        uView.clipsToBounds = true
        return uView
    }()
    private let nameTF: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.placeholder = "Name"
        tf.layer.borderWidth = 0.2
        tf.font = .systemFont(ofSize: 15, weight: .medium)
        tf.textColor = UIColor(named: "darkTextColor")
        tf.leftView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        tf.leftViewMode = .always
        return tf
    }()
    private let surnameTF: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.placeholder = "Surname"
        tf.layer.borderWidth = 0.2
        tf.font = .systemFont(ofSize: 15, weight: .medium)
        tf.textColor = UIColor(named: "darkTextColor")
        tf.leftView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        tf.leftViewMode = .always
        return tf
    }()
    private let emailTF: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.placeholder = "E-mail"
        tf.layer.borderWidth = 0.2
        tf.font = .systemFont(ofSize: 15, weight: .medium)
        tf.textColor = UIColor(named: "darkTextColor")
        tf.leftView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        tf.leftViewMode = .always
        return tf
    }()
    private let dateTF: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.placeholder = "DD/MM/YYYY"
        tf.layer.borderWidth = 0.2
        tf.font = .systemFont(ofSize: 15, weight: .medium)
        tf.textColor = UIColor(named: "darkTextColor")
        tf.leftView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        tf.leftViewMode = .always
        tf.keyboardType = .numberPad
        return tf
    }()
    private let rolePickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
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
    private let registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(named: "tigaPickColor")
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
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
    private let orLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Or"
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 15, weight: .bold)
        return lbl
    }()
    private let withGoogleButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "googleLogo"), for: .normal)
        btn.setTitle("Contiune with Google", for: .normal)
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
    
    private lazy var viewModel = SignInViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        emailTF.delegate = self
        rolePickerView.delegate = self
        rolePickerView.dataSource = self
        viewModel.viewDidLoad()
    }
    @objc func backButtontapped(){
        dismiss(animated: true, completion: nil)
    }
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" // İstediğiniz format
        dateTF.text = dateFormatter.string(from: sender.date)
    }
    @objc func donePressed() {
        self.view.endEditing(true) // Klavyeyi kapat
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
    @objc func registerButtonTapped() {
        viewModel.email = emailTF.text ?? ""
        viewModel.password = passwordTF.text ?? ""
        viewModel.userName = nameTF.text ?? ""
        viewModel.userLastName = surnameTF.text ?? ""
        viewModel.userDateOfBirth = dateTF.text ?? "" 
        viewModel.signIn()
       
    }
}
extension SignInViewController: SignInViewInterface {
    func configurePage() {
        viewModel.userGender = "Woman"
        viewModel.userRole = "Backed Developer"
        backButton.addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func addSubViews() {
        [backgroundImageView, backButton, singUpTitle, haveAccountLabel, logInButton, pageCenterUI, nameTF, surnameTF, emailTF, dateTF, rolePickerView, passwordTF, registerButton, lineView, lineView2, orLabel, withGoogleButton].forEach{
            view.addSubview($0)
        }
    }
    func setupDatePicker() {
        // DatePicker oluştur
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels // iOS 14 ve sonrası için stil
        datePicker.locale = Locale(identifier: "en_GB") // Gün/Ay/Yıl formatı

        // DatePicker'ı TextField'in inputView'una ata
        dateTF.inputView = datePicker

        // "Done" butonu ekleyerek kullanıcıyı tarih seçimini tamamlamaya yönlendir
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)

        dateTF.inputAccessoryView = toolbar

        // DatePicker'da bir tarih seçildiğinde çağrılacak yöntem
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    func configurePasswordTextField() {
        // Göz simgesi olan buton ekle
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = UIColor(named: "tigaDarkBlueColor")
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
    
    func addVewLayouts() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.height.width.equalTo(view.frame.width * 0.13)
        }
        singUpTitle.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(view.frame.height * 0.02)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(20)
        }
        haveAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(singUpTitle.snp.bottom).offset(7)
            make.centerX.equalToSuperview().offset(-view.frame.width * 0.03)
            make.height.greaterThanOrEqualTo(10)
        }
        logInButton.snp.makeConstraints { make in
            make.leading.equalTo(haveAccountLabel.snp.trailing).offset(5)
            make.centerY.equalTo(haveAccountLabel.snp.centerY)
            make.height.greaterThanOrEqualTo(10)
        }
        pageCenterUI.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(view.frame.height * 0.03)
            make.leading.equalToSuperview().offset(view.frame.width * 0.1)
            make.trailing.equalToSuperview().offset(-view.frame.width * 0.1)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        nameTF.snp.makeConstraints { make in
            make.top.equalTo(pageCenterUI.snp.top).offset(view.frame.height * 0.02)
            make.leading.equalTo(pageCenterUI.snp.leading).offset(20)
            make.height.equalTo(pageCenterUI.snp.height).multipliedBy(0.1)
            make.width.equalTo(pageCenterUI.snp.width).multipliedBy(0.42)
        }
        surnameTF.snp.makeConstraints { make in
            make.top.equalTo(nameTF.snp.top)
            make.trailing.equalTo(pageCenterUI.snp.trailing).offset(-20)
            make.height.equalTo(nameTF.snp.height)
            make.width.equalTo(nameTF.snp.width)
        }
        emailTF.snp.makeConstraints { make in
            make.top.equalTo(nameTF.snp.bottom).offset(view.frame.height * 0.02)
            make.leading.equalTo(nameTF.snp.leading)
            make.trailing.equalTo(surnameTF.snp.trailing)
            make.height.equalTo(nameTF.snp.height)
        }
        dateTF.snp.makeConstraints { make in
            make.top.equalTo(emailTF.snp.bottom).offset(view.frame.height * 0.02)
            make.leading.equalTo(emailTF.snp.leading)
            make.trailing.equalTo(emailTF.snp.trailing)
            make.height.equalTo(emailTF.snp.height)
        }
        rolePickerView.snp.makeConstraints { make in
            make.top.equalTo(dateTF.snp.bottom)
            make.height.equalTo(dateTF.snp.height).multipliedBy(1.7)
            make.leading.equalTo(dateTF.snp.leading)
            make.trailing.equalTo(dateTF.snp.trailing)
        }
        passwordTF.snp.makeConstraints { make in
            make.top.equalTo(rolePickerView.snp.bottom)
            make.leading.equalTo(dateTF.snp.leading)
            make.trailing.equalTo(dateTF.snp.trailing)
            make.height.equalTo(dateTF.snp.height)
        }
        registerButton.snp.makeConstraints { make in
            make.leading.equalTo(passwordTF.snp.leading)
            make.trailing.equalTo(passwordTF.snp.trailing)
            make.top.equalTo(passwordTF.snp.bottom).offset(view.frame.height * 0.02)
            make.height.equalTo(passwordTF.snp.height)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(view.frame.height * 0.02)
            make.leading.equalTo(registerButton.snp.leading)
            make.height.equalTo(1)
            make.width.equalTo(registerButton.snp.width).multipliedBy(0.4)
        }
        lineView2.snp.makeConstraints { make in
            make.centerY.equalTo(lineView.snp.centerY)
            make.height.equalTo(lineView)
            make.width.equalTo(lineView)
            make.trailing.equalTo(registerButton.snp.trailing)
        }
        orLabel.snp.makeConstraints { make in
            make.leading.equalTo(lineView.snp.trailing)
            make.trailing.equalTo(lineView2.snp.leading)
            make.centerY.equalTo(lineView.snp.centerY)
            make.height.greaterThanOrEqualTo(10)
        }
        withGoogleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(view.frame.height * 0.01)
            make.height.equalTo(registerButton.snp.height)
            make.leading.equalTo(registerButton.snp.leading)
            make.trailing.equalTo(registerButton.snp.trailing)
            make.bottom.equalTo(pageCenterUI.snp.bottom).offset(-view.frame.height * 0.015)
        }
    }
    func successRegister() {
        DispatchQueue.main.async {
            let tabbarVC = TabbarController()
            tabbarVC.modalPresentationStyle = .fullScreen
            self.present(tabbarVC, animated: true, completion: nil)
        }
    }
}
extension SignInViewController: UITextFieldDelegate{
    // Kullanıcının girdiği tüm karakterleri küçük harfe dönüştürme
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textRange = Range(range, in: textField.text ?? "") {
            let updatedText = textField.text?.replacingCharacters(in: textRange, with: string.lowercased())
            textField.text = updatedText
        }
        return false
    }
}
extension SignInViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // Kaç tane sütun (bölüm) olacak
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    // Kaç tane satır olacak (rollerin sayısı kadar)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return viewModel.roles.count
        }else if component == 1{
            return viewModel.genders.count
        } else {
            return 0
        }
    }
    // Her bileşen için genişlik belirleme
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        // Soldaki bileşen genişliğini sağdakinin iki katı yap
        if component == 0 {
            return pickerView.frame.width * 2 / 3 // Soldaki bileşen genişliği (2 kat büyük)
        } else {
            return pickerView.frame.width / 3 // Sağdaki bileşen genişliği (normal genişlik)
        }
    }
    // MARK: UIPickerViewDelegate
    // Her satırda ne gösterilecek (özelleştirilmiş görünüm)
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        
        if component == 0 {
            label.text = viewModel.roles[row]
            label.textColor = UIColor(named: "tigaDarkBlueColor")
        } else if component == 1 {
            label.text = viewModel.genders[row]
            if row == 0 {
                label.textColor = UIColor(.pink)
            } else {
                label.textColor = UIColor(.blue)
            }
        }

        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }

    // Seçilen elemanı yakalamak için
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            let selectedRole = viewModel.roles[row]
            viewModel.userRole = selectedRole
        } else if component == 1{
            let selectesGender = viewModel.genders[row]
            viewModel.userGender = selectesGender
        } else {
            print("piclker view component error")
        }
    }

}
