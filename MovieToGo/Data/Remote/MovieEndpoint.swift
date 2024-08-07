//
//  MovieEndpoint.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 05.08.2024.
//

import Foundation

enum MovieEndpoint {
    case getTopRated(page: Int)
    case getPopular(page: Int)
}

extension MovieEndpoint: Endpoint {
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getTopRated(let page), .getPopular(page: let page):
            return ["api_key": apiKey, "language": "en-US", "page": page]
        }
    }
    
    var path: String {
        switch self {
        case .getTopRated(_):
            return "/3/movie/top_rated"
        case .getPopular(_):
            return "/3/movie/popular"
        }
    }
}
