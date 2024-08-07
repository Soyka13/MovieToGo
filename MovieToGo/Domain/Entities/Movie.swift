//
//  Movie.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import Foundation

struct MovieResult: Decodable {
    let results: [Movie]
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
}

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
