//
//  QRViewModel.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import Foundation
import UIKit

protocol QRViewModelInterface {
    var view: QRViewInterface? { get set }
    
    func viewDidLoad()
    func createQR()
    func fetchQRCodeDatas()
}

final class QRViewModel {
    weak var view: QRViewInterface?
    var userEmail: String?
    var userID: String?  {
        didSet {
            createQR()
        }
    }
}

extension QRViewModel: QRViewModelInterface {
    func viewDidLoad() {
        fetchQRCodeDatas()
        view?.configureHomePage()
    }
    func fetchQRCodeDatas() {
        let authUser = try? FirebaseAuthManager.shared.getAuthenticatedUser()
        if authUser != nil {
            userEmail = authUser?.email
            userID = authUser?.id
        } else {
            userEmail = nil
            userID = nil
        }
    }
    
    func createQR() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let formattedDate = dateFormatter.string(from: currentDate)
        view?.qrCodeImage(generateQRCode(from: "\(String(describing: userEmail!))\n\(String(describing: userID!)) \n\(String(describing: (formattedDate)))")!)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            
            filter.setValue(data, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
            
        }
        
        return nil
        
    }
}
