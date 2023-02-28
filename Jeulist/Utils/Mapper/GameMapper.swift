//
//  GameMapper.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import Foundation

final class GameMapper {
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
                parentPlatforms: parentPlatforms.isEmpty ? [""] : parentPlatforms.map{
                    $0.platform?.name ?? ""
                }
                    
//                    gameItem.parentPlatforms.map { $0.platform.platform } as! [String]
            )
            
            return newGame
        }
    }
    
    static func mapGameDetailResponseToDomain(input gameDetailResponse: GameDetailResponse) -> GameDetail {
        return GameDetail(id: gameDetailResponse.id,
                          slug: gameDetailResponse.slug,
                          name: gameDetailResponse.name,
                          nameOriginal: gameDetailResponse.nameOriginal,
                          description: gameDetailResponse.description,
                          metacritic: gameDetailResponse.metacritic,
                          released: gameDetailResponse.released,
                          tba: gameDetailResponse.tba,
                          updated: gameDetailResponse.updated,
                          backgroundImage: gameDetailResponse.backgroundImage,
                          backgroundImageAdditional: gameDetailResponse.backgroundImageAdditional,
                          website: gameDetailResponse.website,
                          rating: gameDetailResponse.rating,
                          ratingTop: gameDetailResponse.ratingTop,
                          added: gameDetailResponse.added,
                          playTime: gameDetailResponse.playtime,
                          screenshotsCount: gameDetailResponse.screenshotsCount,
                          moviesCount: gameDetailResponse.moviesCount,
                          creatorsCount: gameDetailResponse.creatorsCount,
                          achievementCount: gameDetailResponse.achievementsCount,
                          parentAchievementCount: gameDetailResponse.parentAchievementsCount,
                          redditURL: gameDetailResponse.redditURL,
                          redditName: gameDetailResponse.redditName,
                          redditDescription: gameDetailResponse.redditDescription,
                          redditLogo: gameDetailResponse.redditLogo,
                          redditCount: gameDetailResponse.redditCount,
                          suggestionCount: gameDetailResponse.suggestionsCount,
                          metacriticURL: gameDetailResponse.metacriticURL,
                          parentsCount: gameDetailResponse.parentsCount,
                          additionCount: gameDetailResponse.additionsCount,
                          gameSeriesCount: gameDetailResponse.gameSeriesCount,
                          reviewCount: gameDetailResponse.reviewsCount,
                          saturatedColor: gameDetailResponse.saturatedColor,
                          dominantColor: gameDetailResponse.dominantColor,
                          descriptionRaw: gameDetailResponse.descriptionRaw,
                          parentPlatforms: gameDetailResponse.parentPlatforms.map { $0.platform.name },
                          publishers: gameDetailResponse.publishers.map{ $0.name }.joined(separator: ", "),
                          tags: gameDetailResponse.tags.map{ $0.name }.joined(separator: ", "),
                          developers: gameDetailResponse.developers.map{ $0.name }.joined(separator: ", "),
                          genres: gameDetailResponse.genres.map{ $0.name }.joined(separator: ", ")
                          
                          
        )
    }
}
