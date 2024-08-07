//
//  MovieUseCase.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 05.08.2024.
//

import Foundation
import Combine

protocol MovieUseCaseInterface {
    
    func getMovies(page: Int) -> AnyPublisher<MovieResult, APIError>
    func loadImage(with path: String) -> AnyPublisher<Data, APIError>
}

enum MovieUseCaseType {
    case topRated
    case popular
}

class MovieUseCase: MovieUseCaseInterface {
    
    private let remoteDataSource: MoviesRemoteDataSourceInterface
    private let useCaseType: MovieUseCaseType
    
    init(remoteDataSource: MoviesRemoteDataSourceInterface, useCaseType: MovieUseCaseType) {
        self.remoteDataSource = remoteDataSource
        self.useCaseType = useCaseType
    }
    
    func getMovies(page: Int) -> AnyPublisher<MovieResult, APIError> {
        switch useCaseType {
        case .topRated: return remoteDataSource.getTopRatedMovies(page: page)
        case .popular: return remoteDataSource.getPopularMovies(page: page)
        }
    }
    
    func loadImage(with path: String) -> AnyPublisher<Data, APIError> {
        remoteDataSource.loadImage(with: path)
    }
}
