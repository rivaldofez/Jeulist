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
        case gamePagination(pageSize: Int, page: Int, search: String)
        case gameDetail(Int)
        case gameScreenshot(Int)
        
        var url: String {
            switch self {
            case .gamePagination(let pageSize, let page, let search):
                let queryItems = [
                    URLQueryItem(name: "search", value: search.isEmpty ? nil : search),
                    URLQueryItem(name: "key", value: API.apiKey),
                    URLQueryItem(name: "page_size", value: String(pageSize) ),
                    URLQueryItem(name: "page", value: String(page))
                ]
                var urlComponents = URLComponents(string: "\(API.baseURL)games")
                urlComponents?.queryItems = queryItems
                
                return urlComponents?.url?.absoluteString ?? ""
                
            case .gameDetail(let id): return "\(API.baseURL)games/\(id)?key=\(API.apiKey)"
            case .gameScreenshot(let id): return "\(API.baseURL)games/\(id)/screenshots?key=\(API.apiKey)"
            }
        }
    }
}
