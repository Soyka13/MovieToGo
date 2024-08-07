//
//  MovieDetailsCoordinator.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit

class MovieDetailsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private let movie: Movie
    private let useCaseType: MovieUseCaseType
    
    init(navigationController: UINavigationController, movie: Movie, useCaseType: MovieUseCaseType) {
        self.navigationController = navigationController
        self.movie = movie
        self.useCaseType = useCaseType
    }
    
    func start() {
        let viewModel = MovieDetailsViewModel(
            movieUseCase: MovieUseCase(
                remoteDataSource: MoviesRemoteDataSource(apiClient: APIClient()),
                useCaseType: useCaseType
            ),
            movie: movie
        )
        let movieDetailsVC = MovieDetailsViewController.instantiateViewController()
        movieDetailsVC.viewModel = viewModel
        navigationController.pushViewController(movieDetailsVC, animated: true)
    }
}
