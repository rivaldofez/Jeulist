//
//  FavoriteGamePresenter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 01/09/23.
//

import Foundation

protocol FavoriteGamePresenterProtocol {
    var router: FavoriteGameRouterProtocol? { get set }
    var interactor: FavoriteGameUseCase? { get set }
//    var view: Favorite
}
