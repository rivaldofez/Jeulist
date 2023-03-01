//
//  GameDetail.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 21/02/23.
//

import Foundation

struct GameDetail: Identifiable {
    let id: Int
    let slug: String
    let name: String
    let nameOriginal: String
    let description: String
    let metacritic: Int
    let released: String
    let tba: Bool
    let updated: String
    let backgroundImage: String
    let backgroundImageAdditional: String
    let website: String
    let rating: Double
    let ratingTop: Int
    let added: Int
    let playTime: Int
    let screenshotsCount: Int
    let moviesCount: Int
    let creatorsCount: Int
    let achievementCount: Int
    let parentAchievementCount: Int
    let redditURL: String
    let redditName: String
    let redditDescription: String
    let redditLogo: String
    let metacriticURL: String
    let parentsCount: Int
    let additionCount: Int
    let gameSeriesCount: Int
    let reviewCount: Int
    let saturatedColor: String
    let dominantColor: String
    let descriptionRaw: String
    let parentPlatforms: [String]
    let publishers: String
    let tags: String
    let developers: String
    let genres: String
}
