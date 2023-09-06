//
//  HomeInteractor.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getGameDataPagination(pageSize: Int, page: Int, search: String) -> Observable<[Game]>
}

class HomeInteractor: HomeUseCase {
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameDataPagination(pageSize: Int, page: Int, search: String) -> RxSwift.Observable<[Game]> {
        return repository.getGameDataPagination(pageSize: pageSize, page: page, search: search)
    }
}
