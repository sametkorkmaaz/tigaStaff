//
//  DetailViewModel.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 18.09.2024.
//

import Foundation

protocol DetailViewModelInterface {
    var view: DetailViewInterface? { get set }
    
    func viewDidLoad()
}

final class DetailViewModel {
    weak var view: DetailViewInterface?
    var imageURL: String?
    var titleText: String?
    var descriptionText: String?
}

extension DetailViewModel: DetailViewModelInterface {
    func viewDidLoad() {
        view?.configureDetailPage()
        view?.addViewsLayouts()
    }
}
