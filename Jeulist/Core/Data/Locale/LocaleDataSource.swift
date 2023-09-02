//
//  LocaleDataSource.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 01/09/23.
//

import Foundation
import CoreData
import RxSwift
import UIKit


protocol LocaleDataSourceProtocol: AnyObject {
    func getFavoriteGameList() -> Observable<[GameDetailEntity]>
    func saveToggleFavoriteGame(gameDetail: GameDetail) -> Observable<Bool>
    func getFavoriteGameById(id: Int) -> Observable<GameDetailEntity?>
}

final class LocaleDataSource: NSObject {
    static let shared = LocaleDataSource()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getFavoriteGameList() -> Observable<[GameDetailEntity]> {
        return Observable<[GameDetailEntity]>.create { observer in
            if let context = self.appDelegate?.persistentContainer.viewContext {
                
                let request = GameDetailEntity.fetchRequest()
                
                do {
                    let gameDetailList = try context.fetch(request)
                    observer.onNext(gameDetailList)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
                
                
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    func saveToggleFavoriteGame(gameDetail: GameDetail) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let context = self.appDelegate?.persistentContainer.viewContext {
                let entity = GameDetailEntity(context: context)
                entity.id = Int64(gameDetail.id)
                entity.slug = gameDetail.slug
                entity.name = gameDetail.name
                entity.nameOriginal = gameDetail.nameOriginal
                entity.gameDescription = gameDetail.description
                entity.metacritic = Int16(gameDetail.metacritic)
                entity.released = gameDetail.released
                entity.tba = gameDetail.tba
                entity.gameUpdated = gameDetail.updated
                entity.backgroundImage = gameDetail.backgroundImage
                entity.backgroundImageAdditional = gameDetail.backgroundImageAdditional
                entity.website = gameDetail.website
                entity.rating = gameDetail.rating
                entity.ratingTop = Int16(gameDetail.ratingTop)
                entity.added = Int16(gameDetail.added)
                entity.playtime = Int16(gameDetail.playTime)
                entity.screenshotsCount = Int16(gameDetail.screenshotsCount)
                entity.moviesCount = Int16(gameDetail.moviesCount)
                entity.creatorsCount = Int16(gameDetail.creatorsCount)
                entity.achievementCount = Int16(gameDetail.achievementCount)
                entity.parentAchievementCount = Int16(gameDetail.parentAchievementCount)
                entity.redditUrl = gameDetail.redditURL
                entity.redditName = gameDetail.redditName
                entity.redditDescription = gameDetail.redditDescription
                entity.redditLogo = gameDetail.redditLogo
                entity.metacriticUrl = gameDetail.metacriticURL
                entity.parentsCount = Int16(gameDetail.parentsCount)
                entity.additionCount = Int16(gameDetail.additionCount)
                entity.gameSeriesCount = Int16(gameDetail.gameSeriesCount)
                entity.reviewCount = Int16(gameDetail.reviewCount)
                entity.saturatedColor = gameDetail.saturatedColor
                entity.dominantColor = gameDetail.dominantColor
                entity.descriptionRaw = gameDetail.description
                entity.parentPlatforms = gameDetail.parentPlatforms.joined(separator: ",")
                entity.publishers = gameDetail.publishers
                entity.tags = gameDetail.tags
                entity.developers = gameDetail.developers
                entity.genres = gameDetail.genres
                
                do {
                    try context.save()
                    observer.onNext(true)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    func getFavoriteGameById(id: Int) -> Observable<GameDetailEntity?> {
        return Observable<GameDetailEntity?>.create { observer in
            if let context = self.appDelegate?.persistentContainer.viewContext {
                let request = GameDetailEntity.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", id)
                
                do {
                    let result = try context.fetch(request).first
                    observer.onNext(result)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    
}
