//
//  FavoriteGameInteractor.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 01/09/23.
//

import Foundation
import RxSwift

protocol FavoriteGameUseCase {
    func getFavoriteGameList() -> Observable<[GameDetail]>
    func saveToggleFavoriteGame(gameDetail: GameDetail) -> Observable<Bool>
    
}

class FavoriteGameInteractor: FavoriteGameUseCase {
    func saveToggleFavoriteGame(gameDetail: GameDetail) -> RxSwift.Observable<Bool> {
        return repository.saveToggleGame(gameDetail: gameDetail)
    }
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteGameList() -> Observable<[GameDetail]> {
        return repository.getFavoriteGameList()
    }
}


