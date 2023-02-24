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
    func getGameDetail(id: Int) -> Observable<GameDetail>
    func getGameScreenshot(id: Int) -> Observable<[String]>
    
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
    func getGameScreenshot(id: Int) -> RxSwift.Observable<[String]> {
        return self.remote.getGameScreenshot(id: id).map{ $0.map{ $0.image }}
    }
    
    func getGameDetail(id: Int) -> RxSwift.Observable<GameDetail> {
        return self.remote.getGameDetail(id: id).map {
            GameMapper.mapGameDetailResponseToDomain(input: $0)
        }
    }
    
    func getGameDataPagination(page: Int) -> RxSwift.Observable<[Game]> {
        
        return self.remote.getGameDataPagination(page: page).map {
            GameMapper.mapGameItemResponseToDomain(input: $0)
        }
    }
    
    
}
