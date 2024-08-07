//
//  Environment.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 05.08.2024.
//

import Foundation

final class Environment {
    
    static let shared = Environment()
    
    let apiKey = "ed0957c3c3f2acb89d27b394e9612d5e"
    
    var baseURLString: String {
        "https://api.themoviedb.org"
    }
    
    var imageBaseURLString: String {
        "https://image.tmdb.org"
    }
    
    private init() {}
}
