//
//  HomeRouter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import UIKit

typealias BeginEntry = HomeViewProtocol & UIViewController

protocol HomeRouterProtocol {
    var begin: BeginEntry? { get }
    
    static func start() -> HomeRouterProtocol
    
}


class HomeRouter: HomeRouterProtocol {
    var begin: BeginEntry?
    
    static func start() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        var view: HomeViewProtocol = HomeViewController()
        var presenter: HomePresenterProtocol = HomePresenter()
        let interactor: HomeUseCase = Injection().provideHome()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.begin = view as? BeginEntry
        
        return router
    }
}
