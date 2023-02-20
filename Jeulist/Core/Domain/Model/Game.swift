//
//  Game.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import Foundation

struct Game: Identifiable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratingsCount: Int
    let reviewsTextCount: Int
    let added: Int
    let metaCritic: Int
    let playTime: Int
    let suggestionCount: Int
    let updated: String
    let reviewsCount: Int
}
