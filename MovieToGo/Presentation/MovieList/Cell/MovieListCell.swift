//
//  MovieListCell.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit
import Combine

class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var movieCell: UIView!
    @IBOutlet weak var backgroundCellView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel: MovieListCellViewModel? {
        didSet {
            setupData()
            setupBindings()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        "MovieListCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundCellView.layer.cornerRadius = UI.Constants.cellCornerRadius
        posterImageView.layer.cornerRadius = UI.Constants.imageCornerRadius
        
        selectionStyle = .none
    }
    
    private func setupBindings() {
        viewModel?.$poster
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.posterImageView.image = image
            }
            .store(in: &cancellables)
    }
    
    private func setupData() {
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        releaseDateLabel.text = String(localized: "release") + ": " + "\(viewModel?.releaseDate ?? "")"
    }
    
    private func reset() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        posterImageView.image = UIImage(systemName: "photo")
        releaseDateLabel.text = nil
        
        viewModel?.cancelImageDownloading()
    }
}
