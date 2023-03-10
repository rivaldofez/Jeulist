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
    //   let addedByStatus: AddedByStatus?
    let metacritic: Int?
    let suggestionsCount: Int?
    let updated: String?
    let id: Int?
    let score: String?
       let tags: [Tag]?
//    let esrbRating: EsrbRating?
    //   let userGame: JSONNull?
    let reviewsCount: Int?
    let communityRating: Int?
    //   let saturatedColor, dominantColor: Color?
    //   let shortScreenshots: [ShortScreenshot]?
       let parentPlatforms: [Platform]?
//       let genres: [Genre]?
    
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
        //       case addedByStatus = "added_by_status"
        case metacritic
        case suggestionsCount = "suggestions_count"
        case updated, id, score
        //       case clip
               case tags
//        case esrbRating = "esrb_rating"
        //       case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case communityRating = "community_rating"
        //       case saturatedColor = "saturated_color"
        //       case dominantColor = "dominant_color"
        //       case shortScreenshots = "short_screenshots"
               case parentPlatforms = "parent_platforms"
//               case genres
    }
}

//// MARK: - AddedByStatus
//struct AddedByStatus: Codable {
//   let owned, toplay, yet, beaten: Int?
//   let dropped, playing: Int?
//}
//
//enum Color: String, Codable {
//   case the0F0F0F = "0f0f0f"
//}

//// MARK: - EsrbRating
//struct EsrbRating: Codable {
//    let id: Int?
//    let name, slug, nameEn, nameRu: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, slug
//        case nameEn = "name_en"
//        case nameRu = "name_ru"
//    }
//}

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

//enum Title: String, Codable {
//   case exceptional = "exceptional"
//   case meh = "meh"
//   case recommended = "recommended"
//   case skip = "skip"
//}

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
//   let language: Language?
   let gamesCount: Int?
   let imageBackground: String?

   enum CodingKeys: String, CodingKey {
       case id, name, slug
//            case language
       case gamesCount = "games_count"
       case imageBackground = "image_background"
   }
}

//enum Language: String, Codable {
//   case eng = "eng"
//   case rus = "rus"
//}
