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
    
    func goToDetailGame(with gameId: Int)
    
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
    
    func goToDetailGame(with gameId: Int) {
        let detailGameRouter = DetailGameRouter.createDetailGame(with: gameId)
        guard let detailGameView = detailGameRouter.entry else { return }
        guard let viewController = self.begin else { return }
        
        viewController.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(detailGameView, animated: true)
        viewController.hidesBottomBarWhenPushed = false
    }
    
}
