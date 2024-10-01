//
//  HomeViewModel.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import Foundation
protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidLoad()
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
}

extension HomeViewModel: HomeViewModelInterface{
    func viewDidLoad() {
        view?.configureHomePage()
        view?.prepareScrolView()
        view?.addSubViews()
        view?.addViewsLayuouts()
    }
}
