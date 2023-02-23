//
//  DetailGameInteractor.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 23/02/23.
//

import Foundation
import RxSwift

protocol DetailGameUseCase {
    func getGameDetail(id: Int) -> Observable<GameDetail>
}

class DetailGameInteractor: DetailGameUseCase {
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameDetail(id: Int) -> Observable<GameDetail> {
        return repository.getGameDetail(id: id)
    }
}
