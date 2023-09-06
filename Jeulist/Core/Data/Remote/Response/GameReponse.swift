//
//  GameSearchResponses.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 25/02/23.
//

import Foundation

// MARK: - GameSearchResponse
struct GameResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameItem]?
    
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

// MARK: - Result
struct GameItem: Codable {
    let slug: String?
    let name: String?
    let playtime: Int?
    let platforms: [Platform]?
    let stores: [Store]?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount: Int?
    let reviewsTextCount: Int?
    let added: Int?
    let metacritic: Int?
    let suggestionsCount: Int?
    let updated: String?
    let id: Int?
    let score: String?
    let tags: [Tag]?
    let reviewsCount: Int?
    let communityRating: Int?
    let parentPlatforms: [Platform]?
    
    enum CodingKeys: String, CodingKey {
        case slug, name, playtime
        case platforms
        case stores
        case released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic
        case suggestionsCount = "suggestions_count"
        case updated, id, score
        case tags
        case reviewsCount = "reviews_count"
        case communityRating = "community_rating"
        case parentPlatforms = "parent_platforms"
    }
}

// MARK: - Platform
struct Platform: Codable {
    let platform: Component?
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int?
    //   let title: Title?
    let count: Int?
    let percent: Double?
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int?
    let image: String?
}

// MARK: - Store
struct Store: Codable {
    let store: Component?
}

// MARK: - Tag
struct Tag: Codable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
