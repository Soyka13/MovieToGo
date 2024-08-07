//
//  ImageEndpoint.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 05.08.2024.
//

import Foundation

enum ImageEndpoint {
    case loadImage(path: String)
}

extension ImageEndpoint: Endpoint {
    
    var baseURL: String {
        Environment.shared.imageBaseURLString
    }
    
    var path: String {
        switch self {
        case .loadImage(let path):
            return "/t/p/w500\(path)"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        [:]
    }
    
    var headers: [String : String]? {
        [:]
    }
}
