//
//  MainTabBarBuilder.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import Foundation

class MainTabBarBuilder {
    
    class func build() -> MainTabBarController {
        MainTabBarController(coordinators: buildCoordinators())
    }
    
    class func buildCoordinators() -> [Coordinator] {
        // Movie list
        let movieListCoordinator = MovieListCoordinator(useCaseType: .popular)
        movieListCoordinator.navigationController.tabBarItem = MainTabBarItem.home.uiTab
        movieListCoordinator.start()
        
        // Favourites
        let favouritesListCoordinator = MovieListCoordinator(useCaseType: .topRated)
        favouritesListCoordinator.navigationController.tabBarItem = MainTabBarItem.favourite.uiTab
        favouritesListCoordinator.start()
        
        return [movieListCoordinator, favouritesListCoordinator]
    }
}
