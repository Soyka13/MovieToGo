//
//  StoryboardInstantiable.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 04.08.2024.
//

import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

extension StoryboardInstantiable where Self: UIViewController {
    
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = NSStringFromClass(Self.self).components(separatedBy: ".").last!
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        return storyboard.instantiateInitialViewController() as! Self
    }
}
