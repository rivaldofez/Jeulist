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
            let newGame = Game(
                id: gameItem.id,
                slug: gameItem.slug,
                name: gameItem.name,
                released: gameItem.released,
                tba: gameItem.tba,
                backgroundImage: gameItem.backgroundImage,
                rating: gameItem.rating,
                ratingTop: gameItem.ratingTop,
                ratingsCount: gameItem.ratingsCount,
                reviewsTextCount: gameItem.reviewsTextCount,
                added: gameItem.added,
                metaCritic: gameItem.metacritic,
                playTime: gameItem.playtime,
                suggestionCount: gameItem.suggestionsCount,
                updated: gameItem.updated,
                reviewsCount: gameItem.reviewsCount)
            
            return newGame
        }
    }
}
