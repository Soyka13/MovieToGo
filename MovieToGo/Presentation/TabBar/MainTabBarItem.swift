//
//  MainTabBarItem.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit

enum MainTabBarItem {
    
    case home
    case favourite
    
    var title: String {
        switch self {
        case .home: return String(localized: "home_tab_name")
        case .favourite: return String(localized: "favourites_tab_name")
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home: return UIImage(named: UI.Images.home)
        case .favourite: return UIImage(named: UI.Images.favourites)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home: return UIImage(named: UI.Images.homeSelected)
        case .favourite: return UIImage(named: UI.Images.favouritesSelected)
        }
    }
    
    var uiTab: UITabBarItem {
        UITabBarItem(title: title, image: icon, selectedImage: selectedIcon)
    }
}
