//
//  QRViewController.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import UIKit
import SnapKit

protocol QRViewInterface: AnyObject {
    var qrCodeImageView: UIImageView { get set }
    
    func configureHomePage()
    func qrCodeImage(_ image: UIImage)
}

final class QRViewController: UIViewController {

    lazy var qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .newWhite
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var viewModel = QRViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension QRViewController: QRViewInterface {
    
    func configureHomePage() {
        view.backgroundColor = .newWhite
        view.addSubview(qrCodeImageView)
        
        qrCodeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.8) // Sabit bir boyut vererek görüntüyü kontrol et
        }
    }
    
    func qrCodeImage(_ image: UIImage) {
        qrCodeImageView.image = image
    }
}

#Preview(){
    QRViewController()
}
