//
//  MovieListCellViewModel.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 05.08.2024.
//

import UIKit
import Combine

class MovieListCellViewModel {
     
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
    
    @Published private(set) var poster: UIImage?
    
    private let movieUseCase: MovieUseCaseInterface
    private let movie: Movie
    
    private var loadImageItem: DispatchWorkItem?
    private var cancellables = Set<AnyCancellable>()
    
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
    
    init(movieUseCase: MovieUseCaseInterface, movie: Movie) {
        self.movieUseCase = movieUseCase
        self.movie = movie
        
        fetchPoster()
    }
    
    func fetchPoster() {
        guard let posterPath = movie.posterPath else { return }
        
        let currentLoadImageItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
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
        
        loadImageItem = currentLoadImageItem
        
        DispatchQueue.global(qos: .userInteractive).async(execute: currentLoadImageItem)
    }
    
    func cancelImageDownloading() {
        loadImageItem?.cancel()
    }
}
