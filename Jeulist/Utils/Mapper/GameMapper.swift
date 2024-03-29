//
//  GameMapper.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import Foundation

final class GameMapper {
    static func mapGameDetailEntitiesToDomain(input: [GameDetailEntity]) -> [GameDetail] {
        return input.map { result in
            return mapGameDetailEntityToDomain(input: result)!
        }
    }
    
    static func mapGameDetailEntityToDomain(input entity: GameDetailEntity?) -> GameDetail? {
        
        if let entity = entity {
            return GameDetail(
                id: Int(entity.id),
                slug: entity.slug ?? "",
                name: entity.name ?? "",
                nameOriginal: entity.nameOriginal ?? "",
                description: entity.gameDescription ?? "",
                metacritic: Int(entity.metacritic),
                released: entity.released ?? "",
                tba: entity.tba,
                updated: entity.gameUpdated ?? "",
                backgroundImage: entity.backgroundImage ?? "",
                backgroundImageAdditional: entity.backgroundImageAdditional ?? "",
                website: entity.website ?? "",
                rating: entity.rating,
                ratingTop: Int(entity.ratingTop),
                added: Int(entity.added),
                playTime: Int(entity.playtime),
                screenshotsCount: Int(entity.screenshotsCount),
                moviesCount: Int(entity.moviesCount),
                creatorsCount: Int(entity.creatorsCount),
                achievementCount: Int(entity.achievementCount),
                parentAchievementCount: Int(entity.parentAchievementCount),
                redditURL: entity.redditUrl ?? "",
                redditName: entity.redditName ?? "",
                redditDescription: entity.redditDescription ?? "",
                redditLogo: entity.redditLogo ?? "",
                metacriticURL: entity.metacriticUrl ?? "",
                parentsCount: Int(entity.parentsCount),
                additionCount: Int(entity.additionCount),
                gameSeriesCount: Int(entity.gameSeriesCount),
                reviewCount: Int(entity.reviewCount),
                saturatedColor: entity.saturatedColor ?? "",
                dominantColor: entity.dominantColor ?? "",
                descriptionRaw: entity.descriptionRaw ?? "",
                parentPlatforms: entity.parentPlatforms?.components(separatedBy: ",") ?? [],
                publishers: entity.publishers ?? "",
                tags: entity.tags ?? "",
                developers: entity.developers ?? "",
                genres: entity.genres ?? "",
                isFavorite: entity.isFavorite
            )
        } else {
            return nil
        }
    }
    
    static func mapGameItemResponseToDomain(input gameItems: [GameItem]) -> [Game] {
        
        return gameItems.map { gameItem in
            
            let parentPlatforms: [Platform] = gameItem.parentPlatforms ?? []
            
            let newGame = Game(
                id: gameItem.id ?? 0,
                slug: gameItem.slug ?? "",
                name: gameItem.name ?? "",
                released: gameItem.released ?? "",
                tba: gameItem.tba ?? false,
                backgroundImage: gameItem.backgroundImage ?? "",
                rating: gameItem.rating ?? 0.0,
                ratingTop: gameItem.ratingTop ?? 0,
                ratingsCount: gameItem.ratingsCount ?? 0,
                reviewsTextCount: gameItem.reviewsTextCount ?? 0,
                metaCritic: gameItem.metacritic ?? 0,
                playTime: gameItem.playtime ?? 0,
                suggestionCount: gameItem.suggestionsCount ?? 0,
                updated: gameItem.updated ?? "",
                reviewsCount: gameItem.reviewsCount ?? 0,
                parentPlatforms: parentPlatforms.isEmpty ? [""] : parentPlatforms.map {
                    $0.platform?.name ?? ""
                }
            )
            
            return newGame
        }
    }
    
    static func mapGameDetailResponseToDomain(input gameDetailResponse: GameDetailResponse) -> GameDetail {
        let parentPlatforms: [ParentPlatform] = gameDetailResponse.parentPlatforms ?? []
        let publishers : [Component] = gameDetailResponse.publishers ?? []
        let tags: [Component] = gameDetailResponse.tags ?? []
        let developers : [Component] = gameDetailResponse.developers ?? []
        let genres: [Component]  = gameDetailResponse.genres ?? []
        
        return GameDetail(id: gameDetailResponse.id ?? 0,
                          slug: gameDetailResponse.slug ?? "",
                          name: gameDetailResponse.name ?? "",
                          nameOriginal: gameDetailResponse.nameOriginal ?? "",
                          description: gameDetailResponse.description ?? "",
                          metacritic: gameDetailResponse.metacritic ?? 0,
                          released: gameDetailResponse.released ?? "",
                          tba: gameDetailResponse.tba ?? false,
                          updated: gameDetailResponse.updated ?? "",
                          backgroundImage: gameDetailResponse.backgroundImage ?? "",
                          backgroundImageAdditional: gameDetailResponse.backgroundImageAdditional ?? "",
                          website: gameDetailResponse.website ?? "",
                          rating: gameDetailResponse.rating ?? 0.0,
                          ratingTop: gameDetailResponse.ratingTop ?? 0,
                          added: gameDetailResponse.added ?? 0,
                          playTime: gameDetailResponse.playtime ?? 0, screenshotsCount: 0,
                          moviesCount: gameDetailResponse.moviesCount ?? 0,
                          creatorsCount: gameDetailResponse.creatorsCount ?? 0,
                          achievementCount: gameDetailResponse.achievementsCount ?? 0,
                          parentAchievementCount: gameDetailResponse.parentAchievementsCount ?? 0,
                          redditURL: gameDetailResponse.redditURL ?? "",
                          redditName: gameDetailResponse.redditName ?? "",
                          redditDescription: gameDetailResponse.redditDescription ?? "",
                          redditLogo: gameDetailResponse.redditLogo ?? "",
                          metacriticURL: gameDetailResponse.metacriticURL ?? "",
                          parentsCount: gameDetailResponse.parentsCount ?? 0,
                          additionCount: gameDetailResponse.additionsCount ?? 0,
                          gameSeriesCount: gameDetailResponse.gameSeriesCount ?? 0,
                          reviewCount: gameDetailResponse.reviewsCount ?? 0,
                          saturatedColor: gameDetailResponse.saturatedColor ?? "",
                          dominantColor: gameDetailResponse.dominantColor ?? "",
                          descriptionRaw: gameDetailResponse.descriptionRaw ?? "",
                          parentPlatforms: parentPlatforms.isEmpty ? [""] : parentPlatforms.map {
            $0.platform?.name ?? ""},
                          publishers: publishers.isEmpty ? "" : publishers.map {
            $0.name ?? ""}.joined(separator: ", "),
                          tags: tags.isEmpty ? "" : tags.map {
            $0.name ?? ""}.joined(separator: ", "),
                          developers: developers.isEmpty ? "" : developers.map {
            $0.name ?? ""}.joined(separator: ", "),
                          genres: genres.isEmpty ? "" : genres.map {
            $0.name ?? ""}.joined(separator: ", "),
                          isFavorite: false
        )
    }
}
