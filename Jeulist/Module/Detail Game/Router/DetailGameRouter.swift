//
//  DetailGameRouter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 23/02/23.
//

import Foundation

protocol DetailGameRouterProtocol {
    var entry: DetailGameViewController? { get }
    
    static func createDetailGame(with id: Int) -> DetailGameRouterProtocol
}

class DetailGameRouter: DetailGameRouterProtocol {
    var entry: DetailGameViewController?
    
    static func createDetailGame(with id: Int) -> DetailGameRouterProtocol {
        let router = DetailGameRouter()
        
        var view: DetailGameViewProtocol = DetailGameViewController()
        
        var presenter: DetailGamePresenterProtocol = DetailGamePresenter()
        
        let interactor: DetailGameUseCase = Injection().provideDetail()
        
        
        view.presenter = presenter
        
        router.entry = view as? DetailGameViewController
        return router
    }
}
