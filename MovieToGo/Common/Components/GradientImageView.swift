//
//  GradientImageView.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit

class GradientImageView: UIImageView {
    
    // Properties to customize the gradient
    var gradientColors: [CGColor] = [
        UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1).cgColor,  // rgba(34, 34, 34, 1)
        UIColor(red: 0.396, green: 0.396, blue: 0.396, alpha: 0).cgColor   // rgba(101, 101, 101, 0)
    ]
    
    var gradientLocations: [NSNumber] = [0.5, 0.9]
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        gradientLayer.frame = frame
        gradientLayer.frame.origin = .zero
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        
        gradientLayer.opacity = 0.8
        layer.insertSublayer(gradientLayer, above: layer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
