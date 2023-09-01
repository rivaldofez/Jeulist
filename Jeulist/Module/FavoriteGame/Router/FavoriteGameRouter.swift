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
}

//class FavoriteGameRouter: FavoriteGameRouterProtocol {
//    var entry: FavoriteGameViewController?
//
//    static func createFavoriteGame() -> FavoriteGameRouterProtocol {
//
//    }
//
//
//}
