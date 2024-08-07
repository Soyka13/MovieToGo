//
//  MovieDetailsViewModel.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit
import Combine

class MovieDetailsViewModel {
    
    @Published private(set) var poster: UIImage?
    
    var title: String? {
        movie.title
    }
    
    var description: String? {
        movie.overview
    }
    
    var releaseDate: String? {
        if let releaseDate = inputDateFormatter.date(from: movie.releaseDate ?? "") {
            return outputDateFormatter.string(from: releaseDate)
        }
        
        return nil
    }
    
    var voteAverage: Double? {
        movie.voteAverage
    }
    
    private let movie: Movie
    
    private let movieUseCase: MovieUseCaseInterface
    
    private let inputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        return formatter
    }()
    
    private let outputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "DD.MM.YYYY"
        return formatter
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(movieUseCase: MovieUseCaseInterface, movie: Movie) {
        self.movie = movie
        self.movieUseCase = movieUseCase
    }
    
    func fetchPoster() {
        guard let posterPath = movie.backdropPath else { return }
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.movieUseCase
                .loadImage(with: posterPath)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    if case .failure(let error) = completion {
                        print(error.description)
                    }
                } receiveValue: { [weak self] data in
                    self?.poster = UIImage(data: data)
                }
                .store(in: &self.cancellables)
        }
    }
}
