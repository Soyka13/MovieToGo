//
//  APIError.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 05.08.2024.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    
    case notFound
    case requestFailed
    case invalidData
    case invalidRequest
    case unknown
    
    init(statusCode: Int) {
        switch statusCode {
        case 404:
            self = .notFound
        default:
            self = .unknown
        }
    }
    
    var description: String {
        switch self {
        case .notFound:
            return "The requested resource could not be found."
        case .requestFailed:
            return "The request failed. Please check your network connection or try again later."
        case .invalidData:
            return "The data received was invalid or corrupt."
        case .invalidRequest:
            return "The request was invalid. Please check the request parameters and try again."
        case .unknown:
            return "An unknown error occurred. Please try again later."
        }
    }
}
