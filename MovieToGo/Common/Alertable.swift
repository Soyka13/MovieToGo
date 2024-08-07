//
//  Alertable.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    
    func showAlert(
        title: String = "",
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default, handler: nil)]
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
}
