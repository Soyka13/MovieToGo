//
//  MovieListViewController.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit
import Combine

class MovieListViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MovieListViewModel?
    
    private let refreshControl = UIRefreshControl()
    
    private lazy var footerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.isHidden = false
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.frame.width, height: 44)
        return spinner
    }()
    
    private var isRefreshing = false
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBindings()
        viewModel?.fetchMovies()
    }
    
    private func setup() {
        navigationItem.titleView = UIImageView(image: UIImage(named: UI.Images.logo))
        view.backgroundColor = UIColor(named: UI.Colors.backgroundColor)
        
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        
        tableView.register(MovieListCell.nib, forCellReuseIdentifier: MovieListCell.identifier)
        tableView.addSubview(refreshControl)
    }
    
    private func setupBindings() {
        viewModel?.$publishedIndexPaths
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.tableView.tableFooterView = nil
                
                switch result {
                case .success(let indexPaths):
                    if self.isRefreshing {
                        self.tableView.reloadData()
                        self.isRefreshing = false
                    } else {
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: indexPaths, with: .bottom)
                        self.tableView.endUpdates()
                    }
                case .failure(let error):
                    self.showAlert(title: String(localized: "error_alert_title"), message: error.description)
                case .none:
                    break
                }
            })
            .store(in: &cancellables)
    }
    
    @objc private func reload() {
        isRefreshing = true
        refreshControl.endRefreshing()
        viewModel?.fetchMovies(isRefreshing: true)
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieListCell.identifier,
            for: indexPath
        ) as? MovieListCell else {
            return UITableViewCell()
        }
        
        if let movieCells = viewModel?.movieCells, !movieCells.isEmpty {
            cell.viewModel = movieCells[indexPath.row]
        }
        
        return cell
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        
        if indexPath.row == viewModel.movies.count - 2 {
            tableView.tableFooterView = footerView
            viewModel.fetchMovies()
        }
    }
}
