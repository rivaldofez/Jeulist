//
//  FavoriteGameRouter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 01/09/23.
//

import Foundation

protocol FavoriteGameRouterProtocol {
    var entry: FavoriteGameViewController? { get set }
    
    static func createFavoriteGame() -> FavoriteGameRouterProtocol
    
    func gotoDetailGame(with id: Int)
}

class FavoriteGameRouter: FavoriteGameRouterProtocol {
    var entry: FavoriteGameViewController?
    
    static func createFavoriteGame() -> FavoriteGameRouterProtocol {
        let router = FavoriteGameRouter()
        var view: FavoriteGameViewProtocol = FavoriteGameViewController()
        var presenter: FavoriteGamePresenterProtocol = FavoriteGamePresenter()
        let interactor: FavoriteGameUseCase = Injection.init().provideFavorite()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? FavoriteGameViewController
        return router
    }
    
    func gotoDetailGame(with id: Int) {
        let detailGameRouter = DetailGameRouter.createDetailGame(with: id)
        guard let detailGameView = detailGameRouter.entry else { return }
        guard let viewController = self.entry else { return }
        
        viewController.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(detailGameView, animated: true)
        viewController.hidesBottomBarWhenPushed = false
    }
}
