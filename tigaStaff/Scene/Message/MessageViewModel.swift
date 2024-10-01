//
//  MessageViewModel.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import Foundation
protocol MessageViewModelInterface {
    var view: MessageViewInterface? { get set }
    
    func viewDidLoad()
}

final class MessageViewModel {
    weak var view: MessageViewInterface?
}

extension MessageViewModel: MessageViewModelInterface{
    func viewDidLoad() {
        view?.configureHomePage()
        view?.addSubViews()
        view?.addViewsLayouts()
    }
}
