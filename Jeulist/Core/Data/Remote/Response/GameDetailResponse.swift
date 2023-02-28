//
//  GameDetailResponse.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 21/02/23.
//

import Foundation

struct GameDetailResponse: Codable {
    let id: Int
    let slug, name, nameOriginal, description: String
    let metacritic: Int
//    let metacriticPlatforms: [MetacriticPlatform]
    let released: String
    let tba: Bool
    let updated: String
    let backgroundImage, backgroundImageAdditional: String
    let website: String
    let rating: Double
    let ratingTop: Int
//    let ratings: [Rating]
//    let reactions: [String: Int]
    let added: Int
//    let addedByStatus: AddedByStatus
    let playtime, screenshotsCount, moviesCount, creatorsCount: Int
    let achievementsCount, parentAchievementsCount: Int
    let redditURL: String
    let redditName, redditDescription, redditLogo: String
    let redditCount, twitchCount, youtubeCount, reviewsTextCount: Int
    let ratingsCount, suggestionsCount: Int
    let alternativeNames: [String]
    let metacriticURL: String
    let parentsCount, additionsCount, gameSeriesCount: Int
//    let userGame: JSONNull?
    let reviewsCount: Int
    let saturatedColor, dominantColor: String
    let parentPlatforms: [ParentPlatform]
//    let platforms: [PlatformElement]
//    let stores: [Store]
    let developers, genres, tags, publishers: [SubObjectComponent]
//    let esrbRating: EsrbRating
    
    let clip: String?
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case description, metacritic
//        case metacriticPlatforms = "metacritic_platforms"
        case released, tba, updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
//        case ratings
//        case reactions
        case added
//        case addedByStatus = "added_by_status"
        case playtime
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditURL = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticURL = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
//        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
//        case platforms
//        case stores,
        case developers
        case genres, tags, publishers
//        case esrbRating = "esrb_rating"
        case clip
        case descriptionRaw = "description_raw"
    }
}

//// MARK: - AddedByStatus
//struct AddedByStatus: Codable {
//    let yet, owned, beaten, toplay: Int
//    let dropped, playing: Int
//}

// MARK: - Developer
struct SubObjectComponent: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?
//    let language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain
//        case language
    }
}

//struct Component: Codable {
//    let id: Int
//    let name, slug: String
//}


//enum Language: String, Codable {
//    case eng = "eng"
//}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int
    let name, slug: String
}

// MARK: - MetacriticPlatform
struct MetacriticPlatform: Codable {
    let metascore: Int
    let url: String
    let platform: MetacriticPlatformPlatform
}

// MARK: - MetacriticPlatformPlatform
struct MetacriticPlatformPlatform: Codable {
    let platform: Int
    let name, slug: String
}

 // MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: EsrbRating
}

//// MARK: - PlatformElement
//struct PlatformElement: Codable {
//    let platform: PlatformPlatform
//    let releasedAt: String
//    let requirements: Requirements
//
//    enum CodingKeys: String, CodingKey {
//        case platform
//        case releasedAt = "released_at"
//        case requirements
//    }
//}

// MARK: - PlatformPlatform
//struct PlatformPlatform: Codable {
//    let id: Int
//    let name, slug: String
//    let image, yearEnd: JSONNull?
//    let yearStart: Int?
//    let gamesCount: Int
//    let imageBackground: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, slug, image
//        case yearEnd = "year_end"
//        case yearStart = "year_start"
//        case gamesCount = "games_count"
//        case imageBackground = "image_background"
//    }
//}

//// MARK: - Requirements
//struct Requirements: Codable {
//    let minimum, recommended: String?
//}
//
//// MARK: - Rating
//struct Rating: Codable {
//    let id: Int
//    let title: String
//    let count: Int
//    let percent: Double
//}
//
//// MARK: - Store
//struct Store: Codable {
//    let id: Int
//    let url: String
//    let store: Developer
//}
