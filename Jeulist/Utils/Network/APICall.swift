//
//  APICall.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import Foundation

struct API {
    static let baseURL = "https://api.rawg.io/api/"
    static let apiKey = "5d317fb7233a442181c90dca4b6a29e2"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case gamePagination
        case gameDetail(Int)
        
        var url: String {
            switch self {
            case .gamePagination: return "\(API.baseURL)games?key=\(API.apiKey)&page="
            case .gameDetail(let id): return "\(API.baseURL)games/\(id)/?key=\(API.apiKey)"
            }
        }
    }
}
