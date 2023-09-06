//
//  ScreenshotResponse.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 24/02/23.
//

import Foundation

struct ScreenshotResponse: Codable {
    let count: Int
    let next, previous: String?
    let results: [ScreenshotItem ]
}

struct ScreenshotItem: Codable {
    let id: Int
    let image: String
    let width, height: Int
    let isDeleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, image, width, height
        case isDeleted = "is_deleted"
    }
}
