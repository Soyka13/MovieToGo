//
//  APIClient.swift
//  MovieToGo
//
//  Created by Olena Stepaniuk on 05.08.2024.
//

import Combine
import Foundation

protocol APIClientInterface {
    func fetch<T: Decodable>(with request: URLRequest?) -> AnyPublisher<T, APIError>
    func download(with request: URLRequest?) -> AnyPublisher<Data, APIError>
}

class APIClient: APIClientInterface {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetch<T: Decodable>(with request: URLRequest?) -> AnyPublisher<T, APIError> {
        guard let request = request else {
            return Fail(error: APIError.invalidRequest).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.requestFailed
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw APIError(statusCode: httpResponse.statusCode)
                }
                
                return data
            }
            .mapError { error in
                (error as? APIError) ?? .requestFailed
            }
            .flatMap { data in
                Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { _ in APIError.invalidData }
            }
            .eraseToAnyPublisher()
    }
    
    func download(with request: URLRequest?) -> AnyPublisher<Data, APIError> {
        guard let request = request else {
            return Fail(error: APIError.invalidRequest).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.requestFailed
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw APIError(statusCode: httpResponse.statusCode)
                }
                
                return data
            }
            .mapError { error in
                (error as? APIError) ?? .requestFailed
            }
            .eraseToAnyPublisher()
    }
    
    private func decode<T: Decodable>(data: Data, decodingType: T.Type) -> Result<T, APIError> {
        do {
            let decoder = JSONDecoder()
            let genericModel = try decoder.decode(T.self, from: data)
            return .success(genericModel)
        } catch {
            return .failure(.invalidData)
        }
    }
}
