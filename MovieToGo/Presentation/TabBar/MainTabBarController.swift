//
//  MainTabBarController.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit

fileprivate let mainTabBarControllerNibName = "MainTabBarController"

final class MainTabBarController: UITabBarController {
    
    private let coordinators: [Coordinator]
    
    init(coordinators: [Coordinator]) {
        self.coordinators = coordinators
        super.init(nibName: mainTabBarControllerNibName, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        tabBar.backgroundColor = .white
        viewControllers = coordinators.map { $0.navigationController }
    }
}
