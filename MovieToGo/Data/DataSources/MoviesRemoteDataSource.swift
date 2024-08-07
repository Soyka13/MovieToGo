//
//  MoviesDataSource.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 05.08.2024.
//

import Foundation
import Combine

class MoviesRemoteDataSource: MoviesRemoteDataSourceInterface {
    
    private let apiClient: APIClientInterface
    
    init(apiClient: APIClientInterface) {
        self.apiClient = apiClient
    }
    
    func getTopRatedMovies(page: Int) -> AnyPublisher<MovieResult, APIError> {
        let request = MovieEndpoint.getTopRated(page: page).request
        return apiClient.fetch(with: request)
    }
    
    func getPopularMovies(page: Int) -> AnyPublisher<MovieResult, APIError> {
        let request = MovieEndpoint.getPopular(page: page).request
        return apiClient.fetch(with: request)
    }
    
    func loadImage(with path: String) -> AnyPublisher<Data, APIError> {
        let request = ImageEndpoint.loadImage(path: path).request
        return apiClient.download(with: request)
    }
}
