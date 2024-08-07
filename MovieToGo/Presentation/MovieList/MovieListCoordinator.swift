//
//  MovieListCoordinator.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit
import Combine

class MovieListCoordinator: Coordinator {
    
    let navigationController: UINavigationController = {
        let navController = UINavigationController()
        navController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: UI.Colors.accentColor) ?? .orange
        ]
        return navController
    }()
    
    var useCaseType: MovieUseCaseType
    
    init(useCaseType: MovieUseCaseType) {
        self.useCaseType = useCaseType
    }
    
    private weak var movieListVC: MovieListViewController?
    
    private var cancellables = Set<AnyCancellable>()
    
    func start() {
        let viewModel = MovieListViewModel(
            movieUseCase: MovieUseCase(
                remoteDataSource: MoviesRemoteDataSource(apiClient: APIClient()),
                useCaseType: useCaseType
            )
        )
        
        let movieListVC = MovieListViewController.instantiateViewController()
        movieListVC.viewModel = viewModel
        navigationController.pushViewController(movieListVC, animated: true)
        
        self.movieListVC = movieListVC
        observeSelectedMovie()
    }
    
    private func observeSelectedMovie() {
        movieListVC?.viewModel?.selectedMovieObserver
            .compactMap { $0 }
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] movie in
                self?.showDetail(for: movie)
            })
            .store(in: &cancellables)
    }
    
    private func showDetail(for movie: Movie) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(
            navigationController: navigationController,
            movie: movie,
            useCaseType: useCaseType
        )
        
        movieDetailsCoordinator.start()
    }
}
