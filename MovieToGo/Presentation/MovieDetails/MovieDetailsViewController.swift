//
//  MovieDetailsViewController.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet weak var posterImageView: GradientImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    var viewModel: MovieDetailsViewModel?
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
        setupBindings()
    }
    
    @IBAction func playTapped(_ sender: Any) {
        showAlert(
            title: String(localized: "movie_alert_title"),
            message: titleLabel.text ?? ""
        )
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "", style: UIBarButtonItem.Style.plain,
            target: nil, action: #selector(UINavigationController.popViewController(animated:))
        )
        
        navigationItem.leftBarButtonItem?.image = UIImage(named: UI.Images.back)
        navigationItem.titleView = UIImageView(image: UIImage(named: UI.Images.logo))
        
        posterImageView.layer.cornerRadius = UI.Constants.imageCornerRadius
    }
    
    private func setupData() {
        titleLabel.text = viewModel?.title
        ratingLabel.text = "\(String(format: "%.1f", viewModel?.voteAverage ?? 0.0))"
        descriptionLabel.text = viewModel?.description
        releaseLabel.text = String(localized: "release") + ": " + "\(viewModel?.releaseDate ?? "")"
        
        viewModel?.fetchPoster()
    }
    
    private func setupBindings() {
        viewModel?.$poster
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.posterImageView.image = image
            }
            .store(in: &cancellables)
    }
}
