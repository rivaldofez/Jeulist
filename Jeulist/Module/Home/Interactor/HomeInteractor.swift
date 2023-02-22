//
//  HomeInteractor.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import Foundation
import RxSwift


protocol HomeUseCase {
    func getGameDataPagination(page: Int) -> Observable<[Game]>
}

class HomeInteractor: HomeUseCase {
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameDataPagination(page: Int) -> RxSwift.Observable<[Game]> {
        return repository.getGameDataPagination(page: page)
    }
    
    
}
