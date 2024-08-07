//
//  UIView+Extensions.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit

extension UIImageView {

    func makeGradient(with colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.contents = self.image?.cgImage
        gradient.colors = colors
        gradient.type = .axial
        self.layer.addSublayer(gradient)
    }
}
