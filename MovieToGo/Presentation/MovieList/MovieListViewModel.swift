//
//  MovieListViewModel.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit
import Combine

final class MovieListViewModel: ObservableObject {
    
    @Published private(set) var isLoading = false
    @Published private(set) var publishedIndexPaths: Result<[IndexPath], APIError>?
    
    let selectedMovieObserver = PassthroughSubject<Movie, Never>()
    
    private(set) var movies: [Movie] = []
    
    var movieCells: [MovieListCellViewModel] {
        movies.map { MovieListCellViewModel(movieUseCase: movieUseCase, movie: $0) }
    }
    
    private let movieUseCase: MovieUseCaseInterface
    
    private var currentPage = 1
    private var totalPages = 1
    
    private var cancellables = Set<AnyCancellable>()
    
    init(movieUseCase: MovieUseCaseInterface) {
        self.movieUseCase = movieUseCase
    }
    
    func fetchMovies(isRefreshing: Bool = false) {
        if isRefreshing {
            reset()
        }
        
        guard !isLoading && currentPage <= totalPages else {
            return
        }
        
        isLoading = true
        
        movieUseCase.getMovies(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.publishedIndexPaths = .failure(error)
                }
            } receiveValue: { [weak self] movieResult in
                guard let self = self else { return }
                
                self.movies.append(contentsOf: movieResult.results)
                
                let indexPaths = (self.movies.count - movieResult.results.count ..< self.movies.count)
                    .map { IndexPath(row: $0, section: 0) }
                
                self.publishedIndexPaths = .success(indexPaths)
                
                self.currentPage += 1
                
                if let totalPages = movieResult.totalPages {
                    self.totalPages = totalPages
                }
                
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func didSelectItem(at index: Int) {
        selectedMovieObserver.send(movies[index])
    }
    
    private func reset() {
        movies = []
        publishedIndexPaths = .success([])
        currentPage = 1
        totalPages = 1
    }
}
