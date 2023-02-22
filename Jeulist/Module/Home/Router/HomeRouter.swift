//
//  HomeRouter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import UIKit

typealias BeginEntry = HomeViewProtocol & UIViewController

protocol HomeRouterProtocol {
    var beginEntry: BeginEntry? { get }
    
    static func start() -> HomeRouterProtocol
    
}


class HomeRouter: HomeRouterProtocol {
    var beginEntry: BeginEntry?
    
    static func start() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        var view: HomeViewProtocol = HomeViewController()
        var presenter: HomePresenterProtocol = HomePresenter()
        
        return router
    }
}
