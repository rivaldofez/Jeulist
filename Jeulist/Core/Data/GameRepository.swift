//
//  GameRepository.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import Foundation
import RxSwift

protocol GameRepositoryProtocol {
    func getGameDataPagination(page: Int) -> Observable<[Game]>
}

final class GameRepository: NSObject {
    typealias GameInstance = (RemoteDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { RemoteDataSource in
        return GameRepository(remote: RemoteDataSource)
    }
    
}

extension GameRepository: GameRepositoryProtocol {
    func getGameDataPagination(page: Int) -> RxSwift.Observable<[Game]> {
        
        return self.remote.getGameDataPagination(page: page).map { gameItem in
            <#code#>
        }
    }
    
    
}