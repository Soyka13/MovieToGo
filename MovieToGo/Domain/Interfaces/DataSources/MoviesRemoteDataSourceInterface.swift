//
//  MoviesDataSourceInterface.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 05.08.2024.
//

import Foundation
import Combine

protocol MoviesRemoteDataSourceInterface {
    
    func getTopRatedMovies(page: Int) -> AnyPublisher<MovieResult, APIError>
    func getPopularMovies(page: Int) -> AnyPublisher<MovieResult, APIError>
    func loadImage(with path: String) -> AnyPublisher<Data, APIError>
}
