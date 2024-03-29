//
//  ProfileRouter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import Foundation

protocol ProfileRouterProtocol {
    var entry: ProfileViewController? { get }
    
    static func createProfile() -> ProfileRouterProtocol
}

class ProfileRouter: ProfileRouterProtocol {
    var entry: ProfileViewController?
    
    static func createProfile() -> ProfileRouterProtocol {
        let router = ProfileRouter()
        
        var view: ProfileViewProtocol = ProfileViewController()
        
        var presenter: ProfilePresenterProtocol = ProfilePresenter()
        
        let interactor: ProfileUseCase = Injection.init().provideProfile()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? ProfileViewController
        
        return router
    }
}
