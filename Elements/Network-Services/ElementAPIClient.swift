//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Matthew Ramos on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementAPIClient {
    static func fetchElements (completion: @escaping (Result<[Element],AppError>) -> ()) {
        
        let elementEndPointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        guard let url = URL(string: elementEndPointURL) else {
            completion(.failure(.badURL(elementEndPointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    completion(.success(elements))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func fetchUserFavorites (completion: @escaping (Result<[Element],AppError>) -> ()) {
        
        let favoriteEndPointURL = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: favoriteEndPointURL) else {
            completion(.failure(.badURL(favoriteEndPointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let allFavorites = try JSONDecoder().decode([Element].self, from: data)
                    let userFavorites = allFavorites.filter { $0.favoritedBy == "Matthew Ramos"}
                    completion(.success(userFavorites))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func postElement (element: Element, completion: @escaping (Result<Bool, AppError>) -> ()) {
        
        let elementURLString = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: elementURLString) else {
            return
        }
        
        do {
            let data = try JSONEncoder().encode(element)
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            request.httpMethod = "POST"
            
            NetworkHelper.shared.performDataTask(with: request, completion: { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            })
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
}


