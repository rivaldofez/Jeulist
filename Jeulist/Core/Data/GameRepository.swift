//
//  GameRepository.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import Foundation
import RxSwift

protocol GameRepositoryProtocol {
    func getGameDataPagination(pageSize: Int, page: Int, search: String) -> Observable<[Game]>
    func getGameDetail(id: Int) -> Observable<GameDetail>
    func getGameScreenshot(id: Int) -> Observable<[String]>
    func getFavoriteGameList() -> Observable<[GameDetail]>
    func saveToggleFavoriteGame(gameDetail: GameDetail) -> Observable<Bool>
    func getGameFavoriteById(id: Int) -> Observable<GameDetail?>
    
}

final class GameRepository: NSObject {
    typealias GameInstance = (RemoteDataSource, LocaleDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: GameInstance = { remoteDataSource, localeDataSource in
        return GameRepository(remote: remoteDataSource, locale: localeDataSource)
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getGameFavoriteById(id: Int) -> Observable<GameDetail?> {
        return self.locale.getFavoriteGameById(id: id)
            .map { gameDetailEntity in
                if let gameDetailEntity {
                    return GameMapper.mapGameDetailEntityToDomain(input: gameDetailEntity)
                } else {
                    return nil
                }
            }
    }
    
    func getFavoriteGameList() -> RxSwift.Observable<[GameDetail]> {
        return self.locale.getFavoriteGameList()
            .map {
                GameMapper.mapGameDetailEntitiesToDomain(input: $0)
            }
    }

    func saveToggleFavoriteGame(gameDetail: GameDetail) -> RxSwift.Observable<Bool> {
        return self.locale.saveToggleFavoriteGame(gameDetail: gameDetail)
    }
    
    func getGameScreenshot(id: Int) -> RxSwift.Observable<[String]> {
        return self.remote.getGameScreenshot(id: id).map{ $0.map{ $0.image }}
    }
    
    func getGameDetail(id: Int) -> RxSwift.Observable<GameDetail> {
        return self.remote.getGameDetail(id: id).map {
            GameMapper.mapGameDetailResponseToDomain(input: $0)
        }
    }
    
    func getGameDataPagination(pageSize: Int, page: Int, search: String) -> RxSwift.Observable<[Game]> {
        
        return self.remote.getGameDataPagination(pageSize: pageSize, page: page, search: search).map {
            GameMapper.mapGameItemResponseToDomain(input: $0)
        }
    }
    
    
}
